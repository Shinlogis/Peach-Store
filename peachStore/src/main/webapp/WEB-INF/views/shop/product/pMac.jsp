<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<ProductSubcategory> subList=(List)request.getAttribute("subList");
	String topname=(String)request.getAttribute("topName");
	List<Product> listAll=(List)request.getAttribute("list");
	int currentPage = (Integer)request.getAttribute("currentPage");
	int totalPage = (Integer)request.getAttribute("totalPage");
	int topid = (Integer)request.getAttribute("topid");
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
	<div class="sub_category">
		<div class=sub-category-toggle >
			<div class=sub-category-toggle-buttons>
				<%for(ProductSubcategory productSubcategory : subList){ %>
					<button class="sub-btn" value="<%=productSubcategory.getProductSubcategoryId() %>" 
					data-img="/data/subcategory_<%=productSubcategory.getProductSubcategoryId()%>/<%=productSubcategory.getFilename()%>">
					<%=productSubcategory.getProductSubcategoryName() %>
					</button>
				<%} %>
			</div>
		</div>
		<!-- <img class="sub_img" src="" style="height:160px; width:auto; margin-bottom:60px;"> -->
	</div>
	<!-- 서브카테고리토글 끝-->
	<!--상품 리스트  -->
	<div class="content-container-p">
		<%if(listAll != null && !listAll.isEmpty()) { %>
			<%for(Product product:listAll){ %>
			<a href='/shop/product/detail?productId=<%=product.getProductId() %>' class='p_list'>
			<% if(product.getProductImgs()!=null && !product.getProductImgs().isEmpty()){%>
				<% String imagePath = "/data/product_" + product.getProductId() + "/" + product.getProductImgs().get(0).getFilename();%>
				<img src='<%= imagePath %>' class='slide' alt='Slide 1'>
			<% }%>
				<div class='p_name'><%=product.getProductName() %></div>
				<div class='p_price'>₩<%=product.getPrice()%></div>
			</a>
			<%} %>
		<%} else { %>
			<div style="text-align: center; padding: 80px 0; grid-column: 1 / -1;">
				<h3 style="color: #86868b; font-weight: 400;">등록된 상품이 없습니다</h3>
				<p style="color: #86868b; margin-top: 10px;">곧 새로운 상품을 준비해드리겠습니다.</p>
			</div>
		<%} %>
	</div>
	<!--상품 리스트  -->
	
	<%-- <!-- 페이징 네비게이션 -->
	<%if(listAll != null && !listAll.isEmpty() && totalPage > 1) { %>
	<div class="pagination-wrapper" style="display: flex; justify-content: center; margin: 50px 0;">
		<div class="pagination">
			<!-- 이전 페이지 -->
			<% if(currentPage > 1) { %>
				<a href="/shop/product?topid=<%=topid%>&page=<%=currentPage-1%>" class="page-btn">&laquo; 이전</a>
			<% } %>
			
			<!-- 페이지 번호들 -->
			<% 
				int startPage = Math.max(1, currentPage - 2);
				int endPage = Math.min(totalPage, currentPage + 2);
				
				for(int i = startPage; i <= endPage; i++) {
					if(i == currentPage) {
			%>
				<span class="page-btn current"><%=i%></span>
			<% } else { %>
				<a href="/shop/product?topid=<%=topid%>&page=<%=i%>" class="page-btn"><%=i%></a>
			<% 
					}
				}
			%>
			
			<!-- 다음 페이지 -->
			<% if(currentPage < totalPage) { %>
				<a href="/shop/product?topid=<%=topid%>&page=<%=currentPage+1%>" class="page-btn">다음 &raquo;</a>
			<% } %>
		</div>
	</div>
	<%} %>
	<!-- 페이징 네비게이션 끝 --> --%>
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
		tag+="<div class='p_price'>₩" + list[i].price +"</div>";
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
    
 	// 이미지 변경
    const imgPath = $(this).data("img");
 	console.log(imgPath);
    $(".sub_img").attr("src", imgPath);
    
 	getProductList($(this).val());
 });
 
</script>
</body>
</html>
