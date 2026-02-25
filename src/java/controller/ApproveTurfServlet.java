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

        String turfIdStr = request.getParameter("turf_id");  // ✅ match JSP param
        if (turfIdStr == null || turfIdStr.trim().isEmpty()) {
            response.getWriter().println("Missing turf_id parameter");
            return;
        }

        try {
            int turfId = Integer.parseInt(turfIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/turf_booking?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "password@mysql")) {

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE turf_registration SET approval_status=? WHERE turf_id=?");

                ps.setString(1, "Approved");
                ps.setInt(2, turfId);

                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("SuperAdmin.jsp");
    }
}