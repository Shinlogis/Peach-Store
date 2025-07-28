<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>
<%@ include file="./inc/head_link.jsp" %>
    
</head>
<body style="background-color:#f5f5f7;">
<%@ include file="./inc/offcanvas.jsp" %>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
<%@ include file="./inc/header.jsp" %>
    <!-- Header Section End -->

 <!-- product-list-section start -->
 <section id="product-list-section" style="margin:auto">
	<!-- 제목 -->
	<div>
		<span class="title-h1">당신의 새로운 PPhone 구입하기  </span>
	</div>
	<!-- 제목 -->
	
	<!-- 서브카테고리토글  시작 -->
	<div class=sub-category-toggle >
		<div class=sub-category-toggle-buttons>
			<button class="btn-item" id="btn16">16시리즈</button>
			<button class="btn-item">15시리즈</button>
		</div>
	</div>
	<!-- 서브카테고리토글 끝-->
	
	<!--상품 리스트  -->
	<div class="content-container">
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	       <div class="item">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="p_name">iPhone 16 PRO</div>
	           <div class="p_price">💲199,0000원</div>
	           <a href="" class="item-btn">쇼핑하기</a>
	       </div>
	   </div>
	<!--상품 리스트  -->
</section>
 <!--  product-list-section end -->

<!-- Trend Section Begin -->
<%@ include file="./inc/trend_section.jsp" %>
<!-- Trend Section End -->

<!-- Instagram Begin -->
<%@ include file="./inc/instagram.jsp" %> 
<!-- Instagram End -->

<!-- Footer Section Begin -->
<%@ include file="./inc/footer.jsp" %>
<!-- Footer Section End -->

<!-- Search Begin -->
<%@ include file="./inc/search.jsp" %>
<!-- Search End -->

<!-- Js Plugins -->
<%@ include file="./inc/footer_link.jsp" %>

<!-- AdminLTE for demo purposes -->
<script src="/static/admin/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/static/admin/dist/js/pages/dashboard.js"></script>
</body>
</html>
<style>
#product-list-section{
	text-align: center;
}

.content-container{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 70px;
    max-width: 900px;  /* 원하는 최대 너비 */
    margin: auto;       /* 가운데 정렬 */
}

.sub-category-toggle{
	display:flex;
	justify-content:center;
	margin: 50px 0 40px;
}

.sub-category-toggle-buttons{
	background-color:#fff;
	border-radius: 18px;
	padding: 8px;
	
}

.sub-category-toggle button{
	border:none;
	border-radius:18px;
	background-color:#fff;
	padding: 3px 10px;
	font-size:18px;
	font-weight:600;
}

.item{
    display: flex;
    align-items: center;
    flex-direction: column;
    width: 260px;
    margin: auto;
    position: relative;
    border-radius:18px;
    background-color:#fff;
    padding-top:20px;
    box-shadow: 2px 4px 12px #00000014;
}  

.item img{
    width: 70%;
}

.item:hover .item-btn{
    transform: translate(-50%, 0);
    opacity: 1;
}

.p_name{
  	font-size: 24px;
    font-weight: bold;
    margin-top: 30px;
}

.p_price{
    font-size: 20px;
    margin-top: 10px;
    color: gray;
}

.item-btn{
    position: absolute;
    top: 40%;
    left: 50%;
    margin: auto;
    display: block;
    padding: 10px 20px;
    background-color: #0071e3;  
    color: white;
    border: none;
    border-radius: 28px;
    font-size: 1rem;
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.3s, transform 0.3s;
    transform: translate(-50%, 10px);
    text-align: center;
}
</style>
<script>
$(".btn-item").click(function () {
    $(".btn-item").css({
      "background-color": "",
      "color": ""
    });

    $(this).css({
      "background-color": "#1d1d1f",
      "color": "white"
    });
  });
</script>
