<%-- 
    Document   : SuperAdmin.jsp
    Created on : 21 Oct 2025
    Author     : Ziyad
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || !"superadmin".equals(session1.getAttribute("role"))) {
        response.sendRedirect("UserLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Super Admin | Turf Approval Panel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Google Fonts + Bootstrap -->
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- AOS Animations -->
        <link rel="stylesheet" href="css/aos.css">

        <style>
            body {
                background-color: #f5f9f6;
                font-family: 'Work Sans', sans-serif;
                overflow-x: hidden;
            }

            /* Fix hidden text by adding top margin after header */
            main {
                margin-top: 90px;
            }

            /* Hero Section */
            .admin-hero {
                background: linear-gradient(120deg, #009970, #00b894);
                color: white;
                text-align: center;
                padding: 80px 0 60px;
                border-bottom-left-radius: 50px;
                border-bottom-right-radius: 50px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .admin-hero h1 {
                font-weight: 700;
                font-size: 2.5rem;
            }

            .admin-hero p {
                font-size: 1.1rem;
                margin-top: 10px;
            }

            /* Table Section */
            .table-section {
                margin: 60px auto;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                padding: 30px;
                animation: fadeInUp 1s ease;
            }

            .table thead {
                background: linear-gradient(90deg, #009970, #00b894);
                color: #fff;
            }

            .btn-approve {
                background: linear-gradient(90deg, #00c851, #007e33);
                color: #fff;
            }

            .btn-reject {
                background: linear-gradient(90deg, #ff4444, #cc0000);
                color: #fff;
            }

            .btn-approve:hover, .btn-reject:hover {
                opacity: 0.85;
            }

            img {
                border-radius: 8px;
                object-fit: cover;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(40px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive tweaks */
            @media (max-width: 992px) {
                .admin-hero h1 {
                    font-size: 2rem;
                }
            }

            @media (max-width: 768px) {
                .table-section {
                    padding: 20px;
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 576px) {
                .admin-hero {
                    padding: 60px 20px;
                }

                .admin-hero h1 {
                    font-size: 1.8rem;
                }

                .admin-hero p {
                    font-size: 1rem;
                }
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>

        <main>
            <!-- Hero Section -->
            <section class="admin-hero" data-aos="fade-down">
                <div class="container">
                    <h1><i class="bi bi-speedometer2 me-2"></i>Super Admin Dashboard</h1>
                    <p class="lead mt-3">Manage turf approvals and review applications easily.</p>
                </div>
            </section>

            <!-- Approval Table Section -->
            <div class="container table-section" data-aos="fade-up">
                <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
                    <h4 class="text-secondary"><i class="bi bi-list-check me-2"></i>Turf Approval List</h4>
                    <a href="LogoutServlet" class="btn btn-outline-danger btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Turf User ID</th>
                                <th>Owner Name</th>
                                <th>Email</th>
                                <th>Turf Name</th>
                                <th>Address</th>
                                <th>Phone</th>
                                <th>Price/hr</th>
                                <th>UPI ID</th>
                                <th>Bank Details</th>
                                <th>Images</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection con = null;
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/turf_booking?useSSL=false", "root", "password@mysql");

                                    String sql = "SELECT * FROM turf_registration";
                                    PreparedStatement ps = con.prepareStatement(sql);
                                    ResultSet rs = ps.executeQuery();

                                    while (rs.next()) {
                                        int turfId = rs.getInt("turf_id");
                                        String turfUserId = rs.getString("turf_user_id");
                            %>
                            <tr>
                                <td><%= turfId%></td>

                                <td><%= rs.getString("owner_name")%></td>
                                <td><strong><%= turfUserId%></strong></td>
                                <td><%= rs.getString("email")%></td>
                                <td><strong><%= rs.getString("turf_name")%></strong></td>
                                <td><%= rs.getString("turf_address")%></td>
                                <td><%= rs.getString("turf_phone")%></td>
                                <td>₹<%= rs.getDouble("price_per_hour")%></td>
                                <td><%= rs.getString("upi_id")%></td>
                                <td class="text-start small">
                                    <b>Acc:</b> <%= rs.getString("account_number")%><br>
                                    <b>Bank:</b> <%= rs.getString("bank_name")%> (<%= rs.getString("ifsc_code")%>)
                                </td>
                                <td>
                                    <%
                                        PreparedStatement psImg = con.prepareStatement("SELECT * FROM turf_images WHERE turf_id=?");
                                        psImg.setInt(1, turfId);
                                        ResultSet rsImg = psImg.executeQuery();
                                        while (rsImg.next()) {
                                    %>
                                    <div class="mb-2">
                                        <small class="text-muted"><%= rsImg.getString("image_type")%></small><br>
                                        
                                        <img 
                                            src="<%= request.getContextPath()%>/uploads/<%= rsImg.getString("image_path")%>" 
                                            width="90" 
                                            height="70"
                                            onerror="this.src='<%= request.getContextPath()%>/images/default-turf.jpg'">
                                    </div>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <% String status = rs.getString("approval_status"); %>
                                    <% if ("Approved".equals(status)) { %>
                                    <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Approved</span>
                                    <% } else if ("Rejected".equals(status)) { %>
                                    <span class="badge bg-danger"><i class="bi bi-x-circle me-1"></i>Rejected</span>
                                    <% } else { %>
                                    <span class="badge bg-warning text-dark"><i class="bi bi-hourglass-split me-1"></i>Pending</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if ("Pending".equals(rs.getString("approval_status"))) {%>
                                    <a href="${pageContext.request.contextPath}/ApproveTurfServlet?turf_id=<%= turfId%>" class="btn btn-approve btn-sm">
                                        <i class="bi bi-check2-circle"></i> Approve
                                    </a>
                                    <a href="${pageContext.request.contextPath}/RejectTurfServlet?turf_id=<%= turfId%>" class="btn btn-reject btn-sm">
                                        <i class="bi bi-x-circle"></i> Reject
                                    </a>
                                    <% } else { %>
                                    <span class="text-muted"><i class="bi bi-check-circle"></i> Done</span>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (con != null) {
                                        con.close();
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <%@include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/aos.js"></script>
        <script>
            AOS.init({duration: 1000, once: true});
        </script>
    </body>
</html>
