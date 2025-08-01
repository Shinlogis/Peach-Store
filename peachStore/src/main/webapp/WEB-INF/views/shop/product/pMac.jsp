<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<ProductSubcategory> subList=(List)request.getAttribute("subList");
	String topname=(String)request.getAttribute("topName");
	List<Product> listAll=(List)request.getAttribute("list");
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%@ include file="../inc/head_link.jsp" %>
	<link rel="stylesheet"  href="/static/shop/css/product/productList.css">
</head>
<body style="background-color:#f5f5f7;">
    <!-- Header Section Begin -->
<%@ include file="../inc/header.jsp" %>
    <!-- Header Section End -->

 <!-- product-list-section start -->
 <section id="product-list-section" style="margin:auto">
	<!-- 제목 -->
	<div>
		<span class="title-h1">당신의 새로운 <%=topname%> 구입하기  </span>
	</div>
	<!-- 제목 -->
	
	<!-- 서브카테고리토글  시작 -->
	<div class=sub-category-toggle >
		<div class=sub-category-toggle-buttons>
			<%for(ProductSubcategory productSubcategory : subList){ %>
				<button class="sub-btn" value="<%=productSubcategory.getProductSubcategoryId() %>"><%=productSubcategory.getProductSubcategoryName() %>
				</button>
			<%} %>
		</div>
	</div>
	<!-- 서브카테고리토글 끝-->
	
	<!--상품 리스트  -->
	<div class="content-container-p">
		<%for(Product product:listAll){ %>
		<a href='/shop/product/detail?productId=<%=product.getProductId() %>' class='p_list'>
		<% if(product.getProductImgs()!=null && !product.getProductImgs().isEmpty()){%>
			<% String imagePath = "/data/product_" + product.getProductId() + "/" + product.getProductImgs().get(0).getFilename();%>
			<img src='<%= imagePath %>' class='slide' alt='Slide 1'>
		<% }%>
		<div class='p_name'><%=product.getProductName() %></div>
		<div class='p_price'><%=product.getPrice()%></div>
		</a>
		<%} %>
	</div>
	<!--상품 리스트  -->
</section>
 <!--  product-list-section end -->

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

<!-- AdminLTE for demo purposes -->
<script src="/static/admin/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/static/admin/dist/js/pages/dashboard.js"></script>
<script type="text/javascript">
function printCategory(list){
	let tag="";
	
	for(let i=0;i<list.length;i++){
		tag+="<a href='/shop/product/detail?productId=" + list[i].productId + "' class='p_list'>";
		if(list[i].productImgs[0]!=null){
		tag+="<img src='/data/product_"+list[i].productId+"/"+list[i].productImgs[0].filename+"' class='slide' alt='Slide 1'>";
		}
		tag+="<div class='p_name'>" + list[i].productName +"</div>";
		tag+="<div class='p_price'>" + list[i].price +"</div>";
		tag+="</a>";
	}
	
	$(".content-container-p").html(tag);  // innerHTML=태그 동일
}


function getProductList(subId){
	$.ajax({
		url:"/shop/product/list", 
		type:"GET",
		data: { subId: subId },
		success:function(result, status, xhr){
			console.log(result);
			printCategory(result);
		},
		error:function(xhr, status, err){
		}
	});
}

$(".sub-btn").click(function () {
    $(".sub-btn").css({
      "background-color": "",
      "color": ""
    });

    $(this).css({
      "background-color": "#1d1d1f",
      "color": "white"
    });
    
 	getProductList($(this).val());
 });
 
</script>
</body>
</html>
