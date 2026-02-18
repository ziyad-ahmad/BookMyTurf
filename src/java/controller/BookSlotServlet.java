package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

@WebServlet("/BookSlot")
public class BookSlotServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // 1️⃣ Check user login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            res.sendRedirect("UserLogin.jsp");
            return;
        }

        String userId = (String) session.getAttribute("user_id");

        // 2️⃣ Read request parameters
        String turfIdStr = req.getParameter("turfId");
        String slotIdStr = req.getParameter("slotId");
        String date = req.getParameter("date");

        if (turfIdStr == null || slotIdStr == null || date == null) {
            res.getWriter().println("Invalid booking request");
            return;
        }

        int turfId = Integer.parseInt(turfIdStr);
        int slotId = Integer.parseInt(slotIdStr);

        try (Connection con = DBConnection.getConnection()) {

            // 3️⃣ Check if slot already booked
            String checkSql =
                "SELECT booking_id FROM bookings " +
                "WHERE turf_id=? AND slot_id=? AND booking_date=? AND status='BOOKED'";

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, turfId);
            checkPs.setInt(2, slotId);
            checkPs.setString(3, date);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                res.getWriter().println("<h3>This slot is already booked.</h3>");
                return;
            }

            // 4️⃣ Insert booking
            String insertSql =
                "INSERT INTO bookings (user_id, turf_id, slot_id, booking_date, status) " +
                "VALUES (?, ?, ?, ?, 'BOOKED')";

            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setString(1, userId);
            ps.setInt(2, turfId);
            ps.setInt(3, slotId);
            ps.setString(4, date);

            ps.executeUpdate();

            // 5️⃣ Redirect to MyBookings page
            res.sendRedirect("MyBookings");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Booking failed due to server error.");
        }
    }
}
