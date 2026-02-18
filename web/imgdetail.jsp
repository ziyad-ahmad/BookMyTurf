<%-- 
    Document   : imgdetail
    Created on : 8 Oct 2025, 2:38:50 pm
    Author     : ziyad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
  .property-item .img img {
    width: 100%;
    height: 300px; /* adjust height as you want (e.g., 250px, 350px) */
    object-fit: cover; /* ensures image scales nicely without distortion */
    border-radius: 10px; /* optional - gives smooth rounded corners */
  }
</style>
    <body>
        
        <div id="turf-section" class="section">
      <div class="container">
        <div class="row mb-5 align-items-center">
          <div class="col-lg-6">
            <h2 class="font-weight-bold text-primary heading">
             TURF 
            </h2>
          </div>
          <div class="col-lg-6 text-lg-end">
            <p>
              <a
                href="#"
                target="_blank"
                class="btn btn-primary text-white py-3 px-4"
                >View all Turf</a
              >
            </p>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="property-slider-wrap">
              <div class="property-slider">
              
                  <div class="property-item">
                  <a href="property-single.html" class="img">
                    <img src="https://media.istockphoto.com/id/520999573/photo/indoor-soccer-football-field.jpg?s=612x612&w=0&k=20&c=X2PinGm51YPcqCAFCqDh7GvJxoG2WnJ19aadfRYk2dI=" alt="Image" class="img-fluid" />
                  </a>

                  <div class="property-content">
                    <div class="price mb-2"><span>1250Rs/hr</span></div>
                    <div>
                      <span class="d-block mb-2 text-black-50"
                        >5002 California Fake, Ave. 21BC</span
                      >
                      <span class="city d-block mb-3">North, USA</span>

                     

                      <a
                        href="property-single.html"
                        class="btn btn-primary py-2 px-3"
                        >BOOK NOW</a
                      >
                    </div>
                  </div>
                </div>
                <!-- .item -->

                <div class="property-item">
                  <a href="property-single.html" class="img">
                    <img src="https://5.imimg.com/data5/SELLER/Default/2023/10/350327019/NU/WB/TZ/38215148/7-a-side-football-turf.jpg" alt="Image" class="img-fluid" />
                  </a>

                  <div class="property-content">
                    <div class="price mb-2"><span>1200Rs/hr</span></div>
                    <div>
                      <span class="d-block mb-2 text-black-50"
                        >5296 California Fake, Ave. 22BC</span
                      >
                      <span class="city d-block mb-3">Silver, USA</span>

                      

                      <a
                        href="property-single.html"
                        class="btn btn-primary py-2 px-3"
                        >BOOK NOW</a
                      >
                    </div>
                  </div>
                </div>
                <!-- .item -->

                <div class="property-item">
                  <a href="property-single.html" class="img">
                    <img src="https://d3mt0x61rkkfy3.cloudfront.net/venue/e6323961-1b9d-4a43-a3a0-1be5641e7206/original/1709125164-image_cropper_1709125156888.jpg" alt="Image" class="img-fluid" />
                  </a>

                  <div class="property-content">
                    <div class="price mb-2"><span>1000Rs/hr</span></div>
                    <div>
                      <span class="d-block mb-2 text-black-50"
                        >5772 California Fake, Ave. 25BC</span
                      >
                      <span class="city d-block mb-3">Golden, USA</span>

                     

                      <a
                        href="property-single.html"
                        class="btn btn-primary py-2 px-3"
                        >BOOK NOW</a
                      >
                    </div>
                  </div>
                </div>

<!--              <div
                id="property-nav"
                class="controls"
                tabindex="0"
                aria-label="Carousel Navigation"
              >
                <span
                  class="prev"
                  data-controls="prev"
                  aria-controls="property"
                  tabindex="-1"
                  >Prev</span
                >
                <span
                  class="next"
                  data-controls="next"
                  aria-controls="property"
                  tabindex="-1"
                  >Next</span
                >
              </div>-->
            </div>
          </div>
        </div>
      </div>
    </div>
            </div>
        
    </body>
</html>
