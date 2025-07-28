<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.ProductCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
List<ProductCategory> productCategories = (List) request.getAttribute("productCategories");
Paging paging = (Paging) request.getAttribute("paging");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Dashboard</title>
<%@ include file="../../inc/head_link.jsp"%>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake"
				src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo"
				height="60" width="60">
		</div>

		<!-- Navbar -->
		<%@ include file="../../inc/navbar.jsp"%>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<%@ include file="../../inc/left_bar.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">제품 카테고리 목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">제품관리>카테고리</li>
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

					<!-- 카테고리 목록 -->
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h3 class="card-title">n개의 카테고리</h3>

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
												<th>카테고리명</th>
											</tr>
										</thead>
										<tbody>
											<%
											int curPos = paging.getCurPos();
											int num = paging.getNum();
											%>
											<%
											for (int i = 0; i < paging.getPageSize(); i++) {
											%>
											<%
											if (num < 1)
												break;
											%>
											<%
											ProductCategory productCategory = productCategories.get(curPos++);
											%>
											<tr>
												<td><%=num--%></td>
												<td><%=productCategory.getProductCategoryName()%></td>
											</tr>
											<%
											}
											%>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
								<div class="card-footer clearfix">
									<ul class="pagination pagination-sm m-0 justify-content-center">
										<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
										<%
										for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
										%>
										<%
										if (i > paging.getTotalPage())
											break;
										%>
										<li class="page-item"><a class="page-link" href="#"><%=i%></a></li>
										<%
										}
										%>
										<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
									</ul>
								</div>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.상품 목록 -->
					<!-- 제품 카테고리 등록 -->
					<button type="button" class="btn btn-primary" id="bt_regist"
						data-toggle="modal" data-target="#categoryModal">등록</button>
					<!-- 카테고리 등록 모달 -->
					<div class="modal fade" id="categoryModal" tabindex="-1"
						role="dialog" aria-labelledby="categoryModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">

								<div class="modal-header">
									<h5 class="modal-title" id="categoryModalLabel">카테고리 등록</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>

								<div class="modal-body">
									<form id="categoryForm">
										<div class="form-group">
											<label for="categoryName">카테고리명</label> 
											<input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="카테고리명을 입력하세요">
										</div>
									</form>
								</div>

								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary" id="submitCategory">등록</button>
								</div>

							</div>
						</div>
					</div>
					<!-- / -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<%@ include file="../../inc/footer.jsp"%>

		<!-- Control Sidebar -->
		<%//@ include file="../inc/right_bar.jsp" %>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	<%@ include file="../../inc/footer_link.jsp"%>
	<script src="/static/admin/custom/ProductImg.js"></script>
	<script>
		// 카테고리 등록
		function regist(categoryName) {
			$.ajax({
				url : "/admin/product/category/regist",
				type : "post",
				data: {"categoryName" : categoryName},
				success : function(result, status, xhr) {
					if (result == "success"){
						alert("등록 성공");
						location.reload();
					}
				},
				error : function(xhr, status, result) {
					alert("오류 발생");
				}
			});
		}

		// 등록 버튼 클릭 이벤트
		document.getElementById("submitCategory").addEventListener("click", function() {
			// 입력한 카테고리명 받아오기
			const categoryName = document.getElementById("categoryName").value.trim();
			
			// 카테고리명이 비어있는지 검사
			if (!categoryName) {
				alert("카테고리명을 입력하세요.");
				return;
			}
			// 카테고리 등록
			regist(categoryName);

			// 등록 후 모달 닫기
			$('#categoryModal').modal('hide');
			
			// 폼 초기화
			document.getElementById("categoryForm").reset();
		});
	</script>

</body>
</html>













