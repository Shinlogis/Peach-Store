<%@page import="java.net.URLEncoder"%>
<%@page import="peachstore.domain.Inquiry"%>
<%@page import="peachstore.util.Paging"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<Inquiry> inquiries = (List) request.getAttribute("inquiries");
	Paging paging = (Paging) request.getAttribute("paging");
	int firstPage = paging.getFirstPage();
	int lastPage = paging.getLastPage();
	int currentPage = paging.getCurrentPage();
	int totalPage = paging.getTotalPage();
	
	String searchKey = request.getParameter("searchKey") != null ? request.getParameter("searchKey") : "";
	String searchCondition = request.getParameter("searchCondition") != null
			? request.getParameter("searchCondition")
			: "userId";
	String filterNoAnswer = request.getParameter("filterNoAnswer") != null ? request.getParameter("filterNoAnswer") : "";
	String startDate = request.getParameter("startDate") != null ? request.getParameter("startDate") : "";
	String endDate = request.getParameter("endDate") != null ? request.getParameter("endDate") : "";
	String baseParams = "&searchCondition=" + URLEncoder.encode(searchCondition, "UTF-8") 
			+ "&searchKey=" + URLEncoder.encode(searchKey, "UTF-8") 
			+ (filterNoAnswer.equals("true") ? "&filterNoAnswer=true" : "") 
            + (!startDate.isEmpty() ? "&startDate=" + URLEncoder.encode(startDate, "UTF-8") : "") 
            + (!endDate.isEmpty() ? "&endDate=" + URLEncoder.encode(endDate, "UTF-8") : "");

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
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake"
				src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo"
				height="60" width="60" />
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
							<h1 class="m-0">문의관리</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">고객센터>문의관리</li>
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

					<!-- 문의 목록 -->
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header d-flex align-items-center">
									<h3 class="card-title mb-0"><%=inquiries.size()%>개의 결과
									</h3>
									<form method="get" action="/admin/inquiry/list"
										class="d-flex align-items-center ml-auto">
										<div class="form-check mb-0 mr-3">
											<input class="form-check-input" type="checkbox"
												id="filterNoAnswer" name="filterNoAnswer" value="true"
												<%=request.getParameter("filterNoAnswer") != null ? "checked" : ""%>
												onchange="this.form.submit();"> <label
												class="form-check-label" for="filterNoAnswer"> 답변대기만
												보기 </label>
										</div>
										
											<!-- 날짜 필터 (시작일 ~ 종료일) -->
										<div class="input-group input-group-sm mr-3" style="width: 350px;">
											<input type="date" name="startDate" class="form-control"
												value="<%= startDate%>">
											<span class="mx-1">~</span>
											<input type="date" name="endDate" class="form-control"
												value="<%= endDate%>">
										</div>

										<div class="input-group input-group-sm" style="width: 300px;">
											<select name="searchCondition" class="form-control"
												style="max-width: 120px;">
												<option value="userId"
													<%="userId".equals(searchCondition) ? "selected" : ""%>>
													고객 ID</option>
												<option value="inquiryText"
													<%="inquiryText".equals(searchCondition) ? "selected" : ""%>>
													문의내용</option>
											</select> <input type="text" name="searchKey" class="form-control"
												placeholder="Search" value="<%=searchKey%>">
											<div class="input-group-append">
												<button type="submit" class="btn btn-default">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</form>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0">
									<table class="table table-hover text-nowrap">
										<thead>
											<tr>
												<th>NO</th>
												<th>문의날짜</th>
												<th>제목</th>
												<th>고객정보</th>
												<th>답변 여부</th>
											</tr>
										</thead>
										<tbody>
											<%
											int curPos = paging.getCurPos();
											int num = paging.getNum();

											for (int i = 0; i < paging.getPageSize(); i++) {
												if (num < 1)
													break;
												Inquiry inquiry = inquiries.get(curPos++);
												boolean hasAnswer = (inquiry.getAdmin() != null);
											%>
											<!-- 메인 줄 -->
											<tr class="inquiry-row" data-toggle="collapse"
												data-target="#detailRow<%=inquiry.getInquiry_id()%>"
												style="cursor: pointer;">
												<td><%=num--%></td>
												<td><%=inquiry.getCreated_at()%></td>
												<td><%=inquiry.getTitle()%></td>
												<td><%=inquiry.getUser().getUser_name()%><br> <span
													style="color: gray;"><%=inquiry.getUser().getId()%></span><br>
													<%=inquiry.getUser().getUser_grade().getUserGradeName()%></td>
												<td><span
													class="badge <%=hasAnswer ? "badge-success" : "badge-warning"%>">
														<%=hasAnswer ? "답변완료" : "답변대기"%>
												</span></td>
											</tr>

											<tr id="detailRow<%=inquiry.getInquiry_id()%>"
												class="collapse bg-light">
												<td colspan="5">
													<div class="p-3 border rounded shadow-sm">
														<h6 class="font-weight-bold mb-2 text-primary">문의 내용</h6>
														<div class="mb-3" style="white-space: pre-wrap;"><%=inquiry.getInquiry_text()%></div>
														<%
														if (hasAnswer) {
														%>
														<h6 class="font-weight-bold mb-2 text-success">답변</h6>
														<ul class="list-unstyled mb-0">
															<li><strong>답변자:</strong> <%=inquiry.getAdmin().getAdminName()%></li>
															<li><strong>답변날짜:</strong> <%=inquiry.getAnswered_at()%></li>
														</ul>
														<div class="mt-2" style="white-space: pre-wrap;"><%=inquiry.getAnswer_text()%></div>
														<%
														} else {
														%>
														<div
															class="p-2 mt-3 mb-0 text-muted bg-light border rounded small"
															style="font-size: 0.9rem;">아직 답변이 등록되지 않았습니다.</div>
														<button type="button" class="btn btn-sm btn-primary mt-2"
															onclick="openAnswerModal(
												          <%=inquiry.getInquiry_id()%>, 
												          '<%=inquiry.getTitle().replace("'", "\\'")%>', 
												          '<%=inquiry.getInquiry_text().replace("'", "\\'").replace("\r\n", "\\n")%>',
												          `<%=inquiry.getUser().getUser_name()%>
												           (<%=inquiry.getUser().getId()%>)
												           <%=inquiry.getUser().getUser_grade().getUserGradeName()%>`
												        )">
															답변하기</button>
														<%
														}
														%>
													</div>
												</td>
											</tr>
											<%
											}
											%>
										</tbody>
									</table>

								</div>
								<!-- /.card-body -->
								<div class="card-footer d-flex justify-content-center">
									<ul class="pagination pagination-sm m-0">
										<!-- 이전 페이지 버튼 -->
										<li
											class="page-item <%=(firstPage <= 1 ? "disabled" : "")%>">
											<a class="page-link"
											href="<%=(firstPage > 1) ? ("/admin/inquiry/list?currentPage=" + (firstPage - 1) + baseParams) : "#"%>">&laquo;</a>
										</li>
										<!-- 페이지 번호 목록 -->
										<%
										for (int i = firstPage; i <= lastPage && i <= totalPage; i++) {
										%>
										<li
											class="page-item <%=(i == currentPage ? "active" : "")%>">
											<a class="page-link"
											href="/admin/inquiry/list?currentPage=<%=i%><%=baseParams%>"><%=i%></a>
										</li>
										<%
										}
										%>

										<!-- 다음 페이지 버튼 -->
										<li
											class="page-item <%=(lastPage >= totalPage ? "disabled" : "")%>">
											<a class="page-link"
											href="<%=(lastPage < totalPage) ? ("/admin/inquiry/list?currentPage=" + (lastPage + 1) + baseParams) : "#"%>">&raquo;</a>
										</li>
									</ul>
								</div>

							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.문의 목록 -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->

			<!-- 답변하기 모달 -->
			<div class="modal fade" id="answerModal" tabindex="-1"
				aria-labelledby="answerModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<form id="answerForm">
							<div class="modal-header">
								<h5 class="modal-title" id="answerModalLabel">문의 답변하기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<input type="hidden" id="modalInquiryId" name="inquiryId" /> <input
									type="hidden" id="modalAdminId" name="adminId" />

								<div class="mb-3">
									<label class="form-label"><strong>문의 제목</strong></label>
									<div id="modalTitle" class="border p-2 rounded bg-light"></div>
								</div>

								<div class="mb-3">
									<label class="form-label"><strong>고객정보</strong></label>
									<div id="modalUser" class="border p-2 rounded bg-light"></div>
								</div>

								<div class="mb-3">
									<label class="form-label"><strong>문의 내용</strong></label>
									<div id="modalInquiryText"  style="white-space: pre-wrap; font-size: 20px !important; color: black;">
								</div>

								<div class="mb-3">
									<label for="answerText" class="form-label"><strong>답변
											내용</strong></label>
									<textarea id="answerText" name="answerText"
										class="form-control" rows="6" required></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">닫기</button>
								<button type="submit" class="btn btn-primary">답변 등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>

		</div>
		<!-- /.content-wrapper -->

		<%@ include file="../inc/footer.jsp"%>

	</div>
	<!-- ./wrapper -->

	<%@ include file="../inc/footer_link.jsp"%>

	<script src="/static/admin/custom/ProductImg.js"></script>
	<script>
	  // 모달 띄우기 함수
	  function openAnswerModal(inquiryId, title, inquiryText, user) {
	    // 값 세팅
	    document.getElementById('modalInquiryId').value = inquiryId;
	    document.getElementById('modalTitle').textContent = title;
	    document.getElementById('modalInquiryText').textContent = inquiryText;
	    document.getElementById('modalUser').textContent = user;

	    // 모달 열기 
	    var answerModal = new bootstrap.Modal(document.getElementById('answerModal'));
	    answerModal.show();

	  }
	  
	  // 답변 폼 제출 처리
	  document.getElementById('answerForm').addEventListener('submit', function(e) {
	    e.preventDefault();
	    var inquiryId = document.getElementById('modalInquiryId').value;
	    var adminId = document.getElementById('modalAdminId').value;
	    var answerText = document.getElementById('answerText').value.trim();

	    if (!answerText) {
	      alert('답변 내용을 입력해주세요.');
	      return;
	    }

	    // 답변 등록 요청
	    $.ajax({
	      url: '/admin/inquiry/answer',
	      type: 'POST',
	      data: {
	        inquiry_id: inquiryId,
	        // TODO: 로그인 기능 구현 후 수정 필요
	        admin_id: 1,
	        answer_text: answerText
	      },
	      success: function (result) {
              if (result.success) {
                  alert(result.message);
                  location.reload();
              } else {
            	  alert(result.message);
              }
          },
          error: function () {
              alert("서버 오류");
          }
	    });
	  });
</script>

</body>
</html>
