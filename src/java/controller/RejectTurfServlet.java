package controller;


import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RejectTurfServlet")
public class RejectTurfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String turfIdStr = request.getParameter("turfUserId");
        if (turfIdStr == null || turfIdStr.isEmpty()) {
            response.getWriter().println("Missing turf_user_id parameter");
            return;
        }

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

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE turf_registration SET approval_status=? WHERE turf_user_id=?");
                ps.setString(1, "Rejected");
                ps.setString(2, turfIdStr);
                int rows = ps.executeUpdate();
                System.out.println("✅ Updated rows: " + rows + " for turf_user_id=" + turfIdStr);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("SuperAdmin.jsp");
    }
}
