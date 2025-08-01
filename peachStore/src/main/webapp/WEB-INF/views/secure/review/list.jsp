<%@page import="peachstore.domain.Review"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<Review> list = (List)request.getAttribute("list");
	Paging paging = (Paging)request.getAttribute("paging");
	int firstPage = paging.getFirstPage();
	int lastPage = paging.getLastPage();
	int currentPage = paging.getCurrentPage();
	int totalPage = paging.getTotalPage();
	
    String searchKey = (String) request.getAttribute("searchKey"); // 검색어 받아오기
    if (searchKey == null) searchKey = "";
    
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>리뷰 관리</title>
<%@ include file="../inc/head_link.jsp"%>
<style>
    /* 상위 카테고리 수정/삭제 버튼 크기 맞춤 */
    .category-btn-group button {
        margin-left: 5px;
    }
</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Preloader -->
    <div class="preloader flex-column justify-content-center align-items-center">
        <img class="animation__shake" src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60" />
    </div>

    <!-- Navbar -->
    <%@ include file="../inc/navbar.jsp"%>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <%@ include file="../inc/left_bar.jsp"%>
    
    <!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">상품 목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">상품관리>상품목록</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->


			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">

					<!-- 상품 목록 -->
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h3 class="card-title"><%=list.size() %>개의 결과</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm" style="width: 150px;">
											<input type="text" name="table_search"
												class="form-control float-right" placeholder="Search">

											<div class="input-group-append">
												<button type="submit" class="btn btn-default">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0">
									<table class="table table-hover text-nowrap">
										<thead>
											<tr>
												<th>NO</th>
												<th>작성일</th>
												<th>고객정보</th>
												<th>제품</th>
												<th>이미지</th>
												<th>리뷰 상세 내용</th>
											</tr>
										</thead>
										<tbody>
										<%
											int curPos = paging.getCurPos();
											int num = paging.getNum();
										%>
										<%for (int i=0; i<paging.getPageSize(); i++){ %>
										<% if(num<1) break; %>
										<% Review review = list.get(curPos++); %>
											<tr>
												<td><%= num-- %>
												<%
												    String imgSrc = "/static/admin/dist/img/default.png"; // 기본 이미지 경로
//												    if (review != null &&
	//											        product.getProductImgList() != null &&
		//										        !product.getProductImgList().isEmpty() &&
			//									        product.getProductImgList().get(0) != null &&
				//								        product.getProductImgList().get(0).getFilename() != null) {
												
					//							        imgSrc = "/data/p_" + product.getProduct_id() + "/" +
						//						                 product.getProductImgList().get(0).getFilename();
							//					    }
												%>
												<td><%= review.getRegdate() %></td>
												<td>
													<%= review.getUser().getUser_name()%><br>
													<span style="color:gray;"><%= review.getUser().getId() %></span><br>
													<%= review.getUser().getUser_grade().getUserGradeName() %>
												</td>
												<td>
													제품이미지 추가 필요<br>
													<%= review.getOrderDetail().getSnapshot().getProduct_name() %><br>
													<%= review.getOrderDetail().getSnapshot().getSize()%>&nbsp;
													<%= review.getOrderDetail().getSnapshot().getCapacity()%>&nbsp;
													<%= review.getOrderDetail().getSnapshot().getColor()%>
													<%= (review.getOrderDetail().getSnapshot().getEngraving() != null) ? "<br>각인: " + review.getOrderDetail().getSnapshot().getEngraving() : "" %><br>
													<span style="color:gray;">구매가:&nbsp;<%= review.getOrderDetail().getSnapshot().getPrice() %></span>
												</td>
												<td>
												  <img width="40px" src="<%= imgSrc %>">
												</td>
												<td>
												리뷰이미지 추가 필요<br>
												<%= review.getContent() %>
												</td>
											</tr>
										<%} %>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
								<div class="card-footer clearfix">
									<ul class="pagination pagination-sm m-0 justify-content-center">
										<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
										<% for (int i=paging.getFirstPage(); i<=paging.getLastPage(); i++){ %>
										<% if (i>paging.getTotalPage()) break;%>
										<li class="page-item"><a class="page-link" href="#"><%=i %></a></li>
										<%} %>
										<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
									</ul>
								</div>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.상품 목록 -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		

    <%@ include file="../inc/footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@ include file="../inc/footer_link.jsp"%>

<script src="/static/admin/custom/ProductImg.js"></script>
</body>
</html>
                    