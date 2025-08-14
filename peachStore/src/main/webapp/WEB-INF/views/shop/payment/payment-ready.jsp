<%@page import="peachstore.domain.SnapShot"%>
<%@page import="peachstore.domain.CartItem"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
List<ProductTopcategory> topList = (List) request.getAttribute("topList");
List<SnapShot> snapshotList = (List) request.getAttribute("snapshotList");
User userGrade = (User) request.getAttribute("userGrade");

User user = (User) request.getAttribute("user");
int amount = 0;

// 결제에 필요한 정보들
String orderId = (String) request.getAttribute("orderId");
String orderName = "Peach Store";
String customerName = user.getUser_name();
Integer orderReceiptId = (Integer) request.getAttribute("orderReceiptId");

String successUrl = (String) request.getAttribute("successUrl");
String failUrl = (String) request.getAttribute("failUrl");
/*    String cartItemPk; */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="Ashion Template">
<meta name="keywords" content="Ashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>장바구니 - Peach Store</title>
<%@ include file="../inc/head_link.jsp"%>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont,
		'Segoe UI', Roboto, sans-serif;
	background-color: #ffffff;
	color: #1d1d1f;
	line-height: 1.4;
}

.container {
	width: 60%;
}

/* Header */
.page-header {
	text-align: center;
	margin-bottom: 30px;
	padding-top: 20px;
}

.page-title {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 8px;
	color: #1d1d1f;
}

.order-date {
	font-size: 14px;
	color: #86868b;
	margin-bottom: 4px;
}

.order-number {
	font-size: 12px;
	color: #06c;
}

/* Product Item */
.product-section {
	margin-bottom: 40px;
}

.product-item {
	display: flex;
	align-items: flex-start;
	margin-bottom: 20px;
	padding-bottom: 20px;
	border-bottom: 1px solid #f5f5f7;
}

.product-item:last-child {
	border-bottom: none;
}

.product-image {
	width: 80px;
	height: 80px;
	border-radius: 8px;
	object-fit: cover;
	margin-right: 16px;
	background: #f5f5f7;
}

.product-details {
	flex: 1;
}

.product-name {
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 8px;
	color: #1d1d1f;
	line-height: 1.3;
}

.product-options {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-bottom: 8px;
}

.product-options span {
	background: #f5f5f7;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 12px;
	color: #6e6e73;
}

.product-quantity {
	font-size: 14px;
	color: #86868b;
}

.product-price {
	font-size: 16px;
	font-weight: 600;
	color: #1d1d1f;
	text-align: right;
	margin-left: 16px;
}

/* Info Sections */
.info-section {
	margin-bottom: 30px;
	border-bottom: 1px solid #f5f5f7;
	padding-bottom: 20px;
}

.info-section:last-of-type {
	border-bottom: none;
}

.section-title {
	font-size: 16px;
	font-weight: 600;
	margin-bottom: 12px;
	color: #1d1d1f;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 8px;
	font-size: 14px;
}

.info-label {
	color: #86868b;
}

.info-value {
	color: #1d1d1f;
	margin-left: 0; /* 불필요 */
	text-align: left;
}

/* Address Section */
.address-section {
	margin-bottom: 30px;
}

.address-input-group {
	margin-bottom: 12px;
}

.address-input-group label {
	display: block;
	font-size: 14px;
	color: #1d1d1f;
	margin-bottom: 6px;
	font-weight: 500;
}

.address-input-group input {
	width: 100%;
	padding: 12px 16px;
	border: 1px solid #d2d2d7;
	border-radius: 8px;
	font-size: 16px;
	background: #ffffff;
	transition: border-color 0.3s ease;
}

.address-input-group input:focus {
	outline: none;
	border-color: #06c;
}

.address-input-group input:read-only {
	background: #f5f5f7;
	color: #86868b;
}

.address-buttons {
	display: flex;
	gap: 8px;
	margin-top: 8px;
}

.address-btn {
	flex: 1;
	padding: 10px 16px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
	border: 1px solid #d2d2d7;
	background: #ffffff;
	color: #1d1d1f;
}

