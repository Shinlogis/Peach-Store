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
	<style>
	.capacity-label {
	  	display: flex;
	  	justify-content: space-between;
	  	width: 100%;
	  	padding-right: 15px;
	}
	</style>
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
					<div style="word-wrap: break-word; white-space: normal; width:400px"><%=product.getIntroduce() %></div>
				</div>
				<div class="detail-option-wrapper">
					<form id="cartForm" action="/shop/cart/insert" method="post">
						<fieldset>
							<legend>모델 </legend>
							<%for(ProductSize productSize :product.getProductSizes()){ %>
							<div>
								<input type="radio" id="size<%=productSize.getProduct_size_id() %>" name="product_size_id" value="<%=productSize.getProduct_size_id()%>">
								<label for="size<%=productSize.getProduct_size_id() %>"><%=productSize.getSize().getSize_name() %> 모델</label>
							</div>
							<%} %>
						</fieldset>
						
						<fieldset style="display:flex; gap:15px;">
							<legend id="color-title">색상</legend>
							<%for(ProductColor productColor:product.getProductColors()){ %>
							<div class="color-box">
								<input type="radio" id="color<%=productColor.getProduct_color_id() %>" name="product_color_id" value="<%=productColor.getProduct_color_id()%>" data-color-name="<%=productColor.getColor().getColor_name()%>">
								<label for="color<%=productColor.getProduct_color_id() %>" style="background-color:<%=productColor.getColor().getColor_value() %>;"></label>
							</div>
							<%} %>
						</fieldset>
							
						<fieldset>
							<legend>용량</legend>
							<%for(ProductCapacity productCapacity:product.getProductCapacities()){ %>
							<div>
								<input type="radio" id="<%=productCapacity.getProduct_capacity_id() %>" name="product_capacity_id" value="<%=productCapacity.getProduct_capacity_id() %>">
								<label for="<%=productCapacity.getProduct_capacity_id() %>" class="capacity-label">
  									<span><%=productCapacity.getCapacity().getCapacity_name() %></span>
  									<span class="price">추가금액 : <%=productCapacity.getAdditional_price() %></span>
								</label>
							</div>
							<%} %>
						</fieldset> 
						
						<input type="hidden" name ="product_id" value="<%=product.getProductId()%>">
						
						<!-- 가격 표시 영역 -->
						<div class="price-display" style="margin-top: 30px; padding: 20px; background: #f5f5f7; border-radius: 12px;">
							<div class="base-price">기본 가격: <%=String.format("%,d", product.getPrice())%>원</div>
							<div class="additional-price" id="additional-price" style="color: #06c; margin-top: 5px;"></div>
							<div class="total-price" id="total-price" style="font-size: 24px; font-weight: 600; margin-top: 10px; color: #1d1d1f;">
								총 가격: <%=String.format("%,d", product.getPrice())%>원
							</div>
						</div>
						
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
								<div style="display:flex; flex-direction: column; align-items: center;">
									<div class="title-h1" style="margin:10px 0 50px 0;">제품 구성</div>
									<%=product.getDetail()%>
								</div>
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
		
		$('input[name="product_size_id"], input[name="product_capacity_id"]').on('change', function() {
		    updatePrice();

		    scrollToNextFieldset(this);
		});
		
		/* 선택된 색상  */
		$(".color-box input").click(function(){
			let selectedColor=$('.color-box input[type="radio"]:checked').data('color-name');
			 $('#color-title').html('색상 - <strong>' + selectedColor + '</strong>');
			 
			 scrollToNextFieldset(this);
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
		
		/* 가격 계산 함수 */
		function updatePrice() {
			let basePrice = <%=product.getPrice()%>;
			let additionalPrice = 0;
			let additionalText = "";
			
			// 선택된 사이즈 추가 금액
			let selectedSize = $('input[name="product_size_id"]:checked');
			if (selectedSize.length > 0) {
				<%for(ProductSize productSize : product.getProductSizes()){ %>
					if (selectedSize.val() == '<%=productSize.getProduct_size_id()%>') {
						additionalPrice += <%=productSize.getAdditional_price()%>;
						<%if(productSize.getAdditional_price() != 0) { %>
							additionalText += "사이즈 옵션: +<%=String.format("%,d", productSize.getAdditional_price())%>원 ";
						<%} %>
					}
				<%} %>
			}
			
			// 선택된 용량 추가 금액
			let selectedCapacity = $('input[name="product_capacity_id"]:checked');
			if (selectedCapacity.length > 0) {
				<%for(ProductCapacity productCapacity : product.getProductCapacities()){ %>
					if (selectedCapacity.val() == '<%=productCapacity.getProduct_capacity_id()%>') {
						additionalPrice += <%=productCapacity.getAdditional_price()%>;
						<%if(productCapacity.getAdditional_price() != 0) { %>
							additionalText += "용량 옵션: +<%=String.format("%,d", productCapacity.getAdditional_price())%>원 ";
						<%} %>
					}
				<%} %>
			}
			
			// 화면 업데이트
			let totalPrice = basePrice + additionalPrice;
			$("#additional-price").text(additionalText);
			$("#total-price").text("총 가격: " + totalPrice.toLocaleString() + "원");
		}
		
		
		function scrollToNextFieldset(currentInput) {
		    const currentFieldset = currentInput.closest('fieldset');
		    if (!currentFieldset) return;

		    let targetElement;
		    const legendText = currentFieldset.querySelector('legend')?.innerText?.trim();

		    // 용량이면 스크롤하지 않고 그냥 return
		    if (legendText === '용량') return;

		    if (legendText === '용량') {
		        targetElement = document.querySelector('.price-display');
		    } else {
		        const nextFieldset = currentFieldset.nextElementSibling;
		        targetElement = nextFieldset || document.querySelector('.price-display');
		    }

		    if (targetElement) {
		        const offset = 200;  // 덜 스크롤 되게
		        const rect = targetElement.getBoundingClientRect();
		        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
		        const targetPosition = rect.top + scrollTop - offset;

		        window.scrollTo({
		            top: targetPosition,
		            behavior: 'smooth'
		        });
		    }
		}
		
		$(document).ready(function () {
			$(".review-img").each(function () {
				$(this).children("img").hide().eq(0).show();  // 첫 번째 이미지만 보이게
			});
			
			/* // 옵션 선택 시 가격 업데이트
			$('input[name="product_size_id"], input[name="product_capacity_id"]').change(function() {
				updatePrice();
			}); */
			
			$("input[type='button']").click(function () {
				  $("#cartForm").submit();
			});
		});
		
		
	</script>
</body>
</html>