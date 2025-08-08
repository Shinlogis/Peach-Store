<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<Product> productList =(List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>
	<%@ include file="./inc/head_link.jsp" %>
	<link rel="stylesheet"  href="/static/shop/css/main/product_section.css">
    
</head>
<body style="background-color:#f5f5f7;">

    <!-- Header Section Begin -->
<%@ include file="./inc/header.jsp" %>
    <!-- Header Section End -->

    <!-- Categories Section Begin -->
<%@ include file="./inc/categories.jsp" %>
	<!-- Categories Section End -->

<!-- Product Section Begin -->
<%@ include file="./inc/product_section.jsp" %>
<!-- Product Section End -->

<!-- Banner Section Begin -->
<%@ include file="./inc/banner_section.jsp" %>
<!-- Banner Section End -->

<!-- Trend Section Begin -->
<%@ include file="./inc/trend_section.jsp" %>
<!-- Trend Section End -->

<!-- Instagram Begin -->
<%@ include file="./inc/instagram.jsp" %> 
<!-- Instagram End -->

<!-- Footer Section Begin -->
<%@ include file="./inc/footer.jsp" %>
<!-- Footer Section End -->

<!-- Search Begin -->
<%@ include file="./inc/search.jsp" %>
<!-- Search End -->

<!-- Js Plugins -->
<%@ include file="./inc/footer_link.jsp" %>

<!-- AdminLTE for demo purposes -->
<script src="/static/admin/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
</body>

</html>