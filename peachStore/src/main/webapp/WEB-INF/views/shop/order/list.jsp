<%@page import="peachstore.domain.OrderDetail"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user"); 
	
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<OrderDetail> orderDetail = (List)request.getAttribute("orderDetail");
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
    <colgroup>
        <col style="width: 50%;">
        <col style="width: 30%;">
        <col style="width: 20%;">
    </colgroup>
    <thead>
        <br><br>
        <tr style="border-bottom: 1px solid black;">
            <th style="font-weight: bold; font-size: 20px;">상품정보</th>
            <th style="font-weight: bold; font-size: 20px;">진행상태</th>
            <th style="font-weight: bold; font-size: 20px;">주문취소</th>
        </tr>
    </thead>
            <%for(OrderDetail detail : orderDetail){ %>
    <tbody>
        <tr>
            <!-- 상품정보 -->
            <td>
                <div style="display: flex; gap: 120px;">
                    <img src="data/p_<%=detail.getSnapShot().getSnapshot_id()%>/<%=detail.getSnapShot().getFilename() %>" style="width: 100px; height: 100px; object-fit: cover;">
                    <div>
                        <div  style="margin-bottom: 12px;"> <strong><%=detail.getSnapShot().getProduct_name() %></strong></div>
                        <div>
                             <%=detail.getSnapShot().getSize() %> &nbsp;&nbsp;
                             <%=detail.getSnapShot().getColor() %>
                        </div>
                        <div style="margin-bottom: 12px;">
                             <%=detail.getSnapShot().getPrice() %>원 &nbsp;&nbsp;
                            <%=detail.getOrder_quantity() %>개
                        </div style="margin-bottom: 12px;">
                        <div><strong>각인:</strong> <%=detail.getSnapShot().getEngraving() %></div>
                    </div>
                </div>
            </td>
           

            <!-- 진행상태 -->
            <td>
                <div style="margin-bottom: 12px;"> <%=detail.getOrderReceipt().getOrder_status() %></div>
                <di style="margin-bottom: 12px;"> 2025-07-28</div>
            </td>
				<form method="post" id="cancle" action="/shop/order/cancle">
				 <input type="hidden" name="user.user_id" value="<%= user.getUser_id()%>">
				 <%for(OrderDetail order : orderDetail) {%>
				 <input type="hidden" name="order_receipt_id" value="<%=order.getOrderReceipt().getOrder_receipt_id()%>">
				 <%} %>
				 </form>

            <!-- 주문취소 -->
            <%if(detail.getOrderReceipt().getOrder_status().equals("발송완료")) {%>
            <td>
                <button onclick="if(confirm('주문취소 하시겠습니까?')) document.getElementById('cancle').submit();" class="btn btn-danger">
                    주문취소
                </button>
            </td>
            <%} %>
        </tr>
    </tbody>
     <%} %>
</table>

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