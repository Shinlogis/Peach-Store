<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="peachstore.domain.User"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<header class="header1">
     <ul class="header_nav" style="display: flex;">
		<li><a href="/shop/main"><img src="/static/shop/img/logo1.png" style="width:15px; height:15px; margin-bottom:3px"></a></li>
		<li><a href="/shop/main">Store</a></li>
		<%for(ProductTopcategory topcategory: topList){%>
		<% String topName=topcategory.getProductTopcategoryName(); %>
        <% int topId=topcategory.getProductTopcategoryId(); %>
        <li><a href="/shop/product?topid=<%=topId%>"><%=topName %></a></li>
        <%}%>
		<li><a href="/shop/inquiry/registForm">고객지원</a></li>
		<% User loginUser = (User)session.getAttribute("user"); %>
        <li><a href=""><img src="/static/shop/img/header/search1.png" style="width:13px; height:100%; margin-bottom:3px"></a></li>
        <li><a href="/shop/user/cart"><img src="/static/shop/img/header/cart.png" style="width:18px; height:100%; margin-bottom:3px"></a></li>
		<% if(loginUser==null){%>
        <li><a href="/shop/user/loginform"><img src="/static/shop/img/header/mypage.png" style="width:16px; height:100%; margin-bottom:3px"></a></li>
      		<li><a href="/shop/user/loginform">로그인</a></li>
		<%}else{ %>
        <li><a href="/shop/mypage"><img src="/static/shop/img/header/mypage.png" style="width:16px; height:100%; margin-bottom:3px"><span style=font-weight:bold> <%= loginUser.getUser_name() %>님</span></a></li>
			<li><a href="/shop/user/logout" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a></li>
		<%} %>      
    </ul>
    
</header>
