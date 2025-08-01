<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.util.Paging"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<Inquiry> inquiries = (List)request.getAttribute("inquiries");
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
<title>문의 관리</title>
<%@ include file="../inc/head_link.jsp"%>
<style>
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
								<li class="breadcrumb-item active">문의관리>문의목록</li>
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
									<h3 class="card-title"><%=inquiries.size() %>개의 결과</h3>

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
												<th>문의날짜</th>
												<th>제목</th>
												<th>사용자명</th>
												<th>문의내용</th>
												<th>답변자</th>
												<th>답변내용</th>
											</tr>
										</thead>
										<tbody>
										<%
											int curPos = paging.getCurPos();
											int num = paging.getNum();
										%>
										<%for (int i=0; i<paging.getPageSize(); i++){ %>
										<% if(num<1) break; %>
										<% Inquiry inquiry = inquiries.get(curPos++); %>
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
												<td><%= inquiry.getCreated_at() %></td>
												<td><%= inquiry.getTitle() %></td>
												<td><%= inquiry.getUser().getUser_name() %></td>
												<td><%= inquiry.getInquiry_text() %></td>
												<td><%= inquiry.getAdmin().getName() %></td>
												<td>
												  <div class="dropdown">
												    <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="reviewManageDropdown<%= inquiry.getInquiry_id() %>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												      관리
												    </button>
												    <div class="dropdown-menu" aria-labelledby="reviewManageDropdown<%= inquiry.getInquiry_id() %>">
												      <a class="dropdown-item" href="#" onclick="hideReview(<%=  inquiry.getInquiry_id() %>); return false;">상태 변경</a>
												      <a class="dropdown-item text-danger" href="#" onclick="deleteReview(<%=  inquiry.getInquiry_id() %>); return false;">리뷰 삭제</a>
												    </div>
												  </div>
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
<script>
	function hideReview(reviewId) {
	    if (confirm('이 리뷰 상태를 변경하시겠습니까?')) {
	          $.ajax({
	              url: "/admin/review/toggle",
	              type: "POST",
	              data: { reviewId: reviewId },
	              success: function (result) {
	                  if (result.success) {
	                      alert("변경 성공");
	                      location.reload();
	                  } else {
	                      alert("변경 실패");
	                  }
	              },
	              error: function () {
	                  alert("서버 오류");
	              }
	      });
	    }
	  }
	
	  function deleteReview(reviewId) {
	    if (confirm('이 리뷰를 정말 삭제하시겠습니까? 삭제된 데이터는 복구할 수 없습니다.')) {
		          $.ajax({
		              url: "/admin/review/delete",
		              type: "POST",
		              data: { reviewId: reviewId },
		              success: function (result) {
		                  if (result.success) {
		                      alert("삭제 성공");
		                      location.reload();
		                  } else {
		                      alert("삭제 실패");
		                  }
		              },
		              error: function () {
		                  alert("서버 오류");
		              }
		      });
		    }
	    }
</script>

</body>
</html>
                    