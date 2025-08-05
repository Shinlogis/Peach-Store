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
String orderName = user.getUser_name();
String customerName = "Peach Store";
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
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
		Helvetica, Arial, sans-serif;
	background-color: #f5f5f7;
	color: #1d1d1f;
	line-height: 1.47059;
}

.container {
	max-width: 980px;
	margin: 0 auto;
	padding: 0 22px;
}

/* Main Content */
.main-content {
	padding: 60px 0;
}

.page-title {
	font-size: 48px;
	font-weight: 600;
	text-align: center;
	margin-bottom: 12px;
	letter-spacing: -0.003em;
}

.subtitle {
	font-size: 21px;
	color: #86868b;
	text-align: center;
	margin-bottom: 40px;
	font-weight: 400;
}

/* Cart Summary */
.cart-summary {
	background: white;
	border-radius: 18px;
	padding: 24px;
	margin-bottom: 40px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
}

.total-price {
	font-size: 32px;
	font-weight: 600;
	text-align: center;
	margin-bottom: 12px;
}

.discount-info {
	text-align: center;
	color: #06c;
	margin-bottom: 8px;
}

.shipping-info {
	text-align: center;
	color: #86868b;
	font-size: 14px;
}

/* Cart Items */
.cart-items {
	background: white;
	border-radius: 18px;
	margin-bottom: 40px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
}

.cart-item {
	display: flex;
	padding: 24px;
	border-bottom: 1px solid #f5f5f7;
	align-items: center;
	transition: background-color 0.3s ease;
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item:hover {
	background-color: #fafafa;
}

.cart__product__item {
	display: flex;
	align-items: center;
	flex: 1;
}

.cart__product__item img {
	width: 120px;
	height: 120px;
	border-radius: 12px;
	object-fit: cover;
	margin-right: 24px;
	background: #f5f5f7;
}

.cart__product__item__title {
	flex: 1;
}

.cart__product__item__title h6 {
	font-size: 19px;
	font-weight: 600;
	margin-bottom: 8px;
	color: #1d1d1f;
}

.rating {
	display: flex;
	gap: 16px;
	margin-top: 12px;
}

.rating span {
	background: #f5f5f7;
	padding: 4px 12px;
	border-radius: 16px;
	font-size: 12px;
	color: #6e6e73;
}

.cart__blank {
	display: none;
}

.cart__price {
	font-size: 19px;
	font-weight: 600;
	color: #1d1d1f;
	margin-right: 24px;
}

.cart__delete {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	background: #f5f5f7;
	color: #86868b;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.3s ease;
	font-size: 16px;
	border: none;
}

.cart__delete:hover {
	background: #ff3b30;
	color: white;
	transform: scale(1.1);
	font-weight: bold;
}

/* Shipping Info */
.info-section {
	background: white;
	border-radius: 18px;
	padding: 24px;
	margin-bottom: 40px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
}

.info-section h3 {
	font-size: 19px;
	font-weight: 600;
	margin-bottom: 20px;
	color: #1d1d1f;
}

.info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 24px;
}

.info-grid div {
	font-size: 14px;
	line-height: 1.6;
}

.info-grid p {
	margin-bottom: 12px;
}

.info-grid strong {
	font-weight: 600;
	color: #1d1d1f;
	display: block;
	margin-bottom: 4px;
}

