package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(urlPatterns = {"/TurfRegister"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 5,       // 5MB per file
        maxRequestSize = 1024 * 1024 * 20    // 20MB total form
)
public class TurfRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // ✅ Correct upload path for GlassFish (deployed app folder)
        String appPath = request.getServletContext().getRealPath("");
        File uploadDir = new File(appPath, "uploads");
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // --- Get form data ---
        String ownerName = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String turfName = request.getParameter("turfName");
        String turfAddress = request.getParameter("turfAddress");
        String turfPhone = request.getParameter("turfPhone");
        String pricePerHour = request.getParameter("pricePerHour");
        String upiId = request.getParameter("upiId");
        String accountNumber = request.getParameter("accountNumber");
        String bankName = request.getParameter("bankName");
        String ifscCode = request.getParameter("ifscCode");

        if (ownerName == null || ownerName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || turfName == null || turfName.trim().isEmpty()
                || turfAddress == null || turfAddress.trim().isEmpty()
                || turfPhone == null || turfPhone.trim().isEmpty()
                || pricePerHour == null || pricePerHour.trim().isEmpty()
                || upiId == null || upiId.trim().isEmpty()
                || accountNumber == null || accountNumber.trim().isEmpty()
                || bankName == null || bankName.trim().isEmpty()
                || ifscCode == null || ifscCode.trim().isEmpty()) {

            request.setAttribute("errorMsg", "❌ All fields are required.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement psTurf = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/turf_booking?useSSL=false",
                    "root", "password@mysql");
            conn.setAutoCommit(false);

            // --- Generate unique turf_user_id ---
            String cleanedTurfName = turfName.replaceAll("\\s+", "");
            String turfUserId = "";
            boolean exists = true;

            while (exists) {
                int randomNum = (int) (Math.random() * 9000) + 1000;
                turfUserId = cleanedTurfName + randomNum;

                PreparedStatement checkPs = conn.prepareStatement(
                        "SELECT COUNT(*) FROM turf_registration WHERE turf_user_id = ?");
                checkPs.setString(1, turfUserId);
                ResultSet rsCheck = checkPs.executeQuery();
                rsCheck.next();
                exists = rsCheck.getInt(1) > 0;
                rsCheck.close();
                checkPs.close();
            }

            // --- Insert turf ---
            String sqlTurf = "INSERT INTO turf_registration "
                    + "(turf_user_id, owner_name, email, password, turf_name, turf_address, turf_phone, price_per_hour, upi_id, account_number, bank_name, ifsc_code) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            psTurf = conn.prepareStatement(sqlTurf, Statement.RETURN_GENERATED_KEYS);
            psTurf.setString(1, turfUserId);
            psTurf.setString(2, ownerName);
            psTurf.setString(3, email);
            psTurf.setString(4, password);
            psTurf.setString(5, turfName);
            psTurf.setString(6, turfAddress);
            psTurf.setString(7, turfPhone);
            psTurf.setBigDecimal(8, new java.math.BigDecimal(pricePerHour));
            psTurf.setString(9, upiId);
            psTurf.setString(10, accountNumber);
            psTurf.setString(11, bankName);
            psTurf.setString(12, ifscCode);

            int rows = psTurf.executeUpdate();

            if (rows > 0) {
                rs = psTurf.getGeneratedKeys();
                if (rs.next()) {
                    int turfId = rs.getInt(1);

                    saveImage(conn, request, uploadDir, turfId, "turfPhotos", "turf_photo");
                    saveImage(conn, request, uploadDir, turfId, "ownershipProof", "ownership_proof");
                    saveImage(conn, request, uploadDir, turfId, "businessCertificate", "business_certificate");
                }
            }

            conn.commit();

            response.getWriter().println("✅ Registration successful!<br>"
                    + "Your Turf User ID: <b>" + turfUserId + "</b><br>"
                    + "Your turf details are under admin review.");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (psTurf != null) psTurf.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void saveImage(Connection conn, HttpServletRequest request, File uploadDir,
                           int turfId, String fieldName, String imageType)
            throws IOException, ServletException, SQLException {

        for (Part part : request.getParts()) {
            if (part.getName().equals(fieldName) && part.getSize() > 0) {

                String fileName = System.currentTimeMillis() + "_" +
                        Paths.get(part.getSubmittedFileName()).getFileName().toString();

                File savedFile = new File(uploadDir, fileName);
                part.write(savedFile.getAbsolutePath());

                String sql = "INSERT INTO turf_images (turf_id, image_type, image_path) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, turfId);
                ps.setString(2, imageType);
                ps.setString(3, fileName);
                ps.executeUpdate();
                ps.close();
            }
        }
    }
}
