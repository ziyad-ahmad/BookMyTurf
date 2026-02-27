package controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.mindrot.jbcrypt.BCrypt;

import util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("UserLogin.jsp?error=empty");
            return;
        }

        // ✅ SUPER ADMIN
        if ("superadmin@gmail.com".equals(email) && "admin123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "superadmin");
            session.setAttribute("name", "Super Admin");
            response.sendRedirect("SuperAdmin.jsp"); // recommended
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            
             // ======================================
            // ✅ NORMAL USER LOGIN (BCrypt encrypted)
            // ======================================
            String userSql = "SELECT user_id, name, password FROM users WHERE email=?";
            PreparedStatement userPs = con.prepareStatement(userSql);
            userPs.setString(1, email);
            ResultSet userRs = userPs.executeQuery();

               if (userRs.next()) {

                String hashedPassword = userRs.getString("password");

                if (hashedPassword != null && BCrypt.checkpw(password, hashedPassword)) {

                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", userRs.getString("user_id"));
                    session.setAttribute("name", userRs.getString("name"));
                    session.setAttribute("role", "user");

                    response.sendRedirect("UserDashboardServlet");
                    return;
                    } else {
                    response.sendRedirect("UserLogin.jsp?error=invalid");
                    return;
                }
            }

            // ✅ TURF OWNER LOGIN
            String turfSql = "SELECT * FROM turf_registration WHERE email=? AND password=?";
            PreparedStatement turfPs = con.prepareStatement(turfSql);
            turfPs.setString(1, email);
            turfPs.setString(2, password);
            ResultSet turfRs = turfPs.executeQuery();

            if (turfRs.next()) {
                String status = turfRs.getString("approval_status");

                if (!"Approved".equalsIgnoreCase(status)) {
                    response.getWriter().println(
                        "<h3>Your turf is under admin review. Please wait for approval.</h3>");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("turf_user_id", turfRs.getString("turf_user_id"));
                session.setAttribute("turf_name", turfRs.getString("turf_name"));
                session.setAttribute("role", "turf_owner");

                response.sendRedirect("OwnerDashboard");
                return;
            }

            // ❌ INVALID LOGIN
            response.sendRedirect("LoginUser.jsp?error=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LoginUser.jsp?error=db");
        }
    }
}
