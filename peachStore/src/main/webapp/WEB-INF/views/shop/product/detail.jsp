<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	Product product = (Product)request.getAttribute("product");
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
			<span class="title-h1" style="margin-left:165px;"><%=product.getProductSubcategory().getProductSubcategoryName()%> 구입하기</span>
		</div>
		<div class="detail-wrapper">
			<div class="detail-left">
				<div class="slideshow-container">
					<%for(ProductImg productImg:product.getProductImgs()){ %>
					<div class="mySlides">
						<img src="/data/product_<%=product.getProductId()%>/<%=productImg.getFilename() %>">
					</div>
					<%} %>
					<a class="prev" onclick="plusSlides(-1)">❮</a>
					<a class="next" onclick="plusSlides(1)">❯</a>
				</div>
				<br>

				<div style="text-align:center">
					<%for(int i=0;i<product.getProductImgs().size();i++){ %>
					<span class="dot" onclick="currentSlide(<%=i%>)"></span> 
					<%} %>
				</div>
			</div>
			
			<div class="detail-right">
				<div class="detail-introduce-wrapper">
					<div class="introduce-title"><%=product.getProductName() %></div>
					<div><%=product.getIntroduce() %></div>
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
		<!-- 상세설명 및 리뷰  시작  -->
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="product__details__tab">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Description</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Reviews</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-1" role="tabpanel">
								<h6>Description</h6>
								<p>detail></p>
							</div>
							<div class="tab-pane" id="tabs-2" role="tabpanel" style="padding: 20px 20px;">
								<h6>Reviews ( 2 )</h6>
								<ul class="review-list">
									<li class="review-item" id="item1">
										<div class="review-intro">
											<div class="review-writer">예닮</div>
											<div class="review-date">2025-07-31</div>
										</div>
										<div class="review-content">
											<div class="review-text">정말 좋은 제품이에요 사주세요 미니 너무 배터리가 빨리 닳아요 제발요정말 좋은 제품이에요 사주세요 미니 너무 배터리가 빨리 닳아요 빨리 닳아요 제발요정 빨리 닳아요 제발요정 제발요 </div>
											<div class="review-img">
												<img src="/static/shop/img/logo1.png">
												<img src="/static/shop/img/logo1.png">
											</div>
										</div>
									</li>
									<li class="review-item">
										<div class="review-intro">
											<div class="review-writer">예닮</div>
											<div class="review-date">2025-07-31</div>
										</div>
										<div class="review-content">
											<div class="review-text">정말 좋은 제품이에요!</div>
											<div class="review-img">
												<img src="/static/shop/img/logo1.png">
												<img src="/static/shop/img/logo1.png">
												<img src="/static/shop/img/logo1.png">
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 상세설명 및 리뷰 끝  -->
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
	<script type="text/javascript">
		/* 이미지 슬라이드  */
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

		/* 리뷰  */
		$(".review-item").click(function () {
			/* 클릭여부 판단 */ 
			const flag = $(this).hasClass("active");
			
			/* 모든 리뷰 초기화 */ 
			$(".review-item").removeClass("active").css("background-color", "");
			
			$(".review-text").css({
				"white-space": "nowrap",
				"overflow": "hidden",
				"text-overflow": "ellipsis"
			});
			
			$(".review-content").css({
				"flex-direction":"row"
			});
			
			$(".review-img").each(function () {
				$(this).children("img").hide().eq(0).show();  // 첫 번째 이미지만 보이게
			});
			
			$(".review-img img").css("width","35px");
			
			
			if (flag) return;
		
			/* 현재 클릭한 리뷰  */ 
			$(this).addClass("active").css("background-color", "#F4F4F4");
			
			$(this).find(".review-content").css({
				"flex-direction":"column",
				"justify-content": "",
				"align-items": "normal"
			});
		
			$(this).find(".review-text").css({
				"width":"90%",
				"white-space": "normal",       
				"overflow": "visible",           
				"text-overflow": "unset",
				"word-break": "break-word",
				"margin-bottom":"10px"
			});
			
			$(this).find(".review-img img").show(); // 모든 이미지 보이기
			$(this).find(".review-img img").css("width", "80px");
			
		});
		
		  
		$(document).ready(function () {
			$(".review-img").each(function () {
				$(this).children("img").hide().eq(0).show();  // 첫 번째 이미지만 보이게
			});
		});
	</script>
</body>
</html>