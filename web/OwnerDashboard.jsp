<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
Integer turfId = (Integer) session.getAttribute("turfId");
String ownerName = (String) session.getAttribute("ownerName");

if (turfId == null) {
    response.sendRedirect("ownerLogin.jsp");
    return;
}

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
       "jdbc:mysql://localhost:3306/turf_booking?useSSL=false",
                    "root", "password@mysql"
    );
} catch (Exception e) {
    out.println("DB Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Owner Dashboard | BookMyTurf</title>

<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { font-family: 'Work Sans', sans-serif; background:#f6f9f8; }
.topbar {
  background:#0a5c45; color:white;
  padding:16px 24px;
  display:flex; justify-content:space-between;
}
.card-box {
  background:white; padding:24px;
  border-radius:16px;
  box-shadow:0 8px 24px rgba(0,0,0,.08);
}
.status-pending { color:orange; font-weight:600; }
.status-accepted { color:green; font-weight:600; }
.status-rejected { color:red; font-weight:600; }
</style>
</head>

<body>

<div class="topbar">
  <h4>BookMyTurf | Owner Dashboard</h4>
  <div>
    Welcome, <b><%= ownerName %></b> |
    <a href="LogoutServlet" class="text-white">Logout</a>
  </div>
</div>

<div class="container mt-5">
  <div class="card-box">
    <h4 class="mb-4">Booking Requests</h4>

    <table class="table table-bordered">
      <thead class="table-light">
        <tr>
          <th>User</th>
          <th>Date</th>
          <th>Time Slot</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>

<%
try {
    String sql =
      "SELECT b.booking_id, u.name, b.booking_date, b.time_slot, b.status " +
      "FROM bookings b JOIN users u ON b.user_id=u.user_id " +
      "WHERE b.turf_id=? ORDER BY b.booking_id DESC";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, turfId);

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
%>
        <tr>
          <td><%= rs.getString("name") %></td>
          <td><%= rs.getDate("booking_date") %></td>
          <td><%= rs.getString("time_slot") %></td>

          <td class="status-<%= rs.getString("status").toLowerCase() %>">
            <%= rs.getString("status") %>
          </td>

          <td>
          <% if ("PENDING".equals(rs.getString("status"))) { %>
            <form action="UpdateBookingStatus" method="post" style="display:inline">
              <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id") %>">
              <input type="hidden" name="status" value="ACCEPTED">
              <button class="btn btn-success btn-sm">Accept</button>
            </form>

            <form action="UpdateBookingStatus" method="post" style="display:inline">
              <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id") %>">
              <input type="hidden" name="status" value="REJECTED">
              <button class="btn btn-danger btn-sm">Reject</button>
            </form>
          <% } else { %>
            —
          <% } %>
          </td>
        </tr>
<%
    }
} catch (Exception e) {
    out.println("<tr><td colspan='5'>Error loading data</td></tr>");
} finally {
    if (con != null) con.close();
}
%>

      </tbody>
    </table>
  </div>
</div>

</body>
</html>
