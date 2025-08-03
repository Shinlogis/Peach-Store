<%@page import="peachstore.domain.ReviewImg"%>
<%@page import="peachstore.domain.Review"%>
<%@page import="peachstore.domain.InquiryImg"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("user");
List<Review> reviewList = (List) request.getAttribute("reviewList");
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
<%@ include file="../inc/head_link.jsp"%>
<link rel="stylesheet" href="/static/shop/css/mypage.css">
<style type="text/css">
#img {
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
				<section class="shop-cart spad">
					<div class="container">
						<div class="row">
							<div class="col-lg-12">
								<div class="shop__cart__table">

									<table style="table-layout: fixed; width: 70%; margin-left: 80px">
										<thead>
											<tr>
												<th colspan="5">
													<div class="card-header"
														style="display: flex; justify-content: space-between;">
														<h3 class="card-title" style="font-weight: bold;">리뷰상세</h3>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(Review review : reviewList){ %>
											<tr>
												<td colspan="5">
												
													<div><%=review.getOrderDetail().getOrder_detail_id() %></div>
													<div><%=review.getOrderDetail().getSnapShot().getProduct_name() %></div>
													<div><%=review.getOrderDetail().getSnapShot().getColor() %></div>
													<div><%=review.getOrderDetail().getSnapShot().getCapacity() %></div>
													<!-- 작성일 -->
													<div
														style="text-align: right; color: gray; font-size: 14px; margin-bottom: 10px;">
														<%= review.getRegdate().toLocalDate()%>
													</div> <!-- 이미지 -->
													<div
														style="display: flex; gap: 10px; margin-bottom: 10px; overflow-x: auto; white-space: nowrap;">
														<%
														if (review.getImgList() != null && !review.getImgList().isEmpty()) {
															for (ReviewImg img : review.getImgList()) {
														%>
														<img
															src="/data/r_<%=review.getReviewId()%>/<%=img.getFilename()%>"
															style="width: 100px; height: 100px; object-fit: cover; flex-shrink: 0;">
														<%
														
														}
														}
														%>
														
													</div> <!-- 내용 -->
													<div
														style="white-space: pre-wrap; font-size: 20px !important; color: black;">
														<%=review.getContent()%>
													</div>
													
													<div style="display: flex; gap: 10px;">
														
														<button type="button" class="btn btn-secondary" 
														onclick="location.href='/shop/inquiry/updateform?inquiry_id=<%=review.getReviewId()%>'">
														수정</button>
														
														<form method="post" id="delete" action="/shop/inquiry/delete">
														<input  type="hidden" name="reviewId" value="<%=review.getReviewId()%>">
														<input type="hidden" name="user.user_id" value="<%=user.getUser_id()%>">
														</form>
														
														<button type="button" class="btn btn-secondary"
														onclick="if(confirm('삭제하시겠습니까?')) document.getElementById('delete').submit();">
														삭제</button>
														
												</td>
											</tr>
											<%} %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</section>
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