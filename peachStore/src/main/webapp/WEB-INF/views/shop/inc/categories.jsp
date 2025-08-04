<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<section id="category" style="margin-left:165px">
 	<!-- 제목 -->
	<div class="store-title">
		<div>
			<span class="title-h1">스토어. </span>
			<span class="title-h2">가장 좋아하는 PEACH를</span>
		</div>
		<div  class="title-h2">구입하는 가장 좋은 방법</div>
	</div>
	 <!-- 카테고리 -->
	<div class="store-category">
		 <ul class="store-category-ul">
		 	<%for(ProductTopcategory topcategory: topList){%>
		 	<% String topName=topcategory.getProductTopcategoryName(); %>
        	<% int topId=topcategory.getProductTopcategoryId(); %>
        	<% String imagePath = "/data/category_" + topcategory.getProductTopcategoryId() + "/" + topcategory.getFilename();%>
	        <li>
	        	<img style="width:100%; height:120px;" src="<%=imagePath%>">
	            <a style="color:#212529;" href="/shop/product?topid=<%=topId%>" class="category_name"><%=topName %></a>
	        </li>
	        <%} %>
         </ul>
    </div>
</section>