.address-btn.primary {
	background: #06c;
	color: white;
	border-color: #06c;
}

.address-btn:hover {
	opacity: 0.8;
}

/* Agreement */
.agreement-section {
	margin-bottom: 30px;
}

.agreement-checkbox {
	display: flex;
	align-items: flex-start;
	gap: 8px;
	font-size: 12px;
	color: #86868b;
	line-height: 1.4;
}

.agreement-checkbox input[type="checkbox"] {
	margin-top: 2px;
}

.agreement-checkbox a {
	color: #06c;
	text-decoration: none;
}

/* Total */
.total-section {
	margin-bottom: 30px;
	padding: 20px 0;
	border-top: 1px solid #d2d2d7;
	border-bottom: 1px solid #d2d2d7;
}

.total-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.total-label {
	font-size: 18px;
	font-weight: 600;
	color: #1d1d1f;
}

.total-price {
	font-size: 20px;
	font-weight: 700;
	color: #1d1d1f;
}

/* Payment Button */
.payment-section {
	margin-bottom: 20px;
}

.pay-btn {
	width: 100%;
	background: #06c;
	color: white;
	border: none;
	border-radius: 12px;
	padding: 16px;
	font-size: 17px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
}

.pay-btn:hover {
	background: #0077ed;
}

.pay-btn:active {
	transform: scale(0.98);
}

/* Continue Shopping */
.continue-shopping {
	text-align: center;
	margin-bottom: 20px;
}

.continue-shopping a {
	color: #06c;
	text-decoration: none;
	font-size: 16px;
	font-weight: 500;
}

.continue-shopping a:hover {
	opacity: 0.7;
}

/* Discount Info */
.discount-info {
	background: #e8f4fd;
	border-radius: 8px;
	padding: 12px;
	margin-bottom: 20px;
	font-size: 14px;
	color: #06c;
	text-align: center;
}

/* Hide original table structure */
.shop__cart__table table, .shop__cart__table thead, .shop__cart__table tbody
	{
	display: none;
}

.shop-cart-section {
	background-color: #ffffff;
	min-height: 100vh;
	padding: 0;
}

