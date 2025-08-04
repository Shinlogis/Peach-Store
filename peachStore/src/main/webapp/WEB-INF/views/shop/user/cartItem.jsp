<%@page import="peachstore.domain.CartItem"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
   List<ProductTopcategory> topList =(List)request.getAttribute("topList");
   List<CartItem> cartItemList = (List)request.getAttribute("cartItemList");
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
h6{
   font-size:20px;
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
         <span class="title-h1" style="display: block; text-align: center;">장바구니총액: 값 넣어주기</span>
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
                                    <th>가격</th>
                                    <th>수량</th>
                                    <th>가격</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <!-- 전부 fk 설정이므로 참조해서 받아와야함.get().get() -->
                            <%for(int i =0;i<cartItemList.size();i++){ %>
                                <tr>
                                    <td class="cart__product__item">
                                        <img src="/static/shop/img/shop-cart/cp-1.jpg" alt="주문 상품">
                                        <div class="cart__product__item__title">
                                            <h6><%=cartItemList.get(i).getProduct().getProductName() %></h6>
                                            <div class="rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                    </td>
                                    <%if(cartItemList.get(i).getCustom_option()==null){ %>
                                    <td class="cart__price"><%= cartItemList.get(i).getProduct().getPrice()%></td>
                                    <%}else if(cartItemList.get(i).getCustom_option()!=null){ %>
                                    <td class="cart__price"><%= cartItemList.get(i).getProduct().getPrice() + cartItemList.get(i).getCustom_option().getProduct_engraving().getEngraving_price()%></td>
                                    <%} %>
                                    <td class="cart__quantity">
                                        <div class="pro-qty">
                                            <input type="text" value="<%= cartItemList.get(i).getQuantity()%>">
                                        </div>
                                    </td>
                                    <td class="cart__total">1,000,000</td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>
                               <%} %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn">
                        <a href="#">Continue Shopping</a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn update__btn">
                        <a href="#"><span class="icon_loading"></span> Update cart</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                        <ul>
                           <p>실버회원에게 5%의 할인율이 적용됩니다.</p>
                            <li>총액<span>$ 750.0</span></li>
                            <li>결제할 금액<span>$ 750.0</span></li>
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
      
   </script>
</body>
</html>