<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.OrderReceipt"%>
<%@page import="peachstore.domain.OrderDetail"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user"); 
	
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<OrderReceipt> cancleList = (List)request.getAttribute("cancleList");
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
  
			<section class="shop-cart spad">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="shop__cart__table">
								<table style="table-layout: fixed; width: 100%;">
								
								<div class="card-header"
							     style="display: flex; justify-content: space-between; border-bottom: 2px solid black;">
							    <h3 class="card-title" style="font-weight: bold;">취소 내역</h3>
							</div>

								<table style="width: 100%; border-collapse: collapse;">
								    
								    <thead>
								        <tr style="border-bottom: 1px solid black;">
								            <th style="font-weight: bold; font-size: 20px;">상품정보</th>
								        </tr>
								    </thead>
								    <tbody>
								        <% for(OrderReceipt orderReceipt : cancleList) { %>
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
														<img
															src="<%=detail.getSnapShot().getFilename()%>"
															style="width: 100px; height: 100px; object-fit: cover;">
														<div>
															<div style="margin-bottom: 8px;">
																<h4 style="font-weight:bold; font-size:20px;"><%=detail.getSnapShot().getProduct_name()%></h4>
															</div>
															<div style="margin-bottom: 8px;">사이즈/색상 : <%=detail.getSnapShot().getSize()%>
																/
																<%=detail.getSnapShot().getColor()%></div>
															<div style="margin-bottom: 8px;">가격/수량 : <%=detail.getSnapShot().getPrice()%>원
																/
																<%=detail.getSnapShot().getOrder_quantity() %>개
															</div>
															<div style="margin-bottom: 8px;">우편번호 : <%=orderReceipt.getPostcode()%>
															</div>
															<div style="margin-bottom: 8px;">주소 : <%=orderReceipt.getAddress()%> <%=orderReceipt.getDetailAddress()%>
															</div>
															
															
															
														</div>
													</div>
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
												href="<%=(firstPage > 1) ? ("/shop/order/cancle/list?currentPage=" + (firstPage - 1)) : "#"%>">&laquo;</a>
											</li>
											<!-- 페이지 번호 목록 -->
											<%
											for (int i = firstPage; i <= lastPage && i <= totalPage; i++) {
											%>
											<li
												class="page-item <%=(i == currentPage ? "active" : "")%>">
												<a class="page-link"
												href="/shop/order/cancle/list?currentPage=<%=i%>"><%=i%></a>
											</li>
											<%
											}
											%>
	
											<!-- 다음 페이지 버튼 -->
											<li
												class="page-item <%=(lastPage >= totalPage ? "disabled" : "")%>">
												<a class="page-link"
												href="<%=(lastPage < totalPage) ? ("/shop/order/cancle/list?currentPage=" + (lastPage + 1)) : "#"%>">&raquo;</a>
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
	
	
	<script type="text/javascript">
	
		function cancelOrder() {
			
		}
	</script>
	

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