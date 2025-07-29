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
<%@ include file="../inc/head_link.jsp" %>
    
</head>
<body style="background-color:#fff;">
<%@ include file="../inc/offcanvas.jsp" %>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
<%@ include file="../inc/header.jsp" %>
    <!-- Header Section End -->

 <!-- product-list-section start -->
 <section id="product-list-section" style="margin:auto">
	<!-- 제목 -->
	<div>
		<span class="acc-h1">당신의 새로운 PPhone 구입하기  </span>
		<img src="/static/shop/img/product/accessory/accessory-banner.png">
	</div>
	<!-- 제목 -->
	
	<!-- 서브카테고리토글  시작 -->
	<div class=sub-category-accessory>
		<div class="sub-category-accessory">
			<button class="btn-item" id="btn16">16시리즈</button>
			<button class="btn-item">15시리즈</button>
		</div>
	</div>
	<!-- 서브카테고리토글 끝-->
	
	<!--상품 리스트  -->
	<div class="acc-content-container">
	       <div class="acc">
	           <img src="/static/shop/img/product/accessory/airpods.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	       <div class="acc">
	           <img src="/static/shop/img/product/iphone.png" class="slide" alt="Slide 1">
	           <div class="acc_name">iPhone 16 PRO</div>
	           <div class="acc_price">💲199,0000원</div>
	       </div>
	   </div>
	<!--상품 리스트  -->
</section>
 <!--  product-list-section end -->

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

<!-- AdminLTE for demo purposes -->
<script src="/static/admin/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/static/admin/dist/js/pages/dashboard.js"></script>
</body>
</html>
<style>
.acc-h1{
	font-size: 48px;
    font-weight: 800;
    margin-left:165px;
}

.acc-content-container{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 70px;
    max-width: 900px; 
    margin: auto;       
}

.acc{
    display: flex;
    align-items: center;
    flex-direction: column;
    width: 260px;
    heigth:407px;
    margin: auto;
    position: relative;
    border-radius:18px;
    background-color:#f5f5f7;
    padding:24px;
}  

.acc img{
    height: 250px;
}

.acc_name{
  	font-size: 17px;
    font-weight: bold;
    margin-top: 50px;
    color:#1d1d1f;
}

.acc_price{
    font-size: 14px;
    margin-top: 30px;
    font-weight: 600;
    color:#1d1d1f;
}
</style>
<script>
</script>
