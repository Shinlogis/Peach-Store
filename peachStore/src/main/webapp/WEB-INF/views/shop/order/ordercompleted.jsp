<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.Review"%>
<%@page import="peachstore.domain.OrderReceipt"%>
<%@page import="peachstore.domain.OrderDetail"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user"); 
	
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<OrderReceipt> completedList = (List)request.getAttribute("completedList");
	List<Review> writtenReview = (List)request.getAttribute("writtenReview");
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
<style type="text/css">
.btn-link{
	font-size: 14px; !important;
	text-align: center; !important;
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
								<table style="table-layout: fixed; width: 100%;">
								
								<div class="card-header" style="display: flex; justify-content: space-between; border-bottom: 2px solid black;">
   								 <h3 class="card-title" style="font-weight: bold;">주문 내역</h3>
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
							            <th style="font-weight: bold; font-size: 20px;">리뷰작성</th>
							        </tr>
							    </thead>
							    <tbody>
							        <% for(OrderReceipt orderReceipt : completedList) { %>
							         <!-- 주문 단위 블럭 시작 -->
						            <tr style="background-color: #f5f5f5;">
						                <td colspan="3" style="padding: 10px; font-weight: bold;">
						                    주문번호: <%=orderReceipt.getOrder_receipt_id()%> /
						                    상태: <%=orderReceipt.getOrder_status()%> /
						                    주문일자: <%=orderReceipt.getOrderdate().toLocalDate()%>
						                </td>
						            </tr>

            
							            <% for(OrderDetail detail : orderReceipt.getOrderList()) { %>
							            <tr>
							                <!-- 상품정보 -->
							                <td>
							                    <div style="display: flex; gap: 100px;">
							                        <img src="/data/p_<%=detail.getSnapShot().getSnapshot_id()%>/<%=detail.getSnapShot().getFilename()%>" style="width: 100px; height: 100px; object-fit: cover;">
							                        <div>
							                            <div style="margin-bottom: 8px;"><strong><%=detail.getSnapShot().getProduct_name()%></strong></div>
							                            <div style="margin-bottom: 8px;"><%=detail.getSnapShot().getSize()%> / <%=detail.getSnapShot().getColor()%></div>
							                            <div style="margin-bottom: 8px;"><%=detail.getSnapShot().getPrice()%>원 / <%=detail.getSnapShot().getOrder_quantity()%>개</div>
							                           
							                            <div> 
														
														</div>
							                        </div>
							                    </div>
							                </td>
							                
							                <!-- 진행상태 (각 detail마다 같은 orderReceipt status) -->
							                <td><%=orderReceipt.getOrder_status()%></td>
							
							                <!--리뷰 버튼 -->
											<td style="margin-right:20px;">
										    <% if (writtenReview != null && writtenReview.contains(detail.getOrder_detail_id())) {%>
										    	이미 작성된 리뷰 입니다.
										    <%} else {%>
										        <form method="post" action="/shop/order/cancle" style="margin: 0;">
										            <input type="hidden" name="user.user_id" value="<%=user.getUser_id()%>">
										            <input type="hidden" name="order_receipt_id" value="<%=orderReceipt.getOrder_receipt_id()%>">
										            <input type="hidden" name="order_detail_id" value="<%=detail.getOrder_detail_id()%>">
										            <a href="/shop/review/registform?order_detail_id=<%=detail.getOrder_detail_id()%>">
										                <button type="button" class="btn btn-link">리뷰작성</button>
										            </a>
										        </form>
										    <%}%>
										</td>

							            </tr>
							            <% } %>
							            <!-- 주문 단위 블럭 끝 -->
							        <% } %>
							    </tbody>
							</table>
							<!-- 페이징 처리 -->
									<div class="card-footer d-flex justify-content-center">
										<ul class="pagination pagination-sm m-0">
										<!-- 이전 페이지 버튼 -->
											<li
												class="page-item <%=(firstPage <= 1 ? "disabled" : "")%>">
												<a class="page-link"
												href="<%=(firstPage > 1) ? ("/shop/order/ordercompleted?currentPage=" + (firstPage - 1)) : "#"%>">&laquo;</a>
											</li>
											<!-- 페이지 번호 목록 -->
											<%
											for (int i = firstPage; i <= lastPage && i <= totalPage; i++) {
											%>
											<li
												class="page-item <%=(i == currentPage ? "active" : "")%>">
												<a class="page-link"
												href="/shop/order/ordercompleted?currentPage=<%=i%>"><%=i%></a>
											</li>
											<%
											}
											%>
	
											<!-- 다음 페이지 버튼 -->
											<li
												class="page-item <%=(lastPage >= totalPage ? "disabled" : "")%>">
												<a class="page-link"
												href="<%=(lastPage < totalPage) ? ("/shop/order/ordercompleted?currentPage=" + (lastPage + 1)) : "#"%>">&raquo;</a>
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