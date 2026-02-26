package controller;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet(urlPatterns = {"/RegisterUser"})
public class RegisterUser extends HttpServlet {

    private boolean sendConfirmationEmail(String toEmail, String userId, String name) {

        final String fromEmail = "personal.one0371@gmail.com";
        final String password = "gormsmcozvmizfwu"; // Gmail App Password

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new jakarta.mail.Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {

            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(fromEmail, "Turf Booking"));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            message.setSubject("Registration Successful");

            message.setText(
                    "Hello " + name + ",\n\n"
                    + "Your registration was successful.\n"
                    + "Your User ID is: " + userId + "\n\n"
                    + "You can login now.\n\n"
                    + "Turf Booking Team"
            );

            Transport.send(message);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

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

            // Send confirmation email
            boolean emailSent = sendConfirmationEmail(email, userId, name);

            if (!emailSent) {
                request.setAttribute("errorMsg", "❌ Email sending failed!");
                request.getRequestDispatcher("RegisterUser.jsp").forward(request, response);
                return;
            }

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
                       " <script>"+
                        "alert('Registration Successful!! Check your email  Your User ID: "+userId+"');"
                        + "window.location='LoginUser.jsp';"
                        + "</script>"
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
