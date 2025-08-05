<%@page import="peachstore.domain.User"%>
<%@page import="peachstore.domain.CustomOption"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="peachstore.domain.CartItem"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
List<ProductTopcategory> topList = (List) request.getAttribute("topList");
List<CartItem> cartItemList = (List) request.getAttribute("cartItemList");
User user = (User) request.getAttribute("user");
int amount = 0;

// 결제에 필요한 정보들
  String orderId = (String)  request.getAttribute("orderId");
  String orderName =  user.getUser_name();
  String customerName = "Peach Store";
  Integer orderReceiptId = (Integer) request.getAttribute("orderReceiptId");

  String successUrl = (String)   request.getAttribute("successUrl");
  String failUrl = (String)   request.getAttribute("failUrl");
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
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<style>
.confirmation h2 {
	font-size: 22px;
	margin-bottom: 4px;
}

.ship-date {
	font-weight: bold;
	color: #0071e3;
}

.product-info {
	display: flex;
	align-items: center;
	gap: 16px;
	margin: 24px 0;
}

.product-info img {
	width: 80px;
	height: 80px;
}

.details {
	flex: 1;
}

.product-name {
	font-weight: bold;
	margin-bottom: 4px;
}

.product-price {
	font-weight: bold;
}

hr {
	border: none;
	border-top: 1px solid #ccc;
	margin: 24px 0;
}

.info-section {
	margin-bottom: 24px;
}

.info-grid {
	display: flex;
	justify-content: space-between;
}

.info-grid div {
	width: 48%;
}

.terms {
	background-color: #f9f9f9;
	padding: 16px;
	font-size: 14px;
	margin-bottom: 24px;
}

.terms a {
	color: #0071e3;
	text-decoration: none;
}

.summary {
	border-top: 1px solid #ccc;
	padding-top: 16px;
}

.price-line, .price-total {
	display: flex;
	justify-content: space-between;
	margin: 8px 0;
}

.price-total {
	font-size: 18px;
	font-weight: bold;
}

button#pay-button {
	margin-top: 24px;
	width: 100%;
	padding: 12px;
	background-color: #0071e3;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
}

button#pay-button:hover {
	background-color: #005bb5;
}

.pay-btn-wrapper {
	display: flex;
	justify-content: center;
	margin: auto;
	background-color: #fff;
	border-radius: 18px;
	padding: 8px;
	width: 290px;
}

.pay-btn-content {
	width: 290px;
	margin-top: 31px;
}

.pay-btn {
	width: 100%;
	border: none;
	border-radius: 8px;
	background-color: #0071E3;
	padding: 8px 15px;
	font-size: 14px;
	font-weight: 600;
	letter-spacing: 1px;
	color: white;
}

h6 {
	font-size: 20px;
}

.rating {
	font-size: 12px;
}
</style>
<body>
	<header>
		<h1>결제</h1>
	</header>

	<main class="container">
		<section class="confirmation">
			<h2>주문하시겠습니까?</h2>
			<h2>입력하신 사항이 모두 정확한지 확인해주십시오.</h2>
			<p>
				<strong>출고</strong> <span class="ship-date">2025/08/07</span>
			</p>
		</section>

		<section class="product-info">
			<% for (int i = 0; i < cartItemList.size(); i++) {
       CartItem item = cartItemList.get(i);
       Product product = item.getProduct();
       CustomOption option = item.getCustom_option();
       int totalPrice = product.getPrice();

       if (option != null && option.getProduct_engraving() != null) {
         totalPrice += option.getProduct_engraving().getEngraving_price();
       }
  %>
			<div class="product-card">
				<img src="/static/shop/img/shop-cart/cp-1.jpg" alt="주문 상품 이미지">

				<div class="details">
					<p class="product-name"><%= product.getProductName() %></p>

					<div class="option-tags">
						<% if (option != null) { %>
						<% if (option.getProduct_capacity() != null) { %>
						<span class="option"><%= option.getProduct_capacity().getCapacity().getCapacity_name() %></span>
						<% } %>
						<% if (option.getProduct_color() != null) { %>
						<span class="option"><%= option.getProduct_color().getColor().getColor_name() %></span>
						<% } %>
						<% if (option.getProduct_size() != null) { %>
						<span class="option"><%= option.getProduct_size().getSize().getSize_name() %></span>
						<% } %>
						<% if (option.getProduct_engraving() != null) { %>
						<span class="option">각인: <%= option.getProduct_engraving().getEngraving_text() %></span>
						<% } %>
						<% } %>
					</div>

					<p class="product-price">
						₩<%= String.format("%,d", totalPrice) %></p>
				</div>
			</div>

			<% 
				amount += totalPrice;
			} %>
		</section>



		<hr />

		<section class="info-section">
			<h3>배송 상세 정보</h3>
			변경>
			<div class="info-grid">
				<div>
					<p>
						<strong>받는사람:</strong>
						<%=user.getUser_name() %>
					</p>
					<p>
						<strong>주소:</strong> 경기도 어딘시<br>신사면 신장리 신장로1-1 ABC빌딩<br>대한민국
					</p>
				</div>
				<div>
					<p>
						<strong>연락처:</strong><%=user.getTel() %>
					</p>
					<p>
						<%=user.getEmail() %></p>
				</div>
			</div>
		</section>

		<section class="info-section">
			<h3>결제 상세 정보</h3>
			변경>
			<div class="info-grid">
				<div>
					<p>
						<strong>결제 수단:</strong> 신용 카드
					</p>
				</div>
				<div>
					<p>
						<strong>청구 주소:</strong> 동일
					</p>
				</div>
			</div>
		</section>

		<section class="terms">
			<p>
				Apple의 <a href="#">개인정보 처리방침</a>에 따라 정보를 수집하고, 저장하며, 처리하는 것에 동의하셔야
				합니다.
			</p>
		</section>

		<section class="summary">
			<div class="price-line">
				<span>소계</span><span><%= amount %></span>
			</div>
			<div class="price-line">
				<span>배송</span><span>무료</span>
			</div>
			<div class="price-total">
				<span>총계</span><span><strong><%= amount %></strong></span>
			</div>
			<button id="pay-button">KG 이니시스에서 계속 진행</button>
		</section>
	</main>
  <script src="https://js.tosspayments.com/v1/payment"></script>
  <script>
	 const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");
	    document.getElementById("pay-button").addEventListener("click", () => {
	      tossPayments.requestPayment("카카오페이", {
	        amount: <%=amount%>,
	        orderId: '<%=orderId%>',
	        orderName: '<%=orderName%>',
	        customerName: '<%=customerName%>',
	        successUrl: '<%=successUrl%>',
	        failUrl: '<%=failUrl%>'
	      });
	    });
	</script>
</body>
</html>