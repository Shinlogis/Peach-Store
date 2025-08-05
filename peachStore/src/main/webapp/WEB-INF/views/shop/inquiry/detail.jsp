<%@page import="peachstore.domain.InquiryImg"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("user");
Inquiry inquiry = (Inquiry) request.getAttribute("inquiry");
List<ProductTopcategory> topList =(List)request.getAttribute("topList");
User userGrade = (User)request.getAttribute("userGrade");
Integer reviewCount = (Integer)request.getAttribute("reviewCount");
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
													<div class="review-content">
														<%=inquiry.getInquiry_text()%>
													</div>
													
													<div style="display: flex; gap: 10px;">
														
														<button type="button" class="btn btn-secondary" 
														onclick="location.href='/shop/inquiry/updateform?inquiry_id=<%=inquiry.getInquiry_id()%>'">
														수정</button>
														
														<form method="post" id="delete" action="/shop/inquiry/delete">
														<input  type="hidden" name="inquiry_id" value="<%=inquiry.getInquiry_id()%>">
														<input type="hidden" name="user.user_id" value="<%=user.getUser_id()%>">
														</form>
														
														<button type="button" class="btn btn-secondary"
														onclick="if(confirm('삭제하시겠습니까?')) document.getElementById('delete').submit();">
														삭제</button>
														
												</td>
											</tr>
											
											<!-- 답변 내용 표시 -->
											<% if (inquiry.getAnswer_text() != null && !inquiry.getAnswer_text().trim().isEmpty()) {%>
											    <tr>
											        <td colspan="5" style="padding-top: 20px;">
											            <table style="width: 100%; border-top: 1px solid #ddd; padding-top: 10px;">
											                <tr>
											                    <td style="font-weight: bold; font-size: 16px; padding: 10px 0;">📢 관리자 답변</td>
											                </tr>
											                <tr>
											                    <td style="background-color: #f9f9f9; padding: 10px; border-radius: 5px;">
											                        <%=inquiry.getAnswer_text()%>
											                    </td>
											                </tr>
											            </table>
											        </td>
											    </tr>
											<% }%>
											
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