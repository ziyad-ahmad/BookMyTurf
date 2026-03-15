<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

HttpSession session1 = request.getSession(false);

if(session1 == null || !"user".equals(session1.getAttribute("role"))){
    response.sendRedirect("LoginUser.jsp");
    return;
}
%>
<html>
<head>
    <title>My Bookings | BookMyTurf</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4">

<h3 class="mb-4">My Bookings</h3>

<%
List<String[]> bookings = (List<String[]>) request.getAttribute("bookings");

if (bookings == null || bookings.isEmpty()) {
%>
    <div class="alert alert-info">
        You have no bookings yet.
    </div>
<%
} else {
%>

<table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr>
            <th>Turf Name</th>
            <th>Date</th>
            <th>Time Slot</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>

<%
    for (String[] b : bookings) {
%>
        <tr>
            <td><%= b[0] %></td>
            <td><%= b[1] %></td>
            <td><%= b[2] %></td>
            <td>
                <span class="badge <%= "BOOKED".equals(b[3]) ? "bg-success" : "bg-secondary" %>">
                    <%= b[3] %>
                </span>
            </td>
        </tr>
<%
    }
%>

    </tbody>
</table>

<%
}
%>

<a href="UserDashboardServlet" class="btn btn-primary mt-3">
    ← Back to Dashboard
</a>

</body>
</html>
