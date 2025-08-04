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
   <%@ include file="../inc/head_link.jsp" %>
</head>
<style>
.pay-btn-wrapper{
   display:flex;
   justify-content:center;
   margin:auto;
   background-color:#fff;
   border-radius: 18px;
   padding: 8px;
   width: 290px;
}

.pay-btn-content{
   width: 290px;
   margin-top: 31px;
}

.pay-btn{
   width:100%;
   border:none;
   border-radius:8px;
   background-color:#0071E3;
   padding: 8px 15px;
   font-size:14px;
   font-weight:600;
   letter-spacing: 1px;
   color:white;
}

.cart__delete:hover {
	color: red;
	font-weight: bold;
	cursor: pointer;
	}

h6{
   font-size:28px;
}

.rating{
	margin-top:35px;
}

.rating span{
	font-size:18px;
}

.cart__product__item img{
	width:150px;
	height:100%;
}
</style>
<body>
   <!-- Offcanvas Menu Begin -->
   <%@ include file="../inc/offcanvas.jsp" %>
   <!-- Offcanvas Menu End -->

   <!-- Header Section Begin -->
   <%@ include file="../inc/header.jsp"%>
   <!-- Header Section End -->
   
   
   <!-- Shop Cart Section Begin -->
    <section class="shop-cart-section">
       <div>
         <span class="title-h1" style="display: block; text-align: center;">장바구니 총액: </span>
      </div>
      <div style="display: block; text-align: center;">모든 주문에 무료 배송 서비스가 제공됩니다</div>
      
      <div class=pay-btn-wrapper >
         <div class="pay-btn-content">
            <button class="pay-btn" value="">결제하기 </button>
         </div>
      </div>
      
        <div class="container" style="padding:80px 110px;">
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
							<% for (int i = 0; i < cartItemList.size(); i++) {
							    CartItem item = cartItemList.get(i);
							    Product product = item.getProduct();
							    int price = product.getPrice();
							    String capacity = null, color = null, size = null, engraving = null;
							    int engravingPrice = 0;
							
							    if (item.getCustom_option() != null) {
							        if (item.getCustom_option().getProduct_capacity() != null)
							            capacity = item.getCustom_option().getProduct_capacity().getCapacity().getCapacity_name();
							        if (item.getCustom_option().getProduct_color() != null)
							            color = item.getCustom_option().getProduct_color().getColor().getColor_name();
							        if (item.getCustom_option().getProduct_size() != null)
							            size = item.getCustom_option().getProduct_size().getSize().getSize_name();
							        if (item.getCustom_option().getProduct_engraving() != null) {
							            engraving = item.getCustom_option().getProduct_engraving().getEngraving_text();
							            engravingPrice = item.getCustom_option().getProduct_engraving().getEngraving_price();
							        }
							    }
							
							    int finalPrice = price + engravingPrice;
							%>
							<tr 
							  data-id="<%= item.getCart_item_id() %>"
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
							<img src="<%= imagePath %>" alt="장바구니 상품<%= i %>">

							        <div class="cart__product__item__title">
							            <h6><%= product.getProductName() %></h6>
							
							            <div class="rating">
							                <% if (capacity != null) { %><span><%= capacity %></span><% } %>
							                <% if (color != null) { %><span><%= color %></span><% } %>
							                <% if (size != null) { %><span><%= size %></span><% } %>
							                <% if (engraving != null) { %><span><%= engraving %></span><% } %>
							            </div>
							        </div>
							    </td>
							
							    <td class="cart__blank">
							    </td>
							
							    <td class="cart__blank"></td>
							
							    <td class="cart__price"><%= finalPrice %></td>
							
							    <td class="cart__delete" data-id="<%= item.getCart_item_id() %>">X</td>
							</tr>
							<% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
			<div class="row">
			    <div class="col-lg-3 offset-lg-8">
			        <div class="cart__btn update__btn">
			            <a href="/shop/main">쇼핑 계속하기</a>
			        </div>
			    </div>
			</div>
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                           <p><%= userGrade.getUser_grade().getUserGradeName()%>회원에게 <%= userGrade.getUser_grade().getDiscountRate()%>%의 할인율이 적용됩니다.</p>
                        <ul>
                            <li>총액<span>$ 750.0</span></li>
                            <li>할인된 금액<span>$ 750.0</span></li>
                        </ul>
                        <a href="#" class="primary-btn">Proceed to checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Cart Section End -->
    
   <!-- Instagram Begin -->
   <%@ include file="../inc/instagram.jsp" %>   
   <!-- Instagram End -->

   <!-- Footer Section Begin -->
   <%@ include file="../inc/footer.jsp" %>
   <!-- Footer Section End -->

   <!-- Search Begin -->
   <%@ include file="../inc/search.jsp" %>
   <!-- Search End -->

   <!-- Js Plugins -->
   <%@ include file="../inc/footer_link.jsp" %>
	<script type="text/javascript">
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