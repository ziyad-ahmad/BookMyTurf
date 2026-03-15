//package controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//
//import model.Slot;
//import util.DBConnection;
//
//@WebServlet("/SelectDate")
//public class SelectDateServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse res)
//            throws ServletException, IOException {
//
//        String turfIdStr = req.getParameter("turfId");
//        String date = req.getParameter("date");
//
//        if (turfIdStr == null) {
//            res.sendRedirect("UserDashboard");
//            return;
//        }
//
//        int turfId = Integer.parseInt(turfIdStr);
//
//        List<Slot> slots = new ArrayList<>();
//
//        // 👉 Load slots ONLY if date is selected
//        if (date != null && !date.isEmpty()) {
//            try (Connection con = DBConnection.getConnection()) {
//
//                String sql =
//                    "SELECT ts.slot_id, ts.start_time, ts.end_time, " +
//                    "CASE WHEN b.booking_id IS NULL THEN 0 ELSE 1 END booked " +
//                    "FROM turf_slots ts " +
//                    "LEFT JOIN bookings b ON ts.slot_id = b.slot_id " +
//                    "AND b.booking_date = ? AND b.status='BOOKED' " +
//                    "WHERE ts.turf_id = ?";
//
//                PreparedStatement ps = con.prepareStatement(sql);
//                ps.setString(1, date);
//                ps.setInt(2, turfId);
//
//                ResultSet rs = ps.executeQuery();
//                while (rs.next()) {
//                    Slot s = new Slot();
//                    s.setSlotId(rs.getInt("slot_id"));
//                    s.setStartTime(rs.getString("start_time"));
//                    s.setEndTime(rs.getString("end_time"));
//                    s.setBooked(rs.getInt("booked") == 1);
//                    slots.add(s);
//                }
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//
//        req.setAttribute("turfId", turfId);
//        req.setAttribute("date", date);
//        req.setAttribute("slots", slots);
//
//        req.getRequestDispatcher("Select-date.jsp").forward(req, res);
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
            res.sendRedirect("UserDashboardServlet");
            return;
        }

        int turfId = Integer.parseInt(turfIdStr);

        // 1️⃣ Dynamic Slot List
        String[] slots = {
            "06:00-07:00",
            "07:00-08:00",
            "08:00-09:00",
            "09:00-10:00",
            "10:00-11:00",
            "11:00-12:00",
            "17:00-18:00",
            "18:00-19:00",
            "19:00-20:00"
        };

        List<Slot> slotList = new ArrayList<>();

        // 2️⃣ Generate Slot Objects
        for (String s : slots) {

            String[] time = s.split("-");

            Slot slot = new Slot();
            slot.setStartTime(time[0]);
            slot.setEndTime(time[1]);
            slot.setBooked(false);

            slotList.add(slot);
        }

        // 3️⃣ Check Booked Slots from Database
        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "SELECT start_time, end_time FROM bookings " +
                "WHERE turf_id=? AND booking_date=? AND status='BOOKED'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, turfId);
            ps.setString(2, date);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String bookedStart = rs.getString("start_time");
                String bookedEnd = rs.getString("end_time");

                for (Slot s : slotList) {

                    if (s.getStartTime().equals(bookedStart) &&
                        s.getEndTime().equals(bookedEnd)) {

                        s.setBooked(true);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4️⃣ Send data to JSP
        req.setAttribute("slots", slotList);
        req.setAttribute("turfId", turfId);
        req.setAttribute("date", date);

        req.getRequestDispatcher("Select-date.jsp")
           .forward(req, res);
    }
}