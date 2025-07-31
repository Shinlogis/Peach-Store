<%@page import="peachstore.domain.OrderDetail"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user"); 
	
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<OrderDetail> orderDetail = (List)request.getAttribute("orderDetail");
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
#img{
	width: 50px;
	height: 50px;
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

			
 <!-- 리스트 시작 -->
   <form >
   <input type="hidden" name="user.user_id" value="<%= user.getUser_id()%>">
			<section class="shop-cart spad">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="shop__cart__table">
								<table style="table-layout: fixed; width: 100%;">
								
								<div class="card-header"
										style="display: flex; justify-content: space-between; border-bottom: 2px solid black;">
										<h3 class="card-title" style="font-weight: bold;">문의 내역</h3>

									</div>
								
									
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 30%;">
										<col style="width: 30%;">
										<col style="width: 20%;">
									</colgroup>
									<thead>
									<br><br>
										<tr style="border-bottom: 1px solid black;">
											<th style="font-weight: bold; font-size: 20px;">번호</th>
											<th style="font-weight: bold; font-size: 20px;">주문내역</th>
											<th style="font-weight: bold; font-size: 20px;">제목</th>
											<th style="font-weight: bold; font-size: 20px;">작성일</th>
										</tr>
									</thead>
									<tbody>
									
										<tr>
											<!-- 번호 -->
											<td class="cart__price" style="color: black;"></td>

											<!-- 주문내역 -->
											<td class="cart__product__item">
											
												</td>

											

											<!-- 작성일 -->
										 	<%-- <td class="cart__total" style="color: black;"><%=orderDetail.get(0).getOrderReceipt().getOrderdate() %></td> --%>
											
											<!-- 수량 -->
											<td class="cart__total" style="color: black;"><%= orderDetail.get(0).getOrder_quantity()%>개</td>
										</tr>
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</section>
			</form>
			<!-- 리스트 끝 -->

    
				
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

	<!-- AdminLTE for demo purposes -->
	<script src="/static/admin/dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="/static/admin/dist/js/pages/dashboard.js"></script>
</body>

</html>