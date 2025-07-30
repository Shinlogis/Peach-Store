<%@page import="peachstore.domain.InquiryImg"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("user");
Inquiry inquiry = (Inquiry) request.getAttribute("inquiry");
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
			<form>
				<input type="hidden" name="user.user_id"
					value="<%=user.getUser_id()%>">
				<section class="shop-cart spad">
					<div class="container">
						<div class="row">
							<div class="col-lg-12">
								<div class="shop__cart__table">

									<table style="table-layout: fixed; width: 70%;">
										<thead>
											<tr>
												<th colspan="5">
													<div class="card-header"
														style="display: flex; justify-content: space-between;">
														<h3 class="card-title" style="font-weight: bold;">문의상세</h3>
													</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="5">
													<!-- 제목 -->
													<h4 style="margin-bottom: 5px;"><%=inquiry.getTitle()%></h4>

													<!-- 작성일 -->
													<div
														style="text-align: right; color: gray; font-size: 14px; margin-bottom: 10px;">
														<%=inquiry.getCreated_at().toLocalDate()%>
													</div> <!-- 이미지 -->
													<div
														style="display: flex; gap: 10px; margin-bottom: 10px; overflow-x: auto; white-space: nowrap;">
														<%
														if (inquiry.getImgList() != null && !inquiry.getImgList().isEmpty()) {
															for (InquiryImg img : inquiry.getImgList()) {
														%>
														<img
															src="/data/p_<%=inquiry.getInquiry_id()%>/<%=img.getFilename()%>"
															style="width: 100px; height: 100px; object-fit: cover; flex-shrink: 0;">
														<%
														}
														}
														%>
													</div> <!-- 내용 -->
													<div
														style="white-space: pre-wrap; font-size: 20px !important; color: black;">
														<%=inquiry.getInquiry_text()%>
													</div>
													<div>
														<button type="button" class="btn btn-secondary">수정</button>
														<button type="button" class="btn btn-secondary">삭제</button>
													</div>
												</td>
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