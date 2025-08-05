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
    <h3 class="card-title" style="font-weight: bold;">주문 내역</h3>
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
                        <img src="/data/p_<%=detail.getSnapShot().getSnapshot_id()%>/<%=detail.getSnapShot().getFilename()%>" style="width: 100px; height: 100px; object-fit: cover;">
                        <div>
                            <div style="margin-bottom: 8px;"><strong><%=detail.getSnapShot().getProduct_name()%></strong></div>
                            <div style="margin-bottom: 8px;"><%=detail.getSnapShot().getSize()%> / <%=detail.getSnapShot().getColor()%></div>
                            <div style="margin-bottom: 8px;"><%=detail.getSnapShot().getPrice()%>원 / <%=detail.getOrder_quantity()%>개</div>
                            <div><strong>각인:</strong> <%=detail.getSnapShot().getEngraving()%></div>
                        </div>
                    </div>
                </td>
                
                
            </tr>
            <% } %>
            <!-- 주문 단위 블럭 끝 -->
        <% } %>
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