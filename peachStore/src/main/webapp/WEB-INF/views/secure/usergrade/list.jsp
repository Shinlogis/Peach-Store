<%@page import="peachstore.domain.UserGrade"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<UserGrade> grades = (List) request.getAttribute("grades");
    String searchKey = (String) request.getAttribute("searchKey"); // 검색어 받아오기
    if (searchKey == null) searchKey = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>사용자 등급 관리</title>
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
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake"
				src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo"
				height="60" width="60">
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
							<h1 class="m-0">등급 목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">회원관리>등급목록</li>
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

					<!-- 등급 목록 -->
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h3 class="card-title"><%=grades.size() %>개의 등급</h3>

									<div class="card-tools">
										
										<div class="input-group input-group-sm" style="width: 150px;">
											<!--  
											<input type="text" name="table_search"
												class="form-control float-right" placeholder="Search">
											-->
											<div class="input-group-append">
												<!-- 
												<button type="submit" class="btn btn-default">
													<i class="fas fa-search"></i>
												</button>
										 		-->
										 		<button type="button" class="btn btn-primary" id="bt_regist_top" data-toggle="modal" data-target="#gradeModal">등록</button>
											</div>
										</div>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0">
									<table class="table table-hover text-nowrap">
										<thead>
											<tr>
												<th>등급명</th>
												<th>할인율</th>
												<th>누적구매기준</th>
												<th>활성화상태</th>
												<th>상태변경</th>
												<th>수정</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
										 	<%
					                            for (UserGrade grade : grades) {
					                        %>
											<tr>
												<td><%= grade.getUserGradeName()%></td>
												<td><%= grade.getDiscountRate()%></td>
												<td><%= grade.getCriteriaAmount()%></td>
												<td><%= grade.isActive() ? "Y" : "N" %></td>
												<td>
		                                            <button type="button" class="btn btn-warning btn-sm"
		                                                    data-toggle="modal" data-target="#userGradeToggleActModal"
		                                                    data-id="<%= grade.getUserGradeId() %>"
		                                                    data-name="<%= grade.getUserGradeName() %>"
		                                                    data-act="<%= grade.isActive() %>"
		                                                    >
		                                                상태변경
		                                            </button>
	                                            </td>
												<td>
													<button type="button" class="btn btn-secondary btn-sm"
	                                                    data-toggle="modal" data-target="#userGradeEditModal"
	                                                    data-id="<%= grade.getUserGradeId() %>"
	                                                    data-name="<%= grade.getUserGradeName()%>"
	                                                    data-discountRate="<%= grade.getDiscountRateAsDouble() %>"
	                                                    data-criteriaAmount="<%= grade.getCriteriaAmount() %>">
		                                                수정
		                                            </button>
												</td>
												<td>
		                                            <button type="button" class="btn btn-danger btn-sm"
		                                                    data-toggle="modal" data-target="#userGradeDelModal"
		                                                    data-id="<%= grade.getUserGradeId() %>"
		                                                    data-name="<%= grade.getUserGradeName() %>">
		                                                삭제
		                                            </button>
                                            	</td>
											<%} %>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
								<div class="card-footer clearfix">
								</div>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.등급 목록 -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
			<!-- 등급 등록 모달 -->
                <div class="modal fade" id="gradeModal" tabindex="-1" role="dialog" aria-labelledby="gradeModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="gradeModalLabel">등급 등록</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
	                            </div>
	                            <div class="modal-body">
	                                <form id="gradeForm">
					                <div class="card-body">
					                  <div class="form-group">
					                  <label>등급명</label>
					                    <input type="text" class="form-control" name="userGradeName" id="userGradeName" placeholder="등급명 입력">
					                  </div>
					                  <div class="form-group">
					                  <label>할인율</label>
					                    <input type="text" class="form-control" name="discountRate" id="discountRate" placeholder="할인율 입력">
					                  </div>
					                  <div class="form-group">
					                  <label>누적구매기준</label>
					                    <input type="text" class="form-control" name="criteriaAmount" id="criteriaAmount" placeholder="누적구매기준 금액 입력">
					                  </div>
					                </div>
					              </form>
	                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary" id="submitGrade">등록</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 등급 상태변경 모달 -->
                <div class="modal fade" id="userGradeToggleActModal" tabindex="-1" role="dialog" aria-labelledby="userGradeToggleActModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="userGradeToggleActModal">등급 상태 변경</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
	                        </div>
	                        <div class="modal-body">
					         	<p>현재 상태</p>
					         	<p id="toggleTargetName" class="font-weight-bold"></p>
					         	<p id="toggleTargetAct" class="font-weight-bold"></p>
					         	<p id="toggleTarget" class="font-weight-bold"></p>
					        </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="submitGradeActToggle">확인</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 등급 수정 모달 -->
                <div class="modal fade" id="userGradeEditModal" tabindex="-1" role="dialog" aria-labelledby="userGradeEditModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="userGradeEditModalLabel">등급 수정</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <form id="editGradeForm">
				          <div class="form-group">
				            <label>기존 등급</label>
				            <p id="userGradeNameLabel" class="form-control-plaintext font-weight-bold"></p>
				          </div>
				          <div class="form-group">
				            <label for="editUserGradeName">새 등급명</label>
				            <input type="text" class="form-control" id="editUserGradeName" placeholder="새 등급명 입력">
				          </div>
				          <div class="form-group">
				            <label for="editDiscountRate">할인율 (%)</label>
				            <input type="number" class="form-control" id="editDiscountRate" placeholder="할인율 입력">
				          </div>
				          <div class="form-group">
				            <label for="editCriteriaAmount">누적 구매 기준 (원)</label>
				            <input type="number" class="form-control" id="editCriteriaAmount" placeholder="누적 구매 기준 입력">
				          </div>
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" id="submitEditGrade">수정</button>
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				      </div>
				    </div>
				  </div>
				</div>
				
				<!-- 등급 삭제 모달 -->
				<div class="modal fade" id="userGradeDelModal" tabindex="-1" role="dialog" aria-labelledby="userGradeDelModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="userGradeDelModalLabel">등급 삭제</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center">
                                <p>다음 등급을 삭제합니다.</p>
                                <p id="delGradeName" class="font-weight-bold"></p>
                                <p>이 작업은 되돌릴 수 없습니다.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="delUserGrade">삭제</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>

		</div>
		<!-- /.content-wrapper -->
		<%@ include file="../inc/footer.jsp"%>

		<!-- Control Sidebar -->
		<%//@ include file="../inc/right_bar.jsp" %>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<%@ include file="../inc/footer_link.jsp"%>

	<script src="/static/admin/custom/ProductImg.js"></script>
	<script>
	/*
    // 검색 버튼 클릭
    $("#bt_search").click(() => {
        let searchKey = $("#searchKey").val().trim();
        location.href = "/admin/product/category/list?searchKey=" + encodeURIComponent(searchKey);
    });
	*/

    // 등급 등록
    $("#submitGrade").click(() => {
        let userGradeName = $("#userGradeName").val().trim();
        let discountRate = $("#discountRate").val().trim();
        let criteriaAmount = $("#criteriaAmount").val().trim();
        if (!userGradeName) {
            alert("등급명을 입력하세요.");
            return;
        }
        if (!discountRate) {
            alert("할인율을 입력하세요.");
            return;
        }
        if (!criteriaAmount) {
            alert("누적구매기준 금액을 입력하세요.");
            return;
        }
        $.ajax({
            url: "/admin/usergrade/register",
            type: "POST",
            data: { 
            	userGradeName: userGradeName,
            	discountRate: discountRate,
            	criteriaAmount: criteriaAmount
            	},
            success: function (result) {
                if (result.success) {
                    alert("등록 성공");
                    location.reload();
                } else {
                    alert("등록 실패");
                }
            },
            error: function () {
                alert("서버 오류");
            }
        });
        $("#topCategoryModal").modal('hide');
        $("#topCategoryForm")[0].reset();
    });
	
	// 사용자 등급 상태변경 모달 오픈 시 데이터 셋팅
	$("#userGradeToggleActModal").on("show.bs.modal", function (e) {
	    let button = $(e.relatedTarget);
	    let id = button.data("id");
	    let name = button.data("name");
	    let act = button.data("act")?"활성":"비활성";
	    let toggle = button.data("act")?"비활성화하시겠습니까?":"활성화하시겠습니까?";
	    
	    let modal = $(this);
	    modal.data("id", id);
	    modal.find("#toggleTargetName").text(name);
	    modal.find("#toggleTargetAct").text(act);
	    modal.find("#toggleTarget").text(toggle);
	});
	
	// 등급 상태변경 요청
    $("#submitGradeActToggle").click(() => {
    	let modal = $("#userGradeToggleActModal");
    	let id = modal.data("id");
        $.ajax({
            url: "/admin/usergrade/toggleActivation",
            type: "POST",
            data: { 
            	userGradeId: id
            	},
            success: function (result) {
                if (result.success) {
                    alert("상태 변경 성공");
                    location.reload();
                } else {
                    alert("상태 변경 실패");
                }
            },
            error: function () {
                alert("서버 오류");
            }
        });
        $("#topCategoryModal").modal('hide');
        $("#topCategoryForm")[0].reset();
    });

	// 사용자 등급 수정 모달 오픈 시 데이터 셋팅
	$("#userGradeEditModal").on("show.bs.modal", function (e) {
	    let button = $(e.relatedTarget);
	    let id = button.data("id");
	    let name = button.data("name");
	    let discountRate = button.data("discountrate");
	    let criteriaAmount = button.data("criteriaamount");
	    
	    let modal = $(this);
	    modal.data("id", id);
	    modal.find("#userGradeNameLabel").text(name);
	    modal.find("#editUserGradeName").val(name);
	    modal.find("#editDiscountRate").val(discountRate);
	    modal.find("#editCriteriaAmount").val(criteriaAmount);
	});

	// 사용자 등급 수정 요청
	$("#submitEditGrade").click(() => {
	    let modal = $("#userGradeEditModal");
	    let id = modal.data("id");
	    let name = modal.find("#editUserGradeName").val().trim();
	    let discountRate = modal.find("#editDiscountRate").val().trim();
	    let criteriaAmount = modal.find("#editCriteriaAmount").val().trim();

	    if (!name || !discountRate || !criteriaAmount) {
	        alert("모든 항목을 입력해주세요.");
	        return;
	    }

	    $.ajax({
	        url: "/admin/usergrade/update",
	        type: "POST",
	        data: {
	            userGradeId: id,
	            userGradeName: name,
	            discountRate: discountRate,
	            criteriaAmount: criteriaAmount
	        },
	        success: function (result) {
                if (result.success) {
                    alert("수정 성공");
                    location.reload();
                } else {
                    alert("수정 실패");
                }
            },
            error: function () {
                alert("서버 오류");
            }
	    });
	});

    // 상위 카테고리 삭제 모달 오픈 시 데이터 셋팅
    $("#userGradeDelModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let id = button.data("id");
        let name = button.data("name");
        $(this).data("id", id);
        $(this).find("#delGradeName").text(name);
    });

    // 상위 카테고리 삭제
    $("#delUserGrade").click(() => {
        let id = $("#userGradeDelModal").data("id");
        $.ajax({
            url: "/admin/usergrade/delete",
            type: "POST",
            data: { userGradeId: id },
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
        $("#topCategoryDelModal").modal('hide');
    });

</script>
</body>
</html>
