package controller;

import model.Turf;
import util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("🔥 UserDashboardServlet HIT");

        List<Turf> turfList = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT tr.turf_id, tr.turf_name, tr.turf_address, "
                    + "tr.price_per_hour, ti.image_path "
                    + "FROM turf_registration tr "
                    + "LEFT JOIN turf_images ti "
                    + "ON tr.turf_id = ti.turf_id "
                    + "AND ti.image_type='turf_photo' "
                    + "WHERE tr.approval_status='Approved'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Turf t = new Turf();
                t.setTurfId(rs.getInt("turf_id"));
                t.setTurfName(rs.getString("turf_name"));
                t.setAddress(rs.getString("turf_address"));
                t.setPrice(rs.getDouble("price_per_hour"));
                t.setImagePath(rs.getString("image_path"));

                turfList.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("turfList", turfList);
        request.getRequestDispatcher("UserDashboard.jsp")
                .forward(request, response);
    }
}
