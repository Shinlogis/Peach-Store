<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.ProductCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductCategory> productCategories = (List) request.getAttribute("productCategories");
	Paging paging = (Paging) request.getAttribute("paging");
	// 페이징 처리 변수들
	int totalRecord = paging.getTotalRecord();
	int currentPage = paging.getCurrentPage();
	int pageSize = paging.getPageSize();
	int firstPage = paging.getFirstPage();
	int lastPage = paging.getLastPage();
	int totalPage = paging.getTotalPage();
	int startNum = totalRecord - (currentPage - 1) * pageSize;
	int size = productCategories.size();
	
	String searchKey = (String) request.getAttribute("searchKey"); // 검색어 받아오기
	if (searchKey == null)
		searchKey = "";
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
			<img class="animation__shake" src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
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
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item">
									<a href="#">Home</a>
								</li>
								<li class="breadcrumb-item active">
									제품관리&gt;카테고리 관리
								</li>
							</ol>
						</div>
					</div>
				</div>
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
									<h3 class="card-title"><%=totalRecord%>개의 카테고리</h3>
									<div class="card-tools">
										<div class="input-group input-group-sm" style="width: 150px;">
											<input type="text" id="searchKey" name="searchKey" class="form-control float-right" placeholder="Search" value="<%=searchKey != null ? searchKey : ""%>">
											<div class="input-group-append">
												<button id="bt_search" type="submit" class="btn btn-default">
													<i class="fas fa-search"></i>
												</button>
												&nbsp;&nbsp;
												<!-- 제품 카테고리 등록 버튼-->
												<button type="button" class="btn btn-primary" id="bt_regist"
													data-toggle="modal" data-target="#categoryModal">등록</button>
												<!-- /.제품 카테고리 등록 버튼 -->
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
												<th>수정</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
											<%
												for (int i = 0; i < size; i++) {
													ProductCategory productCategory = productCategories.get(i);
											%>
											<tr>
												<td><%=startNum - i%></td>
												<td><%=productCategory.getProductCategoryName()%></td>
												<td>
													<button type="button" class="btn btn-secondary"
														data-toggle="modal" data-target="#categoryEditModal"
														data-id="<%=productCategory.getProductCategoryId()%>"
														data-name="<%=productCategory.getProductCategoryName()%>">
														수정
													</button>
												</td>
												<td>
													<button type="button" class="btn btn-danger"
														data-toggle="modal" data-target="#categoryDelModal"
														data-id="<%=productCategory.getProductCategoryId()%>"
														data-name="<%=productCategory.getProductCategoryName()%>">
														삭제
													</button>
												</td>
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
										<!-- 페이지 이동 시에도 가져갈 검색 키워드 -->
										<%
											String encodedSearchKey = "";
											if (searchKey != null && !searchKey.isEmpty()) {
											    encodedSearchKey = java.net.URLEncoder.encode(searchKey, "UTF-8");
											}
										%>
										<!-- 이전 버튼. 현재페이지가 1페이지면 비활성화 -->
										<li class="page-item <%=(currentPage == 1) ? "disabled" : ""%>">
											<!-- 이전 페이지로 이동. currentPage가 2 이상일 경우만 currentPage - 1, 아니면 1 유지 -->
											<%
												int prevPage = (currentPage > 1) ? currentPage - 1 : 1;
											%>
											<a class="page-link" 
												href="?currentPage=<%= prevPage%>
														&searchKey=<%= encodedSearchKey%>">
													&laquo;
											</a>
										</li>
										<!-- 페이지 숫자 버튼 -->
										<!-- firstPage부터 lastPage까지만 출력하고, 실제 totalPage를 초과하면 break -->
										<%
											for (int i = firstPage; i <= lastPage; i++) {
												if (i > totalPage){
													break;
												}
										%>
										<!-- 현재 페이지에선 active 클래스 추가해서 강조 효과 -->
										<li class="page-item <%=(i == currentPage) ? "active" : ""%>">
											<!-- 각 페이지 번호를 클릭하면 해당 페이지로 이동. currentPage 값을 i로, 검색 키워드도 같이 넘김 -->
											<a class="page-link" 
													href="?currentPage=<%= i %>
														&searchKey=<%= encodedSearchKey %>">
												<%= i %>
											</a>
										</li>
										<%
											}
										%>
										<!-- 다음 버튼. 현재 페이지가 totalPage이면 비활성화 -->
										<li class="page-item <%=(currentPage == totalPage) ? "disabled" : ""%>">
											<!-- 다음 페이지로 이동. currentPage가 totalPage보다 작을 경우만 currentPage + 1 -->
											<%
											    int nextPage = (currentPage < totalPage) ? currentPage + 1 : totalPage;
											%>
											<a class="page-link" 
												href="?currentPage=<%= nextPage %>
													&searchKey=<%= encodedSearchKey %>">
												&raquo;
											</a>
										</li>
									</ul>
								</div>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.카테고리 목록 -->
					<!-- 카테고리 등록 모달 -->
					<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="categoryModalLabel">카테고리 등록</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form id="categoryForm">
										<div class="form-group">
											<label for="categoryName">카테고리명</label> <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="카테고리명을 입력하세요">
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
					<!-- /.카테고리 등록 모달 -->
					<!-- 카테고리 수정 모달 -->
					<div class="modal fade" id="categoryEditModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="categoryModalLabel">카테고리를 수정하시겠어요?</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form id="categoryEditForm">
										<div class="form-group">
											<label for="editCategoryName">현재 카테고리명</label> 
											<label id="categoryNameLabel" class="h5 font-weight-bold text-dark d-block"></label> 
											<input type="text" class="form-control" id="editCategoryName" name="editCategoryName" placeholder="수정할 카테고리명을 입력하세요">
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" id="editCategory">수정</button>
									<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /.카테고리 수정 모달 -->
					<!-- 카테고리 삭제 모달 -->
					<div class="modal fade" id="categoryDelModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="categoryModalLabel">카테고리를 삭제하시겠어요?</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form id="categoryDelForm">
										<div class="form-group">
											<div class="modal-body text-center pt-0 pb-4">
												<p class="text-secondary mb-1">다음 카테고리를 삭제합니다.</p>
												<label id="delCategoryName" class="h5 font-weight-bold text-dark d-block"></label>
												<p class="text-secondary mb-1">이 작업은 되돌릴 수 없습니다.</p>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" id="delCategory">확인</button>
									<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /.카테고리 삭제 모달 -->
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
		// 검색 버튼 클릭 이벤트
		$("#bt_search").click(()=>{
			let searchKey = document.getElementById("searchKey").value.trim();
			location.href = "/admin/product/category/list?currentPage=1&searchKey="+encodeURIComponent(searchKey);
		});

		// 등록 요청
		function regist(categoryName) {
			$.ajax({
				url : "/admin/product/category/regist",
				type : "post",
				data : {
					"categoryName" : categoryName
				},
				success : function(result, status, xhr) {
					if (result == "success") {
						alert("등록 성공");
						location.href = "/admin/product/category/list?currentPage=1";
					}
				},
				error : function(xhr, status, result) {
					alert("오류 발생");
				}
			});
		}

		// 등록 버튼 클릭 이벤트
		$("#submitCategory").click(()=>{
			let categoryName = document.getElementById("categoryName").value.trim();
			if (!categoryName) {
				alert("카테고리명을 입력하세요.");
				return;
			}
			regist(categoryName);

			$('#categoryModal').modal("hide");
			document.getElementById("categoryForm").reset();
		});

		// 수정 모달 오픈 이벤트
		$("#categoryEditModal").on("show.bs.modal", function(e) {
			let button = $(e.relatedTarget);
			let productCategoryId = button.data("id");
			let categoryName = button.data("name");

			let modal = $(this);
			modal.find("#categoryNameLabel").text(categoryName);
			modal.data("productCategoryId", productCategoryId);
			modal.find("#editCategoryName").val(categoryName);
		});

		// 수정 요청
		function update(productCategoryId, newName) {
			$.ajax({
				url : "/admin/product/category/update",
				type : "POST",
				data : {
					productCategoryId : productCategoryId,
					productCategoryName : newName
				},
				success : function(result) {
					if (result === "success") {
						alert("수정 성공");
						$("#categoryEditModal").modal('hide');
						location.reload();
					} else {
						alert("수정 실패");
					}
				},
				error : function() {
					alert("서버 오류");
				}
			});
		}

		// 수정 확인 버튼 클릭 이벤트
		$("#editCategory").click(()=>{
			let modal = $("#categoryEditModal");
			let productCategoryId = modal.data("productCategoryId");
			let newName = modal.find("#editCategoryName").val().trim();

			if (!newName) {
				alert("수정할 카테고리명을 입력하세요.");
				return;
			}

			update(productCategoryId, newName);
		});

		// 삭제 모달 오픈 이벤트
		$("#categoryDelModal").on("show.bs.modal", function(e) {
			let button = $(e.relatedTarget);
			let productCategoryId = button.data("id");
			let categoryName = button.data("name");

			let modal = $(this);
			modal.find("#delCategoryName").text(categoryName);
			modal.data("productCategoryId", productCategoryId);
		});

		// 삭제 요청
		function deactive(productCategoryId) {
			$.ajax({
				url : "/admin/product/category/deactivate",
				type : "POST",
				data : {
					"productCategoryId" : productCategoryId
				},
				success : function(result) {
					if (result === "success") {
						alert("삭제 성공");
						$("#categoryDelModal").modal("hide");
						location.href = "/admin/product/category/list?currentPage=1"; // 1페이지로 이동
					} else {
						alert("삭제 실패");
					}
				},
				error : function() {
					alert("서버 오류");
				}
			});
		}

		// 삭제 확인 버튼 클릭 이벤트
		$("#delCategory").click(()=>{
			let modal = $("#categoryDelModal");
			let productCategoryId = modal.data("productCategoryId");

			deactive(productCategoryId);
		});
	</script>

</body>
</html>
