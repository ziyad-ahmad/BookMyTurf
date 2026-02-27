


<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Turf" %>
<%
if (session.getAttribute("role") == null || 
   !"user".equals(session.getAttribute("role"))) {
    response.sendRedirect("LoginUser.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Dashboard | BookMyTurf</title>

<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
:root {
  --green-dark: #0a5c45;
  --green-main: #00a97b;
  --green-light: #e9f7f3;
}

body {
  margin: 0;
  font-family: 'Work Sans', sans-serif;
  background: #f6f9f8;
}

/* ===== TOP BAR ===== */
.topbar {
  height: 64px;
  background: var(--green-dark);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 24px;
  color: white;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.topbar .brand {
  font-size: 22px;
  font-weight: 700;
}

.topbar .user {
  display: flex;
  align-items: center;
  gap: 12px;
}

.topbar img {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: 2px solid var(--green-main);
}

/* ===== LAYOUT ===== */
.layout {
  display: flex;
}

/* ===== SIDEBAR ===== */
.sidebar {
  width: 220px;
  background: white;
  border-right: 1px solid #e5e5e5;
  padding: 20px;
  min-height: calc(100vh - 64px);
}

.sidebar h6 {
  color: #666;
  font-size: 13px;
  margin-bottom: 15px;
  text-transform: uppercase;
}

.sidebar a {
  display: block;
  padding: 12px 14px;
  border-radius: 8px;
  text-decoration: none;
  color: #222;
  font-weight: 500;
  margin-bottom: 10px;
}

.sidebar a.active,
.sidebar a:hover {
  background: var(--green-light);
  color: var(--green-dark);
}

/* ===== MAIN CONTENT ===== */
.content {
  flex: 1;
  padding: 28px;
}

.section-title {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 20px;
}

/* ===== TURF CARDS ===== */
.turf-card {
  border: none;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0,0,0,.08);
  transition: transform .2s;
}

.turf-card:hover {
  transform: translateY(-6px);
}

.turf-card img {
  height: 170px;
  object-fit: cover;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
}

.book-btn {
  background: var(--green-main);
  color: white;
  font-weight: 600;
  border-radius: 10px;
  padding: 10px;
}

.book-btn:hover {
  background: var(--green-dark);
}

/* ===== MOBILE ===== */
@media (max-width: 768px) {
  .layout {
    flex-direction: column;
  }
  .sidebar {
    width: 100%;
    min-height: auto;
  }
}
</style>
</head>

<body>

<!-- ===== TOP BAR ===== -->
<div class="topbar">
  <div class="brand">BookMyTurf</div>
  <div class="user">
    <span>
      <%= session.getAttribute("name") != null 
            ? session.getAttribute("name") 
            : "User" %>
    </span>
    <img src="images/profile.png">
  </div>
</div>

<!-- ===== LAYOUT ===== -->
<div class="layout">

  <!-- ===== SIDEBAR ===== -->
  <div class="sidebar">
    <h6>Menu</h6>
    <a href="UserDashboardServlet" class="active">🎯 Book Turf</a>
    <a href="MyBookings">📖 My Bookings</a>
    <a href="LogoutServlet">🚪 Logout</a>
  </div>

  <!-- ===== CONTENT ===== -->
  <div class="content">
    <div class="section-title">Available Turfs</div>

    <div class="row g-4">

<%
List<Turf> turfs = (List<Turf>) request.getAttribute("turfList");

if (turfs != null && !turfs.isEmpty()) {
    for (Turf t : turfs) {
%>

      <div class="col-md-6">
        <div class="card turf-card">

          <img src="<%= 
              (t.getImagePath() != null) 
              ? "uploads/" + t.getImagePath() 
              : "images/default-turf.jpg" 
          %>">
          <div class="card-body">
            <h5 class="fw-bold"><%= t.getTurfName() %></h5>
            <p class="text-muted"><%= t.getAddress() %></p>
            <p class="text-muted">₹<%= t.getPrice() %> / Hour</p>

            <button class="btn book-btn w-100"
              onclick="openBooking(<%= t.getTurfId() %>)">
              Book Now
            </button>
          </div>

        </div>
      </div>

<%
    }
} else {
%>
      <p>No approved turfs available.</p>
<%
}
%>

    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function openBooking(turfId){
    window.location.href = "SelectDate?turfId=" + turfId;
}
</script>
</body>
</html>