<%-- 
    Document   : Register
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

        <meta name="description" content="Turf Registration" />
        <meta name="keywords" content="bootstrap, turf, register" />

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

        <title>Register Turf | BookMyTurf</title>

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
                    <div class="col-lg-7">
                        <div class="card p-4 p-md-5" data-aos="fade-up">
                            <h2 class="text-center mb-4 heading">Register Your Turf</h2>
                            <% if (request.getAttribute("errorMsg") != null) {%>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("errorMsg")%>
                            </div>
                            <% }%>

                            <form action="${pageContext.request.contextPath}/TurfRegister" method="post" enctype="multipart/form-data">


                                <!-- Owner Details -->
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Confirm Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                                    </div>
                                </div>

                                <!-- Turf Details -->
                                <div class="mb-3">
                                    <label class="form-label">Turf Name</label>
                                    <input type="text" class="form-control" id="turfName" name="turfName" placeholder="Enter turf name" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Turf Address</label>
                                    <input type="text" class="form-control" id="turfAddress" name="turfAddress" placeholder="Enter turf address" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Turf Phone</label>

                                    <div class="input-group">
                                        <span class="input-group-text">+91</span>

                                        <input
                                            type="tel"
                                            class="form-control"
                                            id="turfPhone"
                                            name="turfPhone"
                                            placeholder="Enter 10 digit mobile number"
                                            maxlength="10"
                                            pattern="[6-9]{1}[0-9]{9}"
                                            oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                                            required>
                                    </div>

                                    <small class="text-muted">
                                        Enter a valid 10-digit Indian mobile number.
                                    </small>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Add Photos of Turf</label>
                                    <input type="file" class="form-control" id="turfPhotos" name="turfPhotos" multiple accept="image/*">
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Price per Hour</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-currency-rupee"></i></span>
                                        <input type="number" class="form-control" id="pricePerHour" name="pricePerHour" placeholder="Enter price per hour" required>
                                    </div>
                                </div>

                                <!-- Turf Verification Documents -->
                                <h5 class="mt-4 mb-3 text-primary">Turf Verification Documents</h5>

                                <div class="mb-3">
                                    <label class="form-label">Turf Ownership Proof</label>
                                    <input type="file" class="form-control" id="ownershipProof" name="ownershipProof" accept=".pdf,.jpg,.jpeg,.png" required>
                                    <small class="text-muted">Upload property registration, lease, or license proof.</small>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Business Certificate (if available)</label>
                                    <input type="file" class="form-control" id="businessCertificate" name="businessCertificate" accept=".pdf,.jpg,.jpeg,.png">
                                    <small class="text-muted">Optional: GST, MSME, or business registration certificate.</small>
                                </div>

                                <!-- Payment Details -->
                                <h5 class="mt-4 mb-3 text-primary">Payment Details</h5>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">UPI ID</label>
                                        <input type="text" class="form-control" id="upiId" name="upiId" placeholder="example@upi" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Bank Account Number</label>
                                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" placeholder="Enter account number" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Bank Name</label>
                                        <input type="text" class="form-control" id="bankName" name="bankName" placeholder="Enter bank name" required>
                                    </div>

                                    <div class="col-md-6 mb-4">
                                        <label class="form-label">IFSC Code</label>
                                        <input type="text" class="form-control" id="ifscCode" name="ifscCode" placeholder="Enter IFSC code" required>
                                    </div>
                                </div>

                                <!-- Submit -->
                                <button type="submit" class="btn btn-primary w-100 py-2">Register Turf</button>
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

<!--        <script>
            document.getElementById('registerForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const pass = document.getElementById('password').value;
                const cpass = document.getElementById('confirmPassword').value;

                if (pass !== cpass) {
                    document.getElementById('registerAlert').innerHTML =
                            '<div class="alert alert-danger mt-3">Passwords do not match!</div>';
                    return;
                }

                const ownership = document.getElementById('ownershipProof').value;
                const upi = document.getElementById('upiId').value.trim();
                const ifsc = document.getElementById('ifscCode').value.trim();

                if (!ownership) {
                    document.getElementById('registerAlert').innerHTML =
                            '<div class="alert alert-danger mt-3">Please upload Turf Ownership Proof!</div>';
                    return;
                }

                if (!upi.includes('@')) {
                    document.getElementById('registerAlert').innerHTML =
                            '<div class="alert alert-danger mt-3">Please enter a valid UPI ID!</div>';
                    return;
                }

                if (ifsc.length < 8) {
                    document.getElementById('registerAlert').innerHTML =
                            '<div class="alert alert-danger mt-3">Please enter a valid IFSC code!</div>';
                    return;
                }

                document.getElementById('registerAlert').innerHTML =
                        '<div class="alert alert-success mt-3">Registration successful!</div>';
                this.reset();
            });
        </script>-->
    </body>
</html>