/* Terms */
.terms {
	text-align: center;
	font-size: 12px;
	color: #86868b;
	margin-bottom: 40px;
	background: white;
	border-radius: 12px;
	padding: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.terms a {
	color: #06c;
	text-decoration: none;
}

/* Payment Button */
.pay-btn-wrapper {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
}

.pay-btn-content {
	width: 100%;
	max-width: 290px;
}

.pay-btn {
	width: 100%;
	background: #0071e3;
	color: white;
	border: none;
	border-radius: 12px;
	padding: 17px 32px;
	font-size: 17px;
	font-weight: 400;
	cursor: pointer;
	transition: all 0.3s ease;
	letter-spacing: 0.5px;
}

.pay-btn:hover {
	background: #0077ed;
	transform: scale(1.02);
}

.pay-btn:active {
	transform: scale(0.98);
}

/* Continue Shopping */
.cart__btn {
	text-align: center;
	margin-bottom: 40px;
}

.cart__btn a {
	color: #06c;
	text-decoration: none;
	font-size: 17px;
	transition: opacity 0.3s ease;
}

.cart__btn a:hover {
	opacity: 0.7;
}

/* Hide original table structure */
.shop__cart__table table, .shop__cart__table thead, .shop__cart__table tbody
	{
	display: block;
}

.shop__cart__table thead {
	display: none;
}

.shop__cart__table tbody tr {
	display: flex;
	align-items: center;
	padding: 24px;
	border-bottom: 1px solid #f5f5f7;
	transition: background-color 0.3s ease;
	background: white;
	margin-bottom: 0;
}

.shop__cart__table tbody tr:hover {
	background-color: #fafafa;
}

.shop__cart__table tbody tr:last-child {
	border-bottom: none;
}

.shop__cart__table tbody td {
	display: contents;
}

.shop-cart-section {
	background-color: #f5f5f7;
	min-height: 100vh;
	padding: 40px 0;
}

/* Responsive */
@media ( max-width : 768px) {
	.container {
		padding: 0 16px;
	}
	.main-content {
		padding: 40px 0;
	}
	.page-title {
		font-size: 32px;
	}
	.subtitle {
		font-size: 19px;
	}
	.cart-item, .shop__cart__table tbody tr {
		flex-direction: column;
		align-items: flex-start;
		padding: 20px;
		position: relative;
	}
	.cart__product__item {
		width: 100%;
		flex-direction: column;
		align-items: flex-start;
	}
	.cart__product__item img {
		width: 100%;
		height: 200px;
		margin-right: 0;
		margin-bottom: 16px;
	}
	.info-grid {
		grid-template-columns: 1fr;
		gap: 16px;
	}
	.cart__price {
		margin-right: 0;
		margin-top: 12px;
		align-self: flex-start;
	}
	.cart__delete {
		position: absolute;
		top: 20px;
		right: 20px;
	}
	.rating {
		flex-wrap: wrap;
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
			<div class="main-content">
				<h1 class="page-title">장바구니</h1>
				<p class="subtitle">주문을 검토하고 결제를 진행하세요</p>

				<!-- Cart Summary -->
				<div class="cart-summary">
					<div class="title-h1 total-price" id="total-price">장바구니 총액:
						0원</div>
					<div class="discount-info">
						<%=userGrade.getUser_grade().getUserGradeName()%>회원에게
						<%=userGrade.getUser_grade().getDiscountRate()%>%의 할인율이 적용됩니다.
					</div>
					<div class="shipping-info">모든 주문에 무료 배송 서비스가 제공됩니다</div>
				</div>

				<!-- Cart Items -->
				<div class="cart-items">
					<div class="shop__cart__table">
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
								<!-- 전부 fk 설정이므로 참조해서 받아와야함.get().get() -->
								<%
								int totalPrice = 0;
								%>
								<%
								for (int i = 0; i < snapshotList.size(); i++) {
									SnapShot snapshot = snapshotList.get(i);
									int price = snapshot.getPrice();
									String capacity = null, color = null, size = null, engraving = null;
									int engravingPrice = 0;

										if (snapshot.getCapacity() != null)
									capacity = snapshot.getCapacity();
										if (snapshot.getColor()!= null)
									color = snapshot.getColor();
										if (snapshot.getSize() != null)
									size = snapshot.getSize();
										if (snapshot.getEngraving() != null) {
									engraving = snapshot.getEngraving();
										}

									int finalPrice = price + engravingPrice;
									totalPrice += finalPrice;
								%>
								<tr>
									<td class="cart__product__item">
										<%
										String imagePath = "/static/shop/img/no-image.png"; // 기본 이미지
										if (snapshot.getFilename() != null && !snapshot.getFilename().isEmpty()) {
											imagePath = "/data/product_" + snapshot.getProduct_id() + "/" + snapshot.getFilename();
										}
										%> <img src="<%=imagePath%>"
										alt="장바구니 상품<%=i%>">

										<div class="cart__product__item__title">
											<h6><%=snapshot.getProduct_name()%></h6>

											<div class="rating">
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
										</div>
									</td>

									<td class="cart__blank"></td>
									<td class="cart__blank"></td>

									<td class="cart__price">₩<%=String.format("%,d", finalPrice)%></td>

								</tr>
								<%
								}
								%>
								<!-- 동기방식 사용했기 때문에 위에서 total뿌려주는 건 JS로 -->
								<script>document.getElementById("total-price").innerText = "장바구니 총액: ₩<%=String.format("%,d", totalPrice)%>";</script>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Shipping Info -->
				<section class="info-section">
					<!-- 우편번호 -->
					<div class="row align-items-center">
						<label for="userPostCode" class="col-sm-1 col-form-label">
							<span class="required-none">&nbsp;</span> 우편번호
						</label>
						<div class="col-sm-6">
							<!-- 기존 4 → 6 혹은 더 크게 -->
							<input type="text" class="form-control" id="userPostCode"
								name="userPostCode" readonly>
						</div>
						<div class="col-sm-5">
							<!-- 버튼 영역도 넓게 -->
							<button type="button" class="btn btn-outline-primary" onclick="searchAddress();">
								입력
								<fmt:message key="code_search" />
							</button>
							<button type="button" class="btn btn-outline-danger" onclick="cancelAddress();">
								취소
								<fmt:message key="code_cancel" />
							</button>
						</div>
					</div>

					<!-- 주소 -->
					<div class="row align-items-center mt-2">
						<label for="userAddress" class="col-sm-1 col-form-label">
							<span class="required-none">&nbsp;</span> 주소
						</label>
						<div class="col-sm-11">
							<!-- label 1, input 11으로 전체 행 폭 사용 -->
							<input type="text" class="form-control" id="userAddress"
								name="userAddress" readonly>
						</div>
					</div>

					<!-- 상세주소 -->
					<div class="row align-items-center mt-2">
						<label for="userDtlAddress" class="col-sm-1 col-form-label">
							<span class="required-none">&nbsp;</span> 상세주소
						</label>
						<div class="col-sm-11">
							<!-- label 1, input 11으로 전체 행 폭 사용 -->
							<input type="text" class="form-control" id="userDtlAddress"
								name="userDtlAddress" maxlength="100" readonly>
						</div>
					</div>
				</section>

				<!-- Terms -->
				<section class="terms">
					<p>
						Peach의 <a href="#">개인정보 처리방침</a>에 따라 정보를 수집하고, 저장하며, 처리하는 것에 동의하셔야
						합니다.
					</p>
				</section>

				<!-- Payment Button -->
				<div class="row">
					<div class="col-lg-10 offset-lg-1">
						<div class="pay-btn-wrapper">
							<div class="pay-btn-content">
								<button class="pay-btn" id="pay-btn" value="">결제하기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Continue Shopping -->
				<div class="row">
					<div class="col-lg-3 offset-lg-8">
						<div class="cart__btn update__btn">
							<a href="/shop/main">쇼핑 계속하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shop 
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
    /** 카카오 주소 처리 */
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) { // 선택시 입력값 세팅
                document.getElementById("userAddress").value = data.address; // 주소 넣기
                document.getElementById("userPostCode").value = data.zonecode; // 우편번호 넣기
                var inputDtlAddr = document.getElementById("userDtlAddress"); // 주소란 읽기전용 설정
                inputDtlAddr.readOnly = false;
            }
        }).open();
    }

    /** 취소버튼 클릭 시 주소, 상세주소 초기화 */
    function cancelAddress() {
        var inputPostCode = document.getElementById("userPostCode");
        inputPostCode.value = ""; // 우편번호 초기화
        var inputAddr = document.getElementById("userAddress");
        inputAddr.value = ""; // 주소란 초기화
        var inputDtlAddr = document.getElementById("userDtlAddress");
        inputDtlAddr.value = ""; // 상세주소란 초기화
        inputDtlAddr.readOnly = true; // 상세주소란 읽기전용 해제
    }
	
	 const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");
	 
	 document.getElementById("pay-btn").addEventListener("click", () => {
		    const postCode = document.getElementById("userPostCode").value;
		    const address = document.getElementById("userAddress").value;
		    const detailAddress = document.getElementById("userDtlAddress").value;

		    // 1. 주소 세션 저장 요청
		    $.ajax({
		        url: "/shop/payment/save-address",
		        type: "POST",
		        data: {
		            postCode: postCode,
		            address: address,
		            detailAddress: detailAddress,
		            
		            
		        },
		        success: function () {
		            // 2. 주소 저장 후 결제 진행
		            tossPayments.requestPayment("간편결제", {
		                amount: <%=totalPrice%>,
		                orderId: '<%=orderId%>',
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
	
		$(() => {
			$(".shop__cart__table").on("click", ".cart__delete", function () {
				const cartItemId = $(this).data("id");
				if (confirm("선택 항목을 장바구니에서 삭제하시겠습니까?")) {
					$.ajax({
						url: "/shop/cart/delete",
						type: "POST",
						data: { cartItemId: cartItemId },
						success: function(response) {
							// 성공 시 페이지 새로고침 또는 해당 행 삭제
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