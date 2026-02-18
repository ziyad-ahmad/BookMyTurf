package controller;


import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ApproveTurfServlet")
public class ApproveTurfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get turf_user_id parameter instead of turf_id
        String turfUserId = request.getParameter("turfUserId");
        if (turfUserId == null || turfUserId.trim().isEmpty()) {
            response.getWriter().println("Missing turf_user_id parameter");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/turf_booking?useSSL=false",
                    "root", "password@mysql")) {

                // Update using turf_user_id instead of turf_id
                PreparedStatement ps = con.prepareStatement(
                        "UPDATE turf_registration SET approval_status=? WHERE turf_user_id=?");

                ps.setString(1, "Approved");
                ps.setString(2, turfUserId);

                int rows = ps.executeUpdate();
                System.out.println("✅ Updated rows: " + rows + " for turf_user_id=" + turfUserId);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to dashboard
        response.sendRedirect("SuperAdmin.jsp");
    }
}
