package controller;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(urlPatterns = {"/RegisterUser"})
public class RegisterUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // ----- Fetch Form Fields -----
        String name = request.getParameter("userName");
        String email = request.getParameter("userEmail");
        String phone = request.getParameter("userPhone");
        String gender = request.getParameter("userGender");
        String password = request.getParameter("userPassword");

        // ----- Validation -----
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || gender == null || gender.trim().isEmpty()) {

            request.setAttribute("errorMsg", "❌ All fields are required!");
            request.getRequestDispatcher("RegisterUser.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // ----- DB Connection -----
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/turf_booking?useSSL=false",
                    "root", "password@mysql"
            );
            conn.setAutoCommit(false);

            // ----- Email Duplication Check -----
            String emailCheckQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
            ps = conn.prepareStatement(emailCheckQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();
            rs.next();

            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMsg", "⚠️ Email already registered!");
                request.getRequestDispatcher("RegisterUser.jsp").forward(request, response);
                return;
            }
            rs.close();
            ps.close();

            // ----- Generate Unique user_id (USR001, USR002) -----
            String lastIdQuery = "SELECT user_id FROM users ORDER BY sr_no DESC LIMIT 1";
            ps = conn.prepareStatement(lastIdQuery);
            rs = ps.executeQuery();

            String userId = "USR001";
            if (rs.next()) {
                String lastId = rs.getString("user_id").substring(3); // remove USR
                int newId = Integer.parseInt(lastId) + 1;
                userId = "USR" + String.format("%03d", newId);
            }
            rs.close();
            ps.close();

            // ----- Insert User Data -----
            String insertSQL = "INSERT INTO users (user_id, name, email, phone, password, gender) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(insertSQL);
            ps.setString(1, userId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            ps.setString(5, hashedPassword);

            ps.setString(6, gender);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                conn.commit();

                response.getWriter().println(
                        "<h3>✅ Registration Successful!</h3>"
                        + "<p>Your User ID: <b>" + userId + "</b></p>"
                        + "<p>You can now <a href='LoginUser.jsp'>Login</a>.</p>"
                );
            } else {
                conn.rollback();
                request.setAttribute("errorMsg", "❌ Registration failed, try again!");
                request.getRequestDispatcher("RegisterUser.jsp").forward(request, response);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ignored) {
            }
            request.setAttribute("errorMsg", "🚫 Server Error: " + ex.getMessage());
            request.getRequestDispatcher("RegisterUser.jsp").forward(request, response);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ignored) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ignored) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ignored) {
            }
        }
    }
}
