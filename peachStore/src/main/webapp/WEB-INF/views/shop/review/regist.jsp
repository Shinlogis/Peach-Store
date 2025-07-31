<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
.regist_content{
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

			<!-- 글 쓰기 시작 -->
			<section class="regist_content">
			<h3 style=" margin-bottom: 50px; font-weight:bold;">리뷰 쓰기</h3>
				<!-- Main content -->
				<section class="content">
					<!-- Default box -->
					<div class="card">
						<div class="card-body">
							<form action="/contact/send" method="post">
								<div class="form-group">
									<label for="inputName">Name</label> <input type="text"
										id="inputName" name="name" class="form-control" required />
								</div>
								<div class="form-group">
									<label for="inputEmail">E-Mail</label> <input type="email"
										id="inputEmail" name="email" class="form-control" required />
								</div>
								<div class="form-group">
									<label for="inputSubject">Subject</label> <input type="text"
										id="inputSubject" name="subject" class="form-control" />
								</div>
								<div class="form-group">
									<label for="inputMessage">Message</label>
									<textarea id="inputMessage" name="message" class="form-control"
										rows="4" required></textarea>
								</div>
								<div class="form-group">
									<button type="submit" class="btn btn-primary">Send
										message</button>
								</div>
							</form>
						</div>
					</div>
				</section>
				<!-- 글 쓰기 끝 -->
				
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