<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ashion Template">
<meta name="keywords" content="Ashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Ashion | Template</title>
<%@ include file="../inc/head_link.jsp"%>

<style>
.wrapper1 {
	display: flex; /*카테고리, 테이블 좌우 정렬*/
	padding: 30px; /* 전체 여백 추가 */
	gap: 120px; /* 카테고리와 테이블 사이 간격 */
}
.sidebar__categories{
	padding-left: 20px;
}
.table-card{
	margin-top: 200px;
}
.card-header {
    background-color: transparent !important;
    border-bottom: 1px solid black; /* 굵은 밑줄 추가 */
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

		<section class="services spad">

			<div class="sidebar__categories">
				<div class="categories__accordion">
					<div class="card">
						<div class="card-header">
							<a>나의 쇼핑정보</a>
						</div>
						<div class="card-body">
							<ul>
								<li><a href="#">주문내역 조회</a></li>
								<li><a href="#">취소내역</a></li>
								<li><a href="#">상품리뷰</a></li>
							</ul>
						</div>
					</div>
					<div class="card">
						<div class="card-header">
							<a>나의 계정정보</a>
						</div>
						<div class="card-body">
							<ul>
								<li><a href="#">회원정보 수정</a></li>
							</ul>
						</div>
					</div>
					<div class="card">
						<div class="card-header">
							<a>고객센터</a>
						</div>
						<div class="card-body">
							<ul>
								<li><a href="#">1:1문의</a></li>
							</ul>
						</div>
					</div>
					<div class="card">
						<div class="card-header">
							<a>문의내역</a>
						</div>
						<div class="card-body">
							<ul>
								<li><a href="#">나의 문의내역 보기</a></li>
							</ul>
						</div>
					</div>
					
				</div>
			</div>

		</section>

		<!-- /.테이블 시작 -->
		<div class="row">
			<div class="col-12">
				<div class="card table-card">
					<div class="card-header">
						<h3 class="card-title">주문내역</h3>
					</div>
					<div class="card-body">
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>ID</th>
									<th>User</th>
									<th>Date</th>
									<th>Status</th>
									<th>Reason</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>183</td>
									<td>John Doe</td>
									<td>11-7-2014</td>
									<td><span class="tag tag-success">Approved</span></td>
									<td>Bacon ipsum dolor sit amet salami venison chicken
										flank fatback doner.</td>
								</tr>
								<tr>
									<td>219</td>
									<td>Alexander Pierce</td>
									<td>11-7-2014</td>
									<td><span class="tag tag-warning">Pending</span></td>
									<td>Bacon ipsum dolor sit amet salami venison chicken
										flank fatback doner.</td>
								</tr>
								<tr>
									<td>657</td>
									<td>Bob Doe</td>
									<td>11-7-2014</td>
									<td><span class="tag tag-primary">Approved</span></td>
									<td>Bacon ipsum dolor sit amet salami venison chicken
										flank fatback doner.</td>
								</tr>
								<tr>
									<td>175</td>
									<td>Mike Doe</td>
									<td>11-7-2014</td>
									<td><span class="tag tag-danger">Denied</span></td>
									<td>Bacon ipsum dolor sit amet salami venison chicken
										flank fatback doner.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- /.테이블 끝 -->
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