<%@page import="peachstore.domain.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<header class="header1">
	<ul class="header_nav" style="display: flex;">
		<li><a href=""><img src="/static/shop/img/logo1.png" style="width:15px; height:15px; margin-bottom:3px"></a></li>
		<li><a href="/shop/main">Store</a></li>
		<%for(ProductTopcategory topcategory: topList){%>
		<% String topName=topcategory.getProductTopcategoryName(); %>
			<li><a href="/shop/product/<%=topName%>"><%=topName %></a></li>
		<%}%>
		<li><a href="/shop/inquiry/registForm">고객지원</a></li>
		<li><a href="">검색</a></li>
		<li><a href="">장바구니</a></li>
		<li><a href="/shop/mypage">마이페이지</a></li>
		<% User loginUser = (User)session.getAttribute("user"); %>
		<% if(loginUser==null){%>
      		<li><a href="/shop/loginform">로그인</a></li>
		<%}else{ %>
			<li><a href="/shop/user/logout" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a></li>
		<li><a href="#" style="font-weight:bold;"><%= loginUser.getUser_name() %>님 </a></li>
		<%} %>      
    </ul>
</header>
