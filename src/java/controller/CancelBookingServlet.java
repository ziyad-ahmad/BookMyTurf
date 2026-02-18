package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBConnection;

@WebServlet("/CancelBooking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Only owner allowed
        if (session == null || !"turf_owner".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/UserLogin.jsp");
            return;
        }

        String bookingId = req.getParameter("bookingId");

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "UPDATE bookings SET status='CANCELLED' WHERE booking_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔁 Refresh owner dashboard
        res.sendRedirect(req.getContextPath() + "/OwnerDashboard");
    }
}
