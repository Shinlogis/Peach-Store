<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ashion Template">
<meta name="keywords" content="Ashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Ashion | Template</title>
<%@ include file="../inc/head_link.jsp"%>
<link rel="stylesheet" href="/static/shop/css/mypage.css">
<style type="text/css">
.regist_content {
	margin-top: 70px;
	width: 1050px;
	padding-left: 20px;
}
</style>

</head>

<body>
	<!-- Page Preloder -->
	<%@ include file="../inc/preloader.jsp"%>
	<!-- Offcanvas Menu Begin -->
	<%@ include file="../inc/offcanvas.jsp"%>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<%@ include file="../inc/header.jsp"%>
	<!-- Header Section End -->



	<div class="wrapper1">
		<%@include file="../inc/mypage_category.jsp"%>
		<div>
			<div class="wrapper2">
				<%@include file="../inc/mypage_review_coupon.jsp"%>
			</div>

			<!-- 상품 내역 시작 -->
			<section class="shop-cart spad">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="shop__cart__table">
								<table style="table-layout: fixed; width: 100%;">
									<div class="card-header"
										style="display: flex; justify-content: space-between;">
										<h3 class="card-title" style="font-weight: bold;">최근 주문</h3>
										<a href="#" style="color: black;">더보기 ></a>

									</div>
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 40%;">
										<col style="width: 20%;">
										<col style="width: 20%;">
									</colgroup>
									<thead>
									<br><br>
										<tr>
											<th>주문일</th>
											<th>주문내역</th>
											<th>주문번호</th>
											<th>결제금액</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<!-- 주문일 -->
											<td class="cart__price" style="color: black;">20260725</td>

											<!-- 주문내역 -->
											<td class="cart__product__item"><img
												src="/static/shop/img/shop-cart/cp-1.jpg" alt="">
												<div class="cart__product__item__title">
													<h6>Chain bucket bag</h6>
												</div></td>

											<!-- 주문번호 -->
											<td class="cart__order__number">
												<h6>1233413</h6>
											</td>

											<!-- 결제금액 -->
											<td class="cart__total">$ 300.0</td>
										</tr>

										<tr>
											<!-- 주문일 -->
											<td class="cart__price" style="color: black;">20260725</td>

											<!-- 주문내역 -->
											<td class="cart__product__item"><img
												src="/static/shop/img/shop-cart/cp-1.jpg" alt="">
												<div class="cart__product__item__title">
													<h6>Chain bucket bag</h6>
												</div></td>

											<!-- 주문번호 -->
											<td class="cart__order__number">
												<h6>1233413</h6>
											</td>

											<!-- 결제금액 -->
											<td class="cart__total">$ 300.0</td>
										</tr>
										<tr>
											<!-- 주문일 -->
											<td class="cart__price" style="color: black;">20260725</td>

											<!-- 주문내역 -->
											<td class="cart__product__item"><img
												src="/static/shop/img/shop-cart/cp-1.jpg" alt="">
												<div class="cart__product__item__title">
													<h6>Chain bucket bag</h6>
												</div></td>

											<!-- 주문번호 -->
											<td class="cart__order__number">
												<h6>1233413</h6>
											</td>

											<!-- 결제금액 -->
											<td class="cart__total">$ 300.0</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- 상품내역 끝 -->



		</div>
	</div>

	<!-- Footer Section Begin -->
	<%@ include file="../inc/footer.jsp"%>
	<!-- Footer Section End -->

	<!-- Search Begin -->
	<%@ include file="../inc/search.jsp"%>
	<!-- Search End -->

	<!-- Js Plugins -->
	<%@ include file="../inc/footer_link.jsp"%>

	
</body>

</html>