/* Responsive */
@media ( max-width : 768px) {
	.container {
		padding: 16px;
		max-width: 100%;
	}
	.product-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.product-image {
		width: 100%;
		height: 200px;
		margin-right: 0;
		margin-bottom: 12px;
	}
	.product-price {
		margin-left: 0;
		margin-top: 8px;
		text-align: left;
	}
	.address-buttons {
		flex-direction: column;
	}
}
</style>
</head>
<body>
	<!-- Offcanvas Menu Begin -->
	<%@ include file="../inc/offcanvas.jsp"%>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<%@ include file="../inc/header.jsp"%>
	<!-- Header Section End -->

	<!-- Shop Cart Section Begin -->
	<section class="shop-cart-section">
		<div class="container">
			<!-- Header -->
			<div class="page-header">
				<h1 class="page-title" style="font-weight: bold;">주문하시겠습니까?</h1>
				<h1 class="page-title" style="font-weight: bold;">입력하신 사항이 모두
					정확한지 확인해주십시오.</h1>
			</div>

			<!-- Discount Info -->
			<div class="discount-info">
				<%=userGrade.getUser_grade().getUserGradeName()%>회원에게
				<%=userGrade.getUser_grade().getDiscountRate()%>%의 할인율이 적용됩니다.
			</div>

			<!-- Products -->
			<div class="product-section">
				<%
				int totalPrice = 0;
				int finalPrice = 0;
				for (int i = 0; i < snapshotList.size(); i++) {
					SnapShot snapshot = snapshotList.get(i);
					int price = snapshot.getPrice();
					String capacity = null, color = null, size = null, engraving = null;
					int engravingPrice = 0;

					if (snapshot.getCapacity() != null)
						capacity = snapshot.getCapacity();
					if (snapshot.getColor() != null)
						color = snapshot.getColor();
					if (snapshot.getSize() != null)
						size = snapshot.getSize();
					if (snapshot.getEngraving() != null) {
						engraving = snapshot.getEngraving();
					}

					finalPrice = price + engravingPrice;
					totalPrice += finalPrice;
				%>
				<div class="product-item">
					<%
					String imagePath = "/static/shop/img/no-image.png";
					if (snapshot.getFilename() != null && !snapshot.getFilename().isEmpty()) {
						imagePath = snapshot.getFilename();
					}
					%>
					<img src="<%=imagePath%>" alt="상품 이미지" class="product-image">

					<div class="product-details">
						<div class="product-name"><%=snapshot.getProduct_name()%></div>
						<div class="product-options">
							<%
							if (capacity != null) {
							%><span><%=capacity%></span>
							<%
							}
							%>
							<%
							if (color != null) {
							%><span><%=color%></span>
							<%
							}
							%>
							<%
							if (size != null) {
							%><span><%=size%></span>
							<%
							}
							%>
							<%
							if (engraving != null) {
							%><span><%=engraving%></span>
							<%
							}
							%>
						</div>
						<div class="product-quantity">1</div>
					</div>

					<div class="product-price">
						₩<%=String.format("%,d", finalPrice)%></div>
				</div>
				<%
				}
				%>
			</div>

			<!-- Shipping Info -->
			<div class="info-section">
				<div class="section-title">배송 상세 정보</div>
				<div class="info-item">
					<span class="info-label">배송비:</span> <span class="info-value">무료</span>
				</div>
				<div class="info-item">
					<span class="info-label">배송일:</span> <span class="info-value">빠른
						배송</span>
				</div>
				<div class="info-item">
					<span class="info-label">배송 방법:</span> <span class="info-value">택배</span>
				</div>
			</div>

			<!-- Payment Info -->
			<div class="info-section">
				<div class="section-title">결제 상세 정보</div>
				<div class="info-item">
					<span class="info-label">결제 방법:</span> <span class="info-value">간편결제</span>
				</div>
				<div class="info-item">
					<span class="info-label">청구서 발송:</span> <span class="info-value"><%=user.getEmail()%></span>
				</div>
			</div>

			<!-- Address Section -->
			<div class="address-section">
				<span class="total-label">배송 상세 정보</span>

				<div class="address-input-group">
					<label for="userPostCode">우편번호</label> <input type="text"
						id="userPostCode" name="userPostCode" readonly>
					<div class="address-buttons">
						<button type="button" class="address-btn primary"
							id="search-address-btn">주소 검색</button>
						<button type="button" class="address-btn" id="cancel-address-btn">취소</button>
					</div>
				</div>

				<div class="address-input-group">
					<label for="userAddress">주소</label> <input type="text"
						id="userAddress" name="userAddress" readonly>
				</div>

				<div class="address-input-group">
					<label for="userDtlAddress">상세주소</label> <input type="text"
						id="userDtlAddress" name="userDtlAddress" maxlength="100" readonly>
				</div>
			</div>



			<!-- Agreement -->
			<div class="agreement-section">
				<span class="total-label">이용 약관</span>
				<div class="agreement-checkbox">
					<input type="checkbox" id="agreement" checked> <label
						for="agreement"> Peach의 <a href="#">개인정보 처리방침</a>에 따라 정보를
						수집하고, 저장하며, 처리하는 것에 동의합니다.
					</label>
				</div>
			</div>

			<!-- Total -->
			<div class="total-section">
				<div class="total-row">
					<span class="total-label">총계</span> <span class="total-price"
						id="total-price">₩<%=String.format("%,d", totalPrice)%></span>
				</div>
			</div>

			<!-- Payment Button -->
			<div class="payment-section">
				<button class="pay-btn" id="pay-btn">
					₩<%=String.format("%,d", totalPrice)%>로 주문 완료하기
				</button>
			</div>

			<!-- Continue Shopping -->
			<div class="continue-shopping">
				<a href="/shop/main">쇼핑 계속하기</a>
			</div>

			<!-- Hidden original table -->
			<div class="shop__cart__table" style="display: none;">
				<table>
					<thead>
						<tr>
							<th>제품</th>
							<th></th>
							<th></th>
							<th>가격</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<%
						for (int i = 0; i < snapshotList.size(); i++) {
							SnapShot snapshot = snapshotList.get(i);
							int price = snapshot.getPrice();
							int engravingPrice = 0;
							finalPrice = price + engravingPrice;
						%>
						<tr>
							<td class="cart__product__item">
								<%
								String imagePath = "/static/shop/img/no-image.png";
								if (snapshot.getFilename() != null && !snapshot.getFilename().isEmpty()) {
									imagePath = "/data/product_" + snapshot.getProduct_id() + "/" + snapshot.getFilename();
								}
								%> <img src="<%=imagePath%>" alt="장바구니 상품<%=i%>">
								<div class="cart__product__item__title">
									<h6><%=snapshot.getProduct_name()%></h6>
								</div>
							</td>
							<td class="cart__blank"></td>
							<td class="cart__blank"></td>
							<td class="cart__price">₩<%=String.format("%,d", finalPrice)%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!-- Shop Cart Section End -->

	<!-- Instagram Begin -->
	<%@ include file="../inc/instagram.jsp"%>
	<!-- Instagram End -->

	<!-- Footer Section Begin -->
	<%@ include file="../inc/footer.jsp"%>
	<!-- Footer Section End -->

	<!-- Search Begin -->
	<%@ include file="../inc/search.jsp"%>
	<!-- Search End -->

	<!-- Js Plugins -->
	<%@ include file="../inc/footer_link.jsp"%>
	<script src="https://js.tosspayments.com/v1/payment"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	
    /** 다음 우편주소 처리 */
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("userAddress").value = data.address;
                document.getElementById("userPostCode").value = data.zonecode;
                var inputDtlAddr = document.getElementById("userDtlAddress");
                inputDtlAddr.readOnly = false;
            }
        }).open();
    }
    
    /** 취소버튼 클릭 시 주소, 상세주소 초기화 */
    function cancelAddress() {
        var inputPostCode = document.getElementById("userPostCode");
        inputPostCode.value = "";
        var inputAddr = document.getElementById("userAddress");
        inputAddr.value = "";
        var inputDtlAddr = document.getElementById("userDtlAddress");
        inputDtlAddr.value = "";
        inputDtlAddr.readOnly = true;
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("search-address-btn").addEventListener("click", searchAddress);
        document.getElementById("cancel-address-btn").addEventListener("click", cancelAddress);
        
	const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");
	
	document.getElementById("pay-btn").addEventListener("click", () => {
		const postCode = document.getElementById("userPostCode").value;
		const address = document.getElementById("userAddress").value;
		const detailAddress = document.getElementById("userDtlAddress").value;
		
		const paymentData = {
				// 주소 정보 묶음
			    addressData: {
			        postCode: postCode,
			        address: address,
			        detailAddress: detailAddress
			    },
			    amount: <%=totalPrice%>,
			    orderId: '<%=orderId%>'
			};

		// 1. 주소 세션 저장 요청
		$.ajax({
			url: "/shop/payment/save-address",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(paymentData),
			success: function () {
				// 2. 주소 저장 후 결제 진행
				tossPayments.requestPayment("간편결제", {
					amount: paymentData.amount,
					orderId: paymentData.orderId,
					orderName: '<%=orderName%>',
					customerName: '<%=customerName%>',
					successUrl: '<%=successUrl%>',
					failUrl: '<%=failUrl%>'
				});
			},
			error: function () {
				alert("주소 저장 중 오류가 발생했습니다.");
			}
		});
	});
		
      });

	
	 


	$(() => {
		$(".shop__cart__table").on("click", ".cart__delete", function () {
			const cartItemId = $(this).data("id");
			if (confirm("선택 항목을 장바구니에서 삭제하시겠습니까?")) {
				$.ajax({
					url: "/shop/cart/delete",
					type: "POST",
					data: { cartItemId: cartItemId },
					success: function(response) {
						location.reload();
					},
					error: function(err) {
						alert("삭제 중 오류가 발생했습니다.");
					}
				});
			}
		});
	});
	</script>
</body>
</html>