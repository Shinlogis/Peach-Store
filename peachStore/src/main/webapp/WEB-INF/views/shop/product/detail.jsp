<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>
   <%@ include file="../inc/head_link.jsp" %>
   <link rel="stylesheet"  href="/static/shop/css/product/productDetail.css">
</head>
<body>
    <!-- Offcanvas Menu Begin -->
   <%@ include file="../inc/offcanvas.jsp" %>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
   <%@ include file="../inc/header.jsp"%>
    <!-- Header Section End -->
    
   <!-- 내용 시작 Begin -->
    <section class="product-detail">
    	<div>
    		<span class="title-h1" style="margin-left:165px;">iPad Air 구입하기</span>
    	</div>
    	<div class="detail-wrapper">
			<div class="detail-left">
    			<div class="slideshow-container">
					<div class="mySlides">
					  <img src="/static/shop/img/product/iphone.png">
					</div>
					
					<div class="mySlides">
					  <img src="/static/shop/img/product/iphone.png">
					</div>
					
					<div class="mySlides">
					  <img src="/static/shop/img/product/iphone.png">
					</div>
					
					<a class="prev" onclick="plusSlides(-1)">❮</a>
					<a class="next" onclick="plusSlides(1)">❯</a>
				</div>
				<br>

				<div style="text-align:center">
				  <span class="dot" onclick="currentSlide(1)"></span> 
				  <span class="dot" onclick="currentSlide(2)"></span> 
				  <span class="dot" onclick="currentSlide(3)"></span> 
				</div>
			</div>
			
    		<div class="detail-right">
    			<div class="detail-introduce-wrapper">
    				<div class="introduce-title">product_namepr</div>
    				<div>간단한 한 줄 소개</div>
    			</div>
    			<div class="detail-option-wrapper">
    				<div class="detail-option-group">
   						<fieldset>
							<legend>선택해라</legend>
						  <div>
						    <input type="radio" id="html1" name="group1" value="html">
						    <label for="html1">HTML</label>
						  </div>
						  <div>
						    <input type="radio" id="html2" name="group1" value="aaa">
						    <label for="html2">aaa</label>
						  </div>
						</fieldset>
							
						<fieldset>
							<legend>너도 선택해라</legend>
							<div>
							  <input type="radio" id="a" name="group2" value="kim">
							  <label for="a">김지민바보</label>
							</div>
							<div>
							  <input type="radio" id="b" name="group2" value="seo">
							  <label for="b">서예닮바보</label>
							</div>
						</fieldset>
						<input type="button" value="장바구니에 담기">
    				</div>
    			</div>
    		</div>
    	</div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Description</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Specification</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">Reviews ( 2 )</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <h6>Description</h6>
                                <p>detail></p>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <h6>Specification</h6>
                                <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed
                                    quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt loret.
                                    Neque porro lorem quisquam est, qui dolorem ipsum quia dolor si. Nemo enim ipsam
                                    voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed quia ipsu
                                    consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Nulla
                                consequat massa quis enim.</p>
                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget
                                    dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes,
                                    nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium
                                quis, sem.</p>
                            </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <h6>Reviews ( 2 )</h6>
                                <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed
                                    quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt loret.
                                    Neque porro lorem quisquam est, qui dolorem ipsum quia dolor si. Nemo enim ipsam
                                    voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed quia ipsu
                                    consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Nulla
                                consequat massa quis enim.</p>
                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget
                                    dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes,
                                    nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium
                                quis, sem.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   <!-- 내용 End -->

   <!-- Instagram Begin -->
   <%@ include file="../inc/instagram.jsp" %>   
   <!-- Instagram End -->

   <!-- Footer Section Begin -->
   <%@ include file="../inc/footer.jsp" %>
   <!-- Footer Section End -->

   <!-- Search Begin -->
   <%@ include file="../inc/search.jsp" %>
   <!-- Search End -->

   <!-- Js Plugins -->
   <%@ include file="../inc/footer_link.jsp" %>
<script>
let slideIndex = 1;

document.addEventListener("DOMContentLoaded", function () {
  showSlides(slideIndex);
});

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].classList.remove("fade");
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].classList.add("fade");
  dots[slideIndex-1].className += " active";
}
</script>
</body>
</html>