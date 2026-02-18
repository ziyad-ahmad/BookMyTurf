package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Slot;
import util.DBConnection;

@WebServlet("/SelectDate")
public class SelectDateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String turfIdStr = req.getParameter("turfId");
        String date = req.getParameter("date");

        if (turfIdStr == null) {
            res.sendRedirect("UserDashboard");
            return;
        }

        int turfId = Integer.parseInt(turfIdStr);

        List<Slot> slots = new ArrayList<>();

        // 👉 Load slots ONLY if date is selected
        if (date != null && !date.isEmpty()) {
            try (Connection con = DBConnection.getConnection()) {

                String sql =
                    "SELECT ts.slot_id, ts.start_time, ts.end_time, " +
                    "CASE WHEN b.booking_id IS NULL THEN 0 ELSE 1 END booked " +
                    "FROM turf_slots ts " +
                    "LEFT JOIN bookings b ON ts.slot_id = b.slot_id " +
                    "AND b.booking_date = ? AND b.status='BOOKED' " +
                    "WHERE ts.turf_id = ?";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, date);
                ps.setInt(2, turfId);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Slot s = new Slot();
                    s.setSlotId(rs.getInt("slot_id"));
                    s.setStartTime(rs.getString("start_time"));
                    s.setEndTime(rs.getString("end_time"));
                    s.setBooked(rs.getInt("booked") == 1);
                    slots.add(s);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        req.setAttribute("turfId", turfId);
        req.setAttribute("date", date);
        req.setAttribute("slots", slots);

        req.getRequestDispatcher("Select-date.jsp").forward(req, res);
    }
}
