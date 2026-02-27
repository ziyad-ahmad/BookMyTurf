<%-- 
    Document   : UserLogin
    Created on : 16 Oct 2025
    Author     : ziyad
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="author" content="Untree.co" />
        <link rel="shortcut icon" href="favicon.png" />

        <meta name="description" content="User Login - BookMyTurf" />
        <meta name="keywords" content="bootstrap, login, user, turf" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap"
            rel="stylesheet"
            />

        <link rel="stylesheet" href="fonts/icomoon/style.css" />
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css" />
        <link rel="stylesheet" href="css/tiny-slider.css" />
        <link rel="stylesheet" href="css/aos.css" />
        <link rel="stylesheet" href="css/style.css" />

        <title>User Login | BookMyTurf</title>

        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f8f9fa;
            }

            .login-section {
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

            .forgot {
                font-size: 0.9rem;
                color: #0d6efd;
                text-decoration: none;
            }

            .forgot:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>

        <div class="login-section">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-lg-5 col-md-7">
                        <div class="card p-4 p-md-5" data-aos="fade-up">
                            <h2 class="text-center mb-4 heading">User Login</h2>

                            <div id="loginAlert"></div>

                            <%
              String error = request.getParameter("error");
              if (error != null) {
                            %>
                            <div class="alert alert-danger mt-3 text-center">
                                <% if ("empty".equals(error)) { %>
                                ❌ Please fill in all fields!
                                <% } else if ("invalid".equals(error)) { %>
                                ❌ Invalid Email or Password!
                                <% } else if ("db".equals(error)) { %>
                                🚫 Database Error! Try again.
                                <% } %>
                            </div>
                            <%
                            }
                            %>


                            <form action="<%=request.getContextPath()%>/LoginServlet" method="post" novalidate>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" id="loginEmail" name="email" placeholder="Enter your email" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" id="loginPassword"  name="password" placeholder="Enter your password" required>
                                </div>

                                <button type="submit" class="btn btn-primary w-100 py-2">Login</button>

                                <div class="text-center mt-3">
                                    <a href="#" class="forgot">Forgot Password?</a>
                                </div>

                                <div class="text-center mt-3">
                                    <span>Don't have an account?</span>
                                    <a href="RegisterUser.jsp" class="text-primary fw-bold">Register</a>
                                </div>
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

        <!--    <script>
              document.getElementById('userLoginForm').addEventListener('submit', function(e){
                e.preventDefault();
                const email = document.getElementById('loginEmail').value.trim();
                const pass = document.getElementById('loginPassword').value.trim();
        
                if(email === "" || pass === ""){
                  document.getElementById('loginAlert').innerHTML =
                    '<div class="alert alert-danger mt-3">Please fill in all fields!</div>';
                } else {
                  document.getElementById('loginAlert').innerHTML =
                    '<div class="alert alert-success mt-3">Login successful! Redirecting...</div>';
                  setTimeout(() => {
                    window.location.href = 'UserDashboard.jsp';
                  }, 1500);
                }
              });
            </script>-->
    </body>
</html>l