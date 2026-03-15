<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Slot" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Select Date & Slot | BookMyTurf</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="p-4">

        <h4 class="mb-3">Select Booking Date</h4>

        <!-- ===== DATE PICKER ===== -->
        <form method="get" action="SelectDate" class="mb-4">
            <input type="hidden" name="turfId"
                   value="<%= request.getAttribute("turfId")%>">

            <input type="date"
                   name="date"
                   class="form-control"
                   min="<%= java.time.LocalDate.now()%>"
                   value="<%= request.getAttribute("date") != null ? request.getAttribute("date") : ""%>"
                   onchange="this.form.submit()">
        </form>

        <hr>

        <h5 class="mb-3">Available Slots</h5>

        <div class="row g-3">

            <%
                List<Slot> slots = (List<Slot>) request.getAttribute("slots");

                if (slots == null || slots.isEmpty()) {
            %>
            <div class="alert alert-warning">
                No slots available for the selected date.
            </div>
            <%
            } else {
                for (Slot s : slots) {
            %>
            <div class="col-md-3 col-sm-6">
                <button
                    type="button"
                    class="btn w-100 <%= s.isBooked() ? "btn-secondary" : "btn-success"%>"
                    <%= s.isBooked() ? "disabled" : ""%>
                    onclick="openConfirmModal('<%= s.getStartTime()%>', '<%= s.getEndTime()%>')">

                    <%= s.getStartTime()%> - <%= s.getEndTime()%>

                </button>
            </div>
            <%
                    }
                }
            %>

        </div>

        <!-- ===== CONFIRM BOOKING MODAL ===== -->
        <div class="modal fade" id="confirmModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Booking</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <p>Do you really want to book this slot?</p>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>
                        <button class="btn btn-success" onclick="confirmBooking()">
                            Yes, Book Now
                        </button>
                    </div>

                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                            let startTime = null;
                            let endTime = null;

                            function openConfirmModal(st, et) {
                                startTime = st;
                                endTime = et;

                                let modal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                modal.show();
                            }

                            // Redirect to booking servlet
                            function confirmBooking() {

                                if (startTime && endTime) {

                                    window.location.href =
                                            "BookSlot"
                                            + "?turfId=<%= request.getAttribute("turfId")%>"
                                            + "&date=<%= request.getAttribute("date")%>"
                                            + "&startTime=" + startTime
                                            + "&endTime=" + endTime;

                                }
                            }
        </script>
    </body>
</html>