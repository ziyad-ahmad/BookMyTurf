//package controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//
//import util.DBConnection;
//
//@WebServlet("/MyBookings")
//public class MyBookingsServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//
//        HttpSession session = req.getSession(false);
//
//        // 🔐 Check login
//        if (session == null || session.getAttribute("user_id") == null) {
//            res.sendRedirect("UserLogin.jsp");
//            return;
//        }
//
//        String userId = (String) session.getAttribute("user_id");
//
//        List<String[]> bookings = new ArrayList<>();
//
//        try (Connection con = DBConnection.getConnection()) {
//
//            String sql =
//                "SELECT tr.turf_name, b.booking_date, ts.start_time, ts.end_time, b.status " +
//                "FROM bookings b " +
//                "JOIN turf_registration tr ON b.turf_id = tr.turf_id " +
//                "JOIN turf_slots ts ON b.slot_id = ts.slot_id " +
//                "WHERE b.user_id = ? " +
//                "ORDER BY b.booking_date DESC";
//
//            PreparedStatement ps = con.prepareStatement(sql);
//            ps.setString(1, userId);
//
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                bookings.add(new String[]{
//                    rs.getString("turf_name"),
//                    rs.getString("booking_date"),
//                    rs.getString("start_time") + " - " + rs.getString("end_time"),
//                    rs.getString("status")
//                });
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        req.setAttribute("bookings", bookings);
//        req.getRequestDispatcher("my-bookings.jsp").forward(req, res);
//    }
//}


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

@WebServlet("/MyBookings")
public class MyBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Check login
        if (session == null || session.getAttribute("user_id") == null) {
            res.sendRedirect("UserLogin.jsp");
            return;
        }

        String userId = (String) session.getAttribute("user_id");

        List<String[]> bookings = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            // ⭐ Updated Query (Dynamic Slots)
            String sql =
                "SELECT tr.turf_name, " +
                "b.booking_date, " +
                "b.start_time, " +
                "b.end_time, " +
                "b.status " +
                "FROM bookings b " +
                "JOIN turf_registration tr " +
                "ON b.turf_id = tr.turf_id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                bookings.add(new String[]{
                    rs.getString("turf_name"),
                    rs.getString("booking_date"),
                    rs.getString("start_time") + " - " + rs.getString("end_time"),
                    rs.getString("status")
                });

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send bookings list to JSP
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("my-bookings.jsp").forward(req, res);
    }
}