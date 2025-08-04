<%@page import="peachstore.domain.ProductSize"%>
<%@page import="peachstore.domain.ProductCapacity"%>
<%@page import="peachstore.domain.ProductColor"%>
<%@page import="peachstore.domain.ReviewImg"%>
<%@page import="peachstore.domain.Review"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	Product product = (Product)request.getAttribute("product");
	List<Review> reviewList = (List)request.getAttribute("reviewList");
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
					<form id="cartForm" action="/shop/cart/insert" method="post">
						<fieldset>
							<legend>사이즈 </legend>
							<%for(ProductSize productSize :product.getProductSizes()){ %>
							<div>
								<input type="radio" id="size<%=productSize.getSize().getSize_id() %>" name="size" value="<%=productSize.getSize().getSize_id()%>">
								<label for="size<%=productSize.getSize().getSize_id() %>"><%=productSize.getSize().getSize_name() %></label>
							</div>
							<%} %>
						</fieldset>
						
						<fieldset style="display:flex; gap:15px;">
							<legend id="color-title">색상</legend>
							<%for(ProductColor productColor:product.getProductColors()){ %>
							<div class="color-box">
								<input type="radio" id="color<%=productColor.getColor().getColor_id() %>" name="color" value="<%=productColor.getColor().getColor_name()%>">
								<label for="color<%=productColor.getColor().getColor_id() %>" style="background-color:<%=productColor.getColor().getColor_name() %>;"></label>
							</div>
							<%} %>
						</fieldset>
							
						<%--<fieldset>
							<legend>용량</legend>
							<%for(ProductCapacity prdocutCapacity:product.getProductCapacities()){ %>
							<div>
								<input type="radio" id="<%=prdocutCapacity.getCapacity().getCapacity_id() %>" name="group1" value="html">
								<label for="<%=prdocutCapacity.getCapacity().getCapacity_id() %>"><%=prdocutCapacity.getCapacity().getCapacity_name() %></label>
							</div>
							<%} %>
						</fieldset> --%>
						<input type="button" value="장바구니에 담기">
					</form>
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
								<h6>총 리뷰 수 : <%=reviewList.size()%> 개</h6>
								<ul class="review-list">
									<%for(Review review:reviewList) {%>
									<li class="review-item" id="item1">
										<div class="review-intro">
											<div class="review-writer"><%=review.getUser().getUser_name() %></div>
											<div class="review-date"><%=review.getRegdate() %></div>
										</div>
										<div class="review-content">
											<div class="review-text"><%=review.getContent() %></div>
											<div class="review-img">
												<%List<ReviewImg> imgList=review.getImgList();
												for (ReviewImg img : imgList) {
									                String imagePath = "/data/r_" + review.getReviewId() + "/" + img.getFilename();
									    		%>
									                <img src="<%= imagePath %>" alt="리뷰 이미지" style="max-width: 200px; margin-right: 10px;">
									    		<%}%>
											</div>
										</div>
									</li>
									<%} %>
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
		
		/* 선택된 색상  */
		$(".color-box input").click(function(){
			let selectedColor=$('.color-box input[type="radio"]:checked').val();
			 $('#color-title').html('색상 - <strong>' + selectedColor + '</strong>');
		})

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
			
			$("input[type='button']").click(function () {
				  $("#cartForm").submit();
			});
		});
	</script>
</body>
</html>