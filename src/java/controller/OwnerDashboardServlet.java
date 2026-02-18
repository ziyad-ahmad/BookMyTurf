package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

@WebServlet("/OwnerDashboard")
public class OwnerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Owner login check
        if (session == null || !"turf_owner".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/UserLogin.jsp");
            return;
        }

        String turfUserId = (String) session.getAttribute("turf_user_id");

        List<String[]> bookings = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            // 🔹 Get turf_id & turf_name
            String turfSql =
                "SELECT turf_id, turf_name FROM turf_registration WHERE turf_user_id=?";

            PreparedStatement turfPs = con.prepareStatement(turfSql);
            turfPs.setString(1, turfUserId);
            ResultSet turfRs = turfPs.executeQuery();

            if (!turfRs.next()) {
                req.setAttribute("error", "No turf found for this owner");
                req.getRequestDispatcher("owner-dashboard.jsp").forward(req, res);
                return;
            }

            int turfId = turfRs.getInt("turf_id");
            String turfName = turfRs.getString("turf_name");

            // 🔹 Get bookings
            String bookingSql =
                "SELECT b.booking_id, b.user_id, b.booking_date, " +
                "ts.start_time, ts.end_time, b.status " +
                "FROM bookings b " +
                "JOIN turf_slots ts ON b.slot_id = ts.slot_id " +
                "WHERE b.turf_id = ? " +
                "ORDER BY b.booking_date DESC";

            PreparedStatement ps = con.prepareStatement(bookingSql);
            ps.setInt(1, turfId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookings.add(new String[]{
                    rs.getString("booking_id"),   // 0
                    rs.getString("user_id"),      // 1
                    rs.getString("booking_date"), // 2
                    rs.getString("start_time") + " - " + rs.getString("end_time"), // 3
                    rs.getString("status")        // 4
                });
            }

            req.setAttribute("turfName", turfName);
            req.setAttribute("bookings", bookings);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("owner-dashboard.jsp").forward(req, res);
    }
}
