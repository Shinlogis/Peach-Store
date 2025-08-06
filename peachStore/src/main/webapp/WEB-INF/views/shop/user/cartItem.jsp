<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@ page import="java.text.DecimalFormat" %>
<%@page import="peachstore.domain.CartItem"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<CartItem> cartItemList = (List)request.getAttribute("cartItemList");
	User userGrade = (User)request.getAttribute("userGrade");

	User user = (User) request.getAttribute("user");
	int amount = 0;

	// 결제에 필요한 정보들
	  String orderId = (String)  request.getAttribute("orderId");
	  String orderName =  user.getUser_name();
	  String customerName = "Peach Store";
	  Integer orderReceiptId = (Integer) request.getAttribute("orderReceiptId");

	  String successUrl = (String)   request.getAttribute("successUrl");
	  String failUrl = (String)   request.getAttribute("failUrl");
/*    String cartItemPk; */
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
</head>
<style>
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

.cart__delete:hover {
	color: red;
	font-weight: bold;
	cursor: pointer;
}

h6 {
	font-size: 28px;
}

.rating {
	margin-top: 20px;
}

.rating span {
	font-size: 18px;
}

.cart__product__item img {
	width: 170px;
	height: auto%;
}
</style>
<body>
	<!-- Offcanvas Menu Begin -->
	<%@ include file="../inc/offcanvas.jsp"%>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<%@ include file="../inc/header.jsp"%>
	<!-- Header Section End -->


	<!-- Shop Cart Section Begin -->
	<section class="shop-cart-section">
		<div>
			<span class="title-h1" id="total-price"
				style="display: block; text-align: center;">장바구니 총액: 0원</span>
		</div>
		<div style="display: block; text-align: center;">
			<p><%= userGrade.getUser_grade().getUserGradeName()%>회원에게
				<%= userGrade.getUser_grade().getDiscountRate()%>%의 할인율이 적용됩니다.
			</p>
			
			모든 주문에 무료 배송 서비스가 제공됩니다
			<div class="row">
				<div class="col-lg-10 offset-lg-1">
					<div class=pay-btn-wrapper>
						<div class="pay-btn-content">
							<button class="pay-btn" id="pay-btn" value="">주문하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container" style="padding: 80px 110px;">
			<div class="row">
				<div class="col-lg-12">
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
								<% int totalPrice=0;%>
								<% for (int i = 0; i < cartItemList.size(); i++) {
							    CartItem item = cartItemList.get(i);
							    Product product = item.getProduct();
							    int price = product.getPrice();
							    String capacity = null, color = null, size = null, engraving = null;
							    int engravingPrice = 0, sizePrice = 0, capacityPrice = 0;
							
							    if (item.getCustom_option() != null) {
							        if (item.getCustom_option().getProduct_capacity() != null) {
							            capacity = item.getCustom_option().getProduct_capacity().getCapacity().getCapacity_name();
							            capacityPrice = item.getCustom_option().getProduct_capacity().getAdditional_price();
							        }
							        if (item.getCustom_option().getProduct_color() != null)
							            color = item.getCustom_option().getProduct_color().getColor().getColor_name();
							        if (item.getCustom_option().getProduct_size() != null) {
							            size = item.getCustom_option().getProduct_size().getSize().getSize_name();
							            sizePrice = item.getCustom_option().getProduct_size().getAdditional_price();
							        }
							        if (item.getCustom_option().getProduct_engraving() != null) {
							            engraving = item.getCustom_option().getProduct_engraving().getEngraving_text();
							            engravingPrice = item.getCustom_option().getProduct_engraving().getEngraving_price();
							        }
							    }
							
							    int finalPrice = price + engravingPrice + sizePrice + capacityPrice;
							    totalPrice += finalPrice;
							%>
							<!-- 담긴 데이터들에 동적으로 호출자 속성 부여 -->
							<tr 
							  data-itemid="<%= item.getCart_item_id() %>"
							  data-name="<%= product.getProductName() %>"
							  data-price="<%= finalPrice %>"
							  data-quantity="<%= item.getQuantity() %>"
							  <%= capacity != null ? "data-capacity=\"" + capacity + "\"" : "" %>
							  <%= color != null ? "data-color=\"" + color + "\"" : "" %>
							  <%= size != null ? "data-size=\"" + size + "\"" : "" %>
							  <%= engraving != null ? "data-engraving=\"" + engraving + "\"" : "" %>
							>
							    <td class="cart__product__item">
							<% 
							String imagePath = "/static/shop/img/no-image.png"; // 기본 이미지
							if (product.getProductImgs() != null && !product.getProductImgs().isEmpty()) {
							    imagePath = "/data/product_" + product.getProductId() + "/" + product.getProductImgs().get(0).getFilename();
							}
							%>
							<!-- 담긴 이미지 또한 받아오기 동적으로 호출자 속성 부여 -->
							<img 
							  src="<%= imagePath %>" 
							  alt="장바구니 상품<%= i %>"
							  <%= (product.getProductImgs() != null && !product.getProductImgs().isEmpty()) 
							        ? "data-filename=\"" + product.getProductImgs().get(0).getFilename() + "\"" 
							        : "" 
							  %>
							>
										<div class="cart__product__item__title">
											<h6><%= product.getProductName() %></h6>

											<div class="rating">
												<% if (capacity != null) { %><span><%= capacity %></span>
												<% } %>
												<% if (color != null) { %><span><%= color %></span>
												<% } %>
												<% if (size != null) { %><span><%= size %></span>
												<% } %>
												<% if (engraving != null) { %><span><%= engraving %></span>
												<% } %>
											</div>
										</div>
									</td>

									<td class="cart__blank"></td>

									<td class="cart__blank"></td>

									<td class="cart__price"><%= String.format("%,d", finalPrice)%></td>

									<td class="cart__delete"
										data-id="<%= item.getCart_item_id() %>">X</td>
								</tr>
								<% } %>
								<!-- 동기방식 사용했기 때문에 위에서 total뿌려주는 건 JS로 -->
								<%
								BigDecimal discountRate = userGrade.getUser_grade().getDiscountRate();
								BigDecimal discountRateDecimal = discountRate.divide(BigDecimal.valueOf(100));

								BigDecimal bdTotalPrice = BigDecimal.valueOf(totalPrice);

								BigDecimal discountAmount = bdTotalPrice.multiply(discountRateDecimal).setScale(0, RoundingMode.HALF_UP);
								BigDecimal finalAmount = bdTotalPrice.subtract(discountAmount); // 최종 금액

								DecimalFormat formatter = new DecimalFormat("#,###");
								%>
								<script>
    document.getElementById("total-price").innerText = "장바구니 총액: <%= String.format("%,d", totalPrice) %>에서 <%= formatter.format(finalAmount) %>원";
