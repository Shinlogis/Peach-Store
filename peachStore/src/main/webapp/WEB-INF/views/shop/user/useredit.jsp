<%@page import="peachstore.domain.OrderDetail"%>
<%@page import="peachstore.domain.OrderReceipt"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	User userGrade = (User)request.getAttribute("userGrade");
	Integer reviewCount = (Integer)request.getAttribute("reviewCount");
	List<OrderReceipt> order = (List)request.getAttribute("receiptList");
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

			<section class="shop-cart spad">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="shop__cart__table">
								<table style="table-layout: fixed; width: 100%;">

									<div class="card-header"
										style="display: flex; justify-content: space-between; border-bottom: 2px solid black;">
										<h3 class="card-title" style="font-weight: bold;">내 정보</h3>
									</div>

									<table style="width: 100%; border-collapse: collapse;">
										<colgroup>
											<col style="width: 50%;">
											<col style="width: 30%;">
											<col style="width: 20%;">
										</colgroup>
										<thead>
											<tr style="border-bottom: 1px solid black;">
												<th style="font-weight: bold; font-size: 20px;">상품정보</th>
												<th style="font-weight: bold; font-size: 20px;">진행상태</th>
												<th style="font-weight: bold; font-size: 20px;">주문취소</th>
											</tr>
										</thead>
										<tbody>
											<tr style="background-color: #f5f5f5; ">
												<!-- 왼쪽: 주문정보 (2칸 합치기) -->
												<td colspan="2" style="font-weight: bold;">
												</td>

												<!-- 오른쪽: 주문취소 버튼 -->
												<td style="margin-right: 20px;">
													<form method="post" action="/shop/order/cancle"
														onsubmit="return confirm('주문취소 하시겠습니까?')"
														style="margin: 0;">
														<input type="hidden" name="user.user_id"
															value=""> <input
															type="hidden" name="order_receipt_id"
															value="">
														<button type="submit" class="btn btn-danger" style="padding: 2px 6px; font-size: 12px; line-height: 1.2;">회원정보 수정</button>
													</form>
												</td>
											</tr>



											<tr>
												<!-- 상품정보 -->
												<td>
													<div style="display: flex; gap: 100px;">
														<div>
															<div style="margin-bottom: 8px;">
															</div>
															<div style="margin-bottom: 8px;"></div>
															<div style="margin-bottom: 8px;">
															</div>
															<div>
																<strong>각인:</strong></div>
														</div>
													</div>
												</td>

												<!-- 진행상태 (각 detail마다 같은 orderReceipt status) -->
												<td></td>

												<!-- 주문취소 버튼 -->
												<td></td>
											</tr>

										</tbody>
									</table>


									</div>
									</div>
									</div>
									</div>
									</section>


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