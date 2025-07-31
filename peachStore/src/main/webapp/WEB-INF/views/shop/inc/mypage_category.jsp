<%@page import="peachstore.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 카테고리 시작 -->
<section class="services spad">

	<div class="sidebar__categories">
		<div class="categories__accordion">
			<div class="card">
				<div class="card-header">
					<a>나의 쇼핑정보</a>
				</div>
				<div class="card-body">
					<ul>
						<li><a href="/shop/order/list">주문내역 조회</a></li>
						<li><a href="/shop/order/cancle/list">취소내역</a></li>
					</ul>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<a>리뷰</a>
				</div>
				<div class="card-body">
					<ul>
						<li><a href="#">리뷰 작성</a></li>
						<li><a href="#">내 리뷰</a></li>
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
					<a>문의내역</a>
				</div>
				<div class="card-body">
					<ul>
						<li><a href="/shop/inquiry/list">나의 문의내역 보기</a></li>
					</ul>
				</div>
			</div>
			

		</div>
	</div>
</section>
<!-- 카테고리 끝 -->