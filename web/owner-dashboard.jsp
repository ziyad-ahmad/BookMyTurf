<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Dashboard | BookMyTurf</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4 bg-light">

<div class="container">

    <h3 class="mb-2">Owner Dashboard</h3>
    <p class="text-muted mb-4">
        Turf: <strong><%= request.getAttribute("turfName") %></strong>
    </p>

<%
List<String[]> bookings = (List<String[]>) request.getAttribute("bookings");

if (bookings == null || bookings.isEmpty()) {
%>
    <div class="alert alert-info">
        No bookings available.
    </div>
<%
} else {
%>

    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>User ID</th>
                    <th>Date</th>
                    <th>Slot</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>

<%
    for (String[] b : bookings) {
        String bookingId = b[0];
        String userId    = b[1];
        String date      = b[2];
        String slot      = b[3];
        String status    = b[4];
%>
                <tr>
                    <td><%= userId %></td>
                    <td><%= date %></td>
                    <td><%= slot %></td>

                    <td>
                        <span class="badge <%= "BOOKED".equals(status) ? "bg-success" : "bg-secondary" %>">
                            <%= status %>
                        </span>
                    </td>

                    <td>
                    <% if ("BOOKED".equals(status)) { %>
                        <button
                            type="button"
                            class="btn btn-sm btn-danger"
                            onclick="openCancelModal('<%= bookingId %>')">
                            Cancel
                        </button>
                    <% } else { %>
                        —
                    <% } %>
                    </td>
                </tr>
<%
    }
%>
            </tbody>
        </table>
    </div>

<%
}
%>

    <a href="<%= request.getContextPath() %>/LogoutServlet"
       class="btn btn-outline-danger mt-3">
        Logout
    </a>

</div>

<!-- ================= CANCEL CONFIRM MODAL ================= -->
<div class="modal fade" id="cancelModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title text-danger">Cancel Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p>Do you really want to cancel this booking?</p>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">
                    No
                </button>
                <button class="btn btn-danger" onclick="confirmCancel()">
                    Yes, Cancel
                </button>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
let bookingToCancel = null;

function openCancelModal(bookingId) {
    bookingToCancel = bookingId;
    let modal = new bootstrap.Modal(document.getElementById('cancelModal'));
    modal.show();
}

function confirmCancel() {
    if (bookingToCancel) {
        window.location.href =
            "<%= request.getContextPath() %>/CancelBooking?bookingId=" + bookingToCancel;
    }
}
</script>

</body>
</html>