</script>
								
							</tbody>
						</table>
					</div>
				</div>
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
	  <script type="text/javascript">
  const cartSnapshots = [
    <% for (int i = 0; i < cartItemList.size(); i++) {
        CartItem item = cartItemList.get(i);
        Product product = item.getProduct();

        String size = null, capacity = null, color = null, engraving = null, filename = "/static/shop/img/no-image.png";
        int engravingPrice = 0, sizePrice = 0, capacityPrice = 0;

        if (item.getCustom_option() != null) {
          if (item.getCustom_option().getProduct_size() != null) {
            size = item.getCustom_option().getProduct_size().getSize().getSize_name();
            sizePrice = item.getCustom_option().getProduct_size().getAdditional_price();
          }
          if (item.getCustom_option().getProduct_capacity() != null) {
            capacity = item.getCustom_option().getProduct_capacity().getCapacity().getCapacity_name();
            capacityPrice = item.getCustom_option().getProduct_capacity().getAdditional_price();
          }
          if (item.getCustom_option().getProduct_color() != null)
            color = item.getCustom_option().getProduct_color().getColor().getColor_name();
          if (item.getCustom_option().getProduct_engraving() != null) {
            engraving = item.getCustom_option().getProduct_engraving().getEngraving_text();
            engravingPrice = item.getCustom_option().getProduct_engraving().getEngraving_price();
          }
        }

        if (product.getProductImgs() != null && !product.getProductImgs().isEmpty()) {
          filename = "/data/product_" + product.getProductId() + "/" + product.getProductImgs().get(0).getFilename();
        }

        int finalPrice = product.getPrice() + engravingPrice + sizePrice + capacityPrice;
    %>
    {
      "product_id": <%= product.getProductId() %>,
      "product_name": "<%= product.getProductName() %>",
      "price": <%= finalAmount %>,
      "size": <%= size != null ? ("\"" + size + "\"") : "null" %>,
      "capacity": <%= capacity != null ? ("\"" + capacity + "\"") : "null" %>,
      "color": <%= color != null ? ("\"" + color + "\"") : "null" %>,
      "engraving": <%= engraving != null ? ("\"" + engraving + "\"") : "null" %>,
      "filename": "<%= filename %>"
    }<%= (i < cartItemList.size() - 1) ? "," : "" %>
    <% } %>
  ];

  const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");

  $(function () {
    // 장바구니 삭제 버튼
    $(".shop__cart__table").on("click", ".cart__delete", function () {
      const cartItemId = $(this).data("id");
      if (confirm("선택 항목을 장바구니에서 삭제하시겠습니까?")) {
        $.ajax({
          url: "/shop/cart/delete",
          type: "POST",
          data: { cartItemId: cartItemId },
          success: function () {
            location.reload();
          },
          error: function () {
            alert("삭제 중 오류가 발생했습니다.");
          }
        });
      }
    });

    // 스냅샷 저장 버튼
$("#pay-btn").on("click", function (e) {
  e.preventDefault();
  const $btn = $(this);
  $btn.prop("disabled", true);

  console.log("보낼 데이터:", cartSnapshots);

  $.ajax({
    url: '/shop/returnsnapshot',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(cartSnapshots),
    success: function (result, status, xhr) {
    		console.dir(result);
	      window.location.href = '/shop/payment/payment-ready';
    },
    error: function (xhr, status, error) {
      console.error("에러 응답:", xhr.responseText);
      console.error("상태:", status);
      console.error("오류:", error);
      alert('스냅샷 저장 중 오류가 발생했습니다.');
    },
    complete: function () {
      $btn.prop("disabled", false);
    }
  });
});


    // 결제하기 버튼
    $("#paypay-btn").on("click", function () {
      tossPayments.requestPayment("간편결제", {
        amount: <%=finalAmount%>,
        orderId: '<%=orderId%>',
        orderName: '<%=orderName%>',
        customerName: '<%=customerName%>',
        successUrl: '<%=successUrl%>',
        failUrl: '<%=failUrl%>'
      });
    });
  });
</script>
	  

</body>
</html>