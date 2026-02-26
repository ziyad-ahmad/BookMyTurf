<%-- 
    Document   : RegisterUser
    Created on : 16 Oct 2025, 12:04:30 pm
    Author     : ziyad
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="author" content="Untree.co" />
        <meta name="description" content="User Registration - BookMyTurf" />
        <meta name="keywords" content="bootstrap, user, register" />
        <link rel="shortcut icon" href="favicon.png" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />

        <link rel="stylesheet" href="fonts/icomoon/style.css" />
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />
        <link rel="stylesheet" href="css/tiny-slider.css" />
        <link rel="stylesheet" href="css/aos.css" />
        <link rel="stylesheet" href="css/style.css" />

        <title>User Registration | BookMyTurf</title>

        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f8f9fa;
            }
            .register-section {
                padding: 100px 0;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0px 4px 20px rgba(0,0,0,0.1);
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                font-weight: 600;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .form-label {
                font-weight: 500;
            }
            .heading {
                font-weight: 700;
                color: #0d6efd;
            }
        </style>
    </head>

    <body>

        <%@include file="header.jsp" %>

        <div class="register-section">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-lg-6 col-md-8">
                        <div class="card p-4 p-md-5" data-aos="fade-up">
                            <h2 class="text-center mb-4 heading">User Registration</h2>

                            <div id="userAlert"></div>
                            <%
                                String errorMsg = (String) request.getAttribute("errorMsg");
                                if (errorMsg != null) {
                            %>
                            <div class="alert alert-danger mt-3 text-center">
                                <%= errorMsg%>
                            </div>
                            <%
                               
                                }
                            %>

                            <form id="RegisterUser" method="post" action="RegisterUser">

                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="userName" name="userName" placeholder="Enter your full name" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="Enter your email" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="userPhone" name="userPhone" placeholder="Enter your phone number" required pattern="[0-9]{10}">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <select class="form-select" id="userGender" name="userGender" required>
                                        <option value="" selected disabled>Select Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="Enter your password" required>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 py-2">Register</button>

                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/custom.js"></script>

        <script>
            document.getElementById('userRegisterForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const name = document.getElementById('userName').value.trim();
                const email = document.getElementById('userEmail').value.trim();
                const phone = document.getElementById('userPhone').value.trim();
                const gender = document.getElementById('userGender').value;
                const pass = document.getElementById('userPassword').value.trim();

                if (name === "" || email === "" || phone === "" || gender === "" || pass === "") {
                    document.getElementById('userAlert').innerHTML =
                            '<div class="alert alert-danger mt-3">Please fill in all fields!</div>';
                } else if (phone.length !== 10) {
                    document.getElementById('userAlert').innerHTML =
                            '<div class="alert alert-warning mt-3">Phone number must be 10 digits!</div>';
                } else {
                    document.getElementById('userAlert').innerHTML =
                            '<div class="alert alert-success mt-3">Registration successful!</div>';
                    this.reset();
                }
            });
        </script>


    </body>
</html>
