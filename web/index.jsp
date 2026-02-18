<%-- 
    Document   : index
    Created on : 8 Oct 2025, 2:26:47 pm
    Author     : ziyad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- /*
* Template Name: Property
* Template Author: Untree.co
* Template URI: https://untree.co/
* License: https://creativecommons.org/licenses/by/3.0/
*/ -->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="author" content="Untree.co" />
        <link rel="shortcut icon" href="favicon.png" />

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap5" />

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

        <title>
            Property &mdash; Free Bootstrap 5 Website Template by Untree.co
        </title>
    </head>
    
    <body>
        
            
        <%@include file="header.jsp" %>
       
        
        <div class="hero" >
            <div class="hero-slide">
                <div
                    class="img overlay"
                    style="background-image: url('images/std.jpg')"
                    ></div>
                <div
                    class="img overlay"
                    style="background-image: url('images/me.jpg')"
                    ></div>
                <div
                    class="img overlay"
                    style="background-image: url('images/Ro.jpg')"
                    ></div>
            </div>
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-lg-9 text-center">
                        <h1 class="heading" data-aos="fade-up">
                            Easiest way to Book your Turf
                        </h1>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="imgdetail.jsp"%>
        <div class="section">
            <div class="row justify-content-center footer-cta" data-aos="fade-up">
                <div class="col-lg-7 mx-auto text-center">
                    <h2 class="mb-4">Be a part of our BookMyTurf App</h2>
                    <p>
                        <a href="Register.jsp" class="btn btn-primary text-white py-3 px-4">
                            Apply for Adding your Turf
                        </a>
                    </p>
                </div>

                <!-- /.col-lg-7 -->
            </div>
            <!-- /.row -->
        </div>

        <div class="section section-5 bg-light">
            <div class="container">
                <div class="row justify-content-center text-center mb-5">
                    <div class="col-lg-6 mb-5">
                        <h2 class="font-weight-bold heading text-primary mb-4">
                            Our Agents
                        </h2>
                        <p class="text-black-50">
                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Numquam
                            enim pariatur similique debitis vel nisi qui reprehenderit totam?
                            Quod maiores.
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
                        <div class="h-100 person">
                            <img
                                src="images/person_1-min.jpg"
                                alt="Image"
                                class="img-fluid"
                                />

                            <div class="person-contents">
                                <h2 class="mb-0"><a href="#">James Doe</a></h2>
                                <span class="meta d-block mb-3">Real Estate Agent</span>
                                <p>
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit.
                                    Facere officiis inventore cumque tenetur laboriosam, minus
                                    culpa doloremque odio, neque molestias?
                                </p>

                                <ul class="social list-unstyled list-inline dark-hover">
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-twitter"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-facebook"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-linkedin"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-instagram"></span></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
                        <div class="h-100 person">
                            <img
                                src="images/person_2-min.jpg"
                                alt="Image"
                                class="img-fluid"
                                />

                            <div class="person-contents">
                                <h2 class="mb-0"><a href="#">Jean Smith</a></h2>
                                <span class="meta d-block mb-3">Real Estate Agent</span>
                                <p>
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit.
                                    Facere officiis inventore cumque tenetur laboriosam, minus
                                    culpa doloremque odio, neque molestias?
                                </p>

                                <ul class="social list-unstyled list-inline dark-hover">
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-twitter"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-facebook"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-linkedin"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-instagram"></span></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
                        <div class="h-100 person">
                            <img
                                src="images/person_3-min.jpg"
                                alt="Image"
                                class="img-fluid"
                                />

                            <div class="person-contents">
                                <h2 class="mb-0"><a href="#">Alicia Huston</a></h2>
                                <span class="meta d-block mb-3">Real Estate Agent</span>
                                <p>
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit.
                                    Facere officiis inventore cumque tenetur laboriosam, minus
                                    culpa doloremque odio, neque molestias?
                                </p>

                                <ul class="social list-unstyled list-inline dark-hover">
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-twitter"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-facebook"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-linkedin"></span></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="#"><span class="icon-instagram"></span></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- /.site-footer -->
        <%@include file="footer.jsp" %>

        <!-- Preloader -->
        <div id="overlayer"></div>
        <div class="loader">
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>

        </div>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/navbar.js"></script>
        <script src="js/counter.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>

