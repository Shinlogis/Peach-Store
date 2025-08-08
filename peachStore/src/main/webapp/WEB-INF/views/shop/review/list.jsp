<%@page import="peachstore.util.Paging"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxConnection.CapabilitiesGetOrBuilder"%>
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
User userGrade = (User)request.getAttribute("userGrade");
Integer reviewCount = (Integer)request.getAttribute("reviewCount");
Paging paging = (Paging)request.getAttribute("paging");

int firstPage = paging.getFirstPage();
int lastPage = paging.getLastPage();
int currentPage = paging.getCurrentPage();
int totalPage = paging.getTotalPage();
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
<style>
 .review-content p {
    font-size: 16px !important;
    color: black !important;
}

.btn-secondary{
	height: 30px; !important;
	width: 50px; !important;
	font-size: 13px; !important;
	text-align: center; !important;
	margin-top: 20px;
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
					<div class="container" >
						<div class="row">
							<div class="col-lg-12">
								<div class="shop__cart__table">

									<table style="table-layout: fixed; width: 100%;">
										<thead>
											<tr>
												<th colspan="5">
													<div class="card-header"
														style="display: flex; justify-content: space-between; width: 100%;">
														<h3 class="card-title" style="font-weight: bold;">내 리뷰</h3>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
										<%for(Review review : reviewList){ %>
											<tr style="width: 930px;">
												<td colspan="5">
													<div style="display: flex; flex-direction: column; background-color: #f5f5f5;">
													  <!-- 사진 + 상품 이름 한 줄 -->
													  <div style="display: flex; gap:20px;">
													    <img src="<%=review.getOrderDetail().getSnapShot().getFilename()%>" 
													         style="width: 50px; height: 50px; margin-right: 5px;">
													    <div><%=review.getOrderDetail().getSnapShot().getProduct_name() %>
													  
													  
													  <div style="display: flex; gap:10px">
													  <div><%=review.getOrderDetail().getSnapShot().getColor() %></div>
													  <div><%=review.getOrderDetail().getSnapShot().getCapacity() %></div>
													  </div>
													  </div>
													</div>
													</div>
													
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
													<div class="review-content">
														<%=review.getContent()%>
													</div>
													
													<div style="display: flex; gap: 10px;">
														
														<button type="button" class="btn btn-secondary" 
														onclick="location.href='/shop/review/updateform?reviewId=<%=review.getReviewId()%>'">
														 수정</button>
														
														<form method="post" id="delete_<%=review.getReviewId()%>" action="/shop/review/delete">
														<input  type="hidden" name="reviewId" value="<%=review.getReviewId()%>">
														<input type="hidden" name="user.user_id" value="<%=user.getUser_id()%>">
														</form>
														
														<button type="button" class="btn btn-secondary"
														onclick="if(confirm('삭제하시겠습니까?')) document.getElementById('delete_<%=review.getReviewId()%>').submit();">
														삭제</button>
													</div>
														
												</td>
											</tr>
											<%} %>
										</tbody>
									</table>
									<!-- 페이징 처리 -->
										<div class="card-footer d-flex justify-content-center">
											<ul class="pagination pagination-sm m-0">
											<!-- 이전 페이지 버튼 -->
												<li
													class="page-item <%=(firstPage <= 1 ? "disabled" : "")%>">
													<a class="page-link"
													href="<%=(firstPage > 1) ? ("/shop/review/list?currentPage=" + (firstPage - 1)) : "#"%>">&laquo;</a>
												</li>
												<!-- 페이지 번호 목록 -->
												<%
												for (int i = firstPage; i <= lastPage && i <= totalPage; i++) {
												%>
												<li
													class="page-item <%=(i == currentPage ? "active" : "")%>">
													<a class="page-link"
													href="/shop/review/list?currentPage=<%=i%>"><%=i%></a>
												</li>
												<%
												}
												%>
		
												<!-- 다음 페이지 버튼 -->
												<li
													class="page-item <%=(lastPage >= totalPage ? "disabled" : "")%>">
													<a class="page-link"
													href="<%=(lastPage < totalPage) ? ("/shop/review/list?currentPage=" + (lastPage + 1)) : "#"%>">&raquo;</a>
												</li>
											
									</div>
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