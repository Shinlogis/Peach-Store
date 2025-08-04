<%@page import="peachstore.domain.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 등급조회 테이블 시작 -->
				<div class="col-6">
					<!-- 두 col-5가 wrapper2 안에 둘 다 있음 -->
					<div class="card grade-card">
						<div class="grade-header">
							<h5 class="grade-title" style="margin-top: 20px; padding-left: 20px; color: white;">멤버십 등급</h5>
						</div>
						<div class="card-body">
							<table >
								<thead>
									<tr>
										<th style="padding-top: 15px; padding-bottom: 15px;"><%=userGrade.getUser_grade().getUserGradeName() %></th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<!-- 등급 조회 테이블 끝 -->

				<!-- 리뷰조회 테이블 시작 -->
				<div class="col-6">
					<div class="card review-card">
						<div class="review-header">
							<h5 class="grade-title" style="margin-top: 20px; padding-left: 20px;">
							<a href="#" style="color: white;">나의 리뷰</a></h5>
						</div>
						<div class="card-body">
							<table>
								<thead>
									<tr>
										<th style="padding-top: 15px; padding-bottom: 15px;"><%=reviewCount%>개</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
