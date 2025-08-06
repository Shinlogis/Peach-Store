<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="java.util.List"%>
<%-- <%
List<Product> productList =(List)request.getAttribute("productList");
%> --%> 
<section id="product_section" style="margin:0px">
	<!-- 제목 -->
   	<div style="margin-left:165px">
		<span class="title-h1" style="font-size:28px">최신 제품. </span>
		<span class="title-h2" style="font-size:28px">따끈따끈한 신상제품 바로 만나보기</span>
	</div>
     <!--신제품리스트 -->
	<div class="banner2">
		<div class="slider">
			<ul class="slide-container">
				<%for(int i=0;i<productList.size(); i++){ %>
				<li>
					<a href="#">
	                   <img src="/static/shop/img/product/slideipone.jpeg">
	                   <div class="slide-info">
			               	<div class="p_name"><%=productList.get(i).getProductName() %></div>
			               	<div class="p_price"><%=productList.get(i).getPrice() %></div>
	                   </div>
					</a>
              	</li>
              	<%} %>
           </ul>
   		</div>
	</div>
</section>