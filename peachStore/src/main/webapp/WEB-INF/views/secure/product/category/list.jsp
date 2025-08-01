<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    List<ProductSubcategory> productSubcategories = (List) request.getAttribute("productSubcategories");
    List<ProductTopcategory> productTopcategories = (List) request.getAttribute("productTopcategories");

    String searchKey = (String) request.getAttribute("searchKey"); // 검색어 받아오기
    if (searchKey == null) searchKey = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>제품 카테고리 관리</title>
<%@ include file="../../inc/head_link.jsp"%>
<style>
    /* 상위 카테고리 수정/변경 버튼 크기 맞춤 */
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
    <%@ include file="../../inc/navbar.jsp"%>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <%@ include file="../../inc/left_bar.jsp"%>

    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <!-- Content Header -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">제품 카테고리 목록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">제품관리 &gt; 카테고리 관리</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- 상단 검색 + 상위 카테고리 등록 -->
                <div class="row mb-3">
                    <div class="col-12 d-flex justify-content-between align-items-center">
                        <h5><%= productTopcategories.size() %>개의 결과</h5>
                        <div class="input-group input-group-sm" style="width: 250px;">
                            <input type="text" id="searchKey" name="searchKey" class="form-control" placeholder="Search" value="<%= searchKey %>" />
                            <div class="input-group-append">
                                <button id="bt_search" type="button" class="btn btn-default">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary ml-3" id="bt_regist_top" data-toggle="modal" data-target="#topCategoryModal">상위 카테고리 등록</button>
                    </div>
                </div>

				<!-- 카테고리 리스트 -->
				<div class="card">
				    <div class="card-body p-0">
				        <%
				            for (ProductTopcategory top : productTopcategories) {
				        %>
				        <div class="mt-2">
				            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				                <li class="nav-item">
				                    <div class="d-flex align-items-center justify-content-between nav-link px-3">
				                        <!-- 왼쪽: 상위카테고리 이름 + 활성/비활성 뱃지 -->
				                        <div class="d-flex align-items-center">
				                            <% if (top.getFilename() != null && !top.getFilename().isEmpty()) { %>
				                                <img src="/data/category_<%= top.getProductTopcategoryId() %>/<%= top.getFilename() %>" style="width:150px;" />
				                            <% } %>
				                            <span class="ml-2 font-weight-bold"><%= top.getProductTopcategoryName() %></span>
				                            <span class="ml-2">
				                                <% if (top.isActive()) { %>
				                                    <span class="badge badge-success">활성</span>
				                                <% } else { %>
				                                    <span class="badge badge-secondary">비활성</span>
				                                <% } %>
				                            </span>
				                        </div>
				
				                        <!-- 오른쪽: 관리 드롭다운 + 하위 카테고리 등록 버튼 + 하위목록 펼침 아이콘 -->
				                        <div class="d-flex align-items-center">
				                            <!-- 관리 드롭다운 -->
				                            <div class="dropdown mr-2">
				                                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button"
				                                        id="manageDropdown<%= top.getProductTopcategoryId() %>"
				                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				                                    관리
				                                </button>
				                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="manageDropdown<%= top.getProductTopcategoryId() %>">
				                                    <a class="dropdown-item" href="#"
				                                       data-toggle="modal" data-target="#topCategoryEditModal"
				                                       data-id="<%= top.getProductTopcategoryId() %>"
				                                       data-name="<%= top.getProductTopcategoryName() %>"
				                                       data-image="/data/category_<%= top.getProductTopcategoryId() %>/<%= top.getFilename() %>"
				                                       >수정</a>
				                                    <a class="dropdown-item text-danger" href="#"
				                                       data-toggle="modal" data-target="#topCategoryActModal"
				                                       data-id="<%= top.getProductTopcategoryId() %>"
				                                       data-name="<%= top.getProductTopcategoryName() %>">상태변경</a>
				                                </div>
				                            </div>
				
				                            <!-- 하위 카테고리 등록 버튼 -->
				                            <button type="button" class="btn btn-primary btn-sm mr-3"
				                                    data-toggle="modal" data-target="#subCategoryModal"
				                                    data-topid="<%= top.getProductTopcategoryId() %>"
				                                    data-topname="<%= top.getProductTopcategoryName() %>">
				                                하위 카테고리 등록
				                            </button>
				
				                            <!-- 하위목록 펼침 버튼 -->
				                            <i class="right fas fa-angle-left" style="cursor:pointer;"></i>
				                        </div>
				                    </div>
				
				                    <!-- 하위 카테고리 리스트 (들여쓰기 적용) -->
				                    <ul class="nav nav-treeview pl-5">
				                        <%
				                            for (ProductSubcategory sub : productSubcategories) {
				                                if (sub.getProductTopcategory().getProductTopcategoryId() == top.getProductTopcategoryId()) {
				                        %>
				                        <li class="nav-item d-flex align-items-center justify-content-between px-3">
				                            <div class="d-flex align-items-center">
				                                <i class="far fa-circle nav-icon"></i>
				                                <% if (sub.getFilename() != null && !sub.getFilename().isEmpty()) { %>
				                                    <img src="/data/subcategory_<%= sub.getProductSubcategoryId() %>/<%= sub.getFilename() %>" style="width:150px;" class="ml-2" />
				                                <% } %>
				                                <span class="ml-2"><%= sub.getProductSubcategoryName() %></span>
				                                <span class="ml-2">
				                                    <% if (sub.isActive()) { %>
				                                        <span class="badge badge-success">활성</span>
				                                    <% } else { %>
				                                        <span class="badge badge-secondary">비활성</span>
				                                    <% } %>
				                                </span>
				                            </div>
				                            <div>
				                                <button type="button" class="btn btn-secondary btn-sm"
				                                        data-toggle="modal" data-target="#subCategoryEditModal"
				                                        data-id="<%= sub.getProductSubcategoryId() %>"
				                                        data-name="<%= sub.getProductSubcategoryName() %>">수정</button>
				                                <button type="button" class="btn btn-danger btn-sm"
				                                        data-toggle="modal" data-target="#subCategoryDelModal"
				                                        data-id="<%= sub.getProductSubcategoryId() %>"
				                                        data-name="<%= sub.getProductSubcategoryName() %>">변경</button>
				                            </div>
				                        </li>
				                        <%
				                                }
				                            }
				                        %>
				                    </ul>
				                </li>
				            </ul>
				        </div>
				        <%
				            }
				        %>
				    </div>
				</div>

                <!-- 상위 카테고리 등록 모달 -->
                <div class="modal fade" id="topCategoryModal" tabindex="-1" role="dialog" aria-labelledby="topCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="topCategoryModalLabel">상위 카테고리 등록</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                               <form id="topCategoryForm">
								  <div class="form-group">
								    <label for="topCategoryName">상위 카테고리명</label>
								    <input type="text" class="form-control" id="topCategoryName" name="topCategoryName" placeholder="상위 카테고리명을 입력하세요" />
								
								    <div class="input-group mt-2">
								      <div class="custom-file">
								        <input type="file" class="custom-file-input photo-upload" data-preview-target="#preview_top" id="topCategoryImageInput">
								        <label class="custom-file-label" for="topCategoryImageInput">상위 카테고리 이미지 선택</label>
								      </div>
								    </div>
								
								    <div id="preview_top" class="preview-container mt-3 text-center">
								      <img id="previewImage" src="" alt="미리보기" style="max-width: 50%; height: auto; display: none;" />
								    </div>
								  </div>
								</form>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary" id="submitTopCategory">등록</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 상위 카테고리 수정 모달 -->
                <div class="modal fade" id="topCategoryEditModal" tabindex="-1" role="dialog" aria-labelledby="topCategoryEditModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="topCategoryEditModalLabel">상위 카테고리 수정</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
								<label>현재 상위 카테고리</label>
                                <p id="topCategoryNameLabel" class="font-weight-bold"></p>
                                <div id="preview_top_edit" class="preview-container">
									<img id="previewImage" src="" style="max-width: 50%; height: auto; display: none; display: block; margin: 0 auto;" />
									<p id="noImageText" style="color: gray;">이미지 없음</p>
								</div>
                                <form id="topCategoryEditForm">
                                    <div class="form-group">
                                        <label for="editTopCategoryName">수정할 카테고리명</label>
                                        <input type="text" class="form-control" id="editTopCategoryName" name="productTopcategoryName" placeholder="수정할 카테고리명을 입력하세요" />
                                    	<div class="custom-file">
				                      		<input type="file" class="custom-file-input photo-upload" data-preview-target="#preview_top_edit_image">
				                        	<label class="custom-file-label" for="exampleInputFile">상위 카테고리 이미지 선택</label>
					                    	<div id="preview_top_edit_image" class="preview-container">
					                    	</div>
				                    	</div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="editTopCategory">수정</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 상위 카테고리 상태 변경 모달 -->
                <div class="modal fade" id="topCategoryActModal" tabindex="-1" role="dialog" aria-labelledby="topCategoryActModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="topCategoryActModalLabel">상위 카테고리 상태 변경</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center">
                                <p>다음 상위 카테고리의 상태를 변경합니다.</p>
                                <p id="delTopCategoryName" class="font-weight-bold"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="delTopCategory">변경</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 하위 카테고리 등록 모달 -->
                <div class="modal fade" id="subCategoryModal" tabindex="-1" role="dialog" aria-labelledby="subCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="subCategoryModalLabel">하위 카테고리 등록</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="subCategoryForm">
                                    <input type="hidden" id="subTopCategoryId" name="subTopCategoryId" />
                                    <div class="form-group">
                                        <label for="subCategoryName">하위 카테고리명</label>
                                        <input type="text" class="form-control" id="subCategoryName" name="subCategoryName" placeholder="카테고리명을 입력하세요" />
                                        <div class="input-group">
					                      <div class="custom-file">
					                        <input type="file" class="custom-file-input photo-upload" data-preview-target="#preview_sub">
					                        <label class="custom-file-label" for="exampleInputFile">하위 카테고리 이미지 선택</label>
					                      </div>					                     
					                    </div>
					                    <div id="preview_sub" class="preview-container"></div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary" id="submitSubCategory">등록</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 하위 카테고리 수정 모달 -->
                <div class="modal fade" id="subCategoryEditModal" tabindex="-1" role="dialog" aria-labelledby="subCategoryEditModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="subCategoryEditModalLabel">하위 카테고리 수정</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="subCategoryEditForm">
                                    <input type="hidden" id="editSubCategoryId" name="productSubcategoryId" />
                                    <div class="form-group">
                                        <label>현재 하위 카테고리명</label>
                                        <p id="subCategoryNameLabel" class="font-weight-bold"></p>
                                    </div>
                                    <div class="form-group">
                                        <label for="editSubCategoryName">수정할 카테고리명</label>
                                        <input type="text" class="form-control" id="editSubCategoryName" name="productSubcategoryId" placeholder="수정할 카테고리명을 입력하세요" />
                                        <div class="custom-file">
				                      		<input type="file" class="custom-file-input photo-upload" data-preview-target="#preview_sub_edit_image">
				                        	<label class="custom-file-label" for="exampleInputFile">하위 카테고리 이미지 선택</label>
					                    	<div id="preview_sub_edit_image" class="preview-container">
					                    	</div>
				                    	</div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="editSubCategory">수정</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 하위 카테고리 상태 변경 모달 -->
                <div class="modal fade" id="subCategoryDelModal" tabindex="-1" role="dialog" aria-labelledby="subCategoryDelModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="subCategoryDelModalLabel">하위 카테고리 상태변경</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center">
                                <p>다음 하위 카테고리 상태를 변경합니다.</p>
                                <p id="delSubCategoryName" class="font-weight-bold"></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="delSubCategory">변경</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@ include file="../../inc/footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@ include file="../../inc/footer_link.jsp"%>

<script src="/static/admin/custom/ProductImg.js"></script>
<script>
    // 검색 버튼 클릭
    $("#bt_search").click(() => {
        let searchKey = $("#searchKey").val().trim();
        location.href = "/admin/product/category/list?searchKey=" + encodeURIComponent(searchKey);
    });
    
 	// 선택된 파일들
    let selectedFiles = {};

    // 상위 카테고리 등록
    $("#submitTopCategory").click(() => {
        let categoryName = $("#topCategoryName").val().trim();
        if (!categoryName) {
            alert("카테고리명을 입력하세요.");
            return;
        }
        
        // 폼에 업로드한 이미지
		let formData = new FormData(document.getElementById("topCategoryForm"));
		
		// 기존의 photo 대신, selectedFile 배열로 대체
		formData.delete("photo");
		let files = selectedFiles["#preview_top"];
		for (let i = 0; i < files.length; i++) {
		    formData.append("photo", files[i]);
		}
		// 이름 직접 설정 (formData에 직접 넣거나, input에 넣어두거나)
	    formData.set("productTopcategoryName", categoryName);
		
        $.ajax({
            url: "/admin/product/topcategory/regist",
            type: "POST",
            data: formData,
           	processData: false, // form을 이루는 데이터들이 문자열로 변환되지 않도록 (현재 바이너리 파일이 들어있음)
   			contentType: false, // 브라우저가 자동으로 contentType을 설정하지 않도록 
            success: function (result) {
                if (result === "success") {
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
    
    
 	// 파일 선택 이벤트 통합 처리
    $(".photo-upload").change(function (e) {
        let files = e.target.files;
        let previewId = $(this).data("preview-target");
        let $preview = $(previewId);
        let fieldKey = previewId;

        selectedFiles[fieldKey] = []; // 기존 파일 초기화
        $preview.empty(); // 기존 미리보기 이미지 제거

        for (let i = 0; i < files.length; i++) {
            selectedFiles[fieldKey].push(files[i]);

            const reader = new FileReader();
            reader.onload = function (e) {
                new ProductImg($preview[0], files[i], e.target.result, 100, 100);
            };
            reader.readAsDataURL(files[i]);
        }
    });

    // 상위 카테고리 수정 모달 오픈 시 데이터 셋팅
    $("#topCategoryEditModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let id = button.data("id");
        let name = button.data("name");
        let image = button.data("image");
        let modal = $(this);
        if (image) {
            modal.find("#previewImage").attr("src", image).show();
            modal.find("#noImageText").hide();
        } else {
            modal.find("#previewImage").hide();
            modal.find("#noImageText").show();
        }
        modal.data("id", id);
        modal.find("#topCategoryNameLabel").text(name);
        modal.find("#editTopCategoryName").val(name);
        modal.find("#preview_top_edit").val(image);
    });

    // 상위 카테고리 수정
    $("#editTopCategory").click(() => {
    	let modal = $("#topCategoryEditModal");
    	
    	// 폼에 업로드한 이미지
		let formData = new FormData(document.getElementById("topCategoryEditForm"));
		
		// 기존의 photo 대신, selectedFile 배열로 대체
		formData.delete("photo");
		let files = selectedFiles["#preview_top_edit_image"];
		for (let i = 0; i < files.length; i++) {
		    formData.append("photo", files[i]);
		}
		// 나머지 데이터 설정
	    formData.set("productTopcategoryId", $("#topCategoryEditModal").data("id"));
    	       
        $.ajax({
            url: "/admin/product/topcategory/update",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false, 
            success: function (result) {
            	if (result.success) {
                    alert("수정 성공");
                    modal.modal('hide');
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

    // 상위 카테고리 상태변경 모달 오픈 시 데이터 셋팅
    $("#topCategoryActModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let id = button.data("id");
        let name = button.data("name");
        $(this).data("id", id);
        $(this).find("#delTopCategoryName").text(name);
    });

    // 상위 카테고리 상태변경
    $("#delTopCategory").click(() => {
        let id = $("#topCategoryActModal").data("id");
        $.ajax({
            url: "/admin/product/topcategory/deactivate",
            type: "POST",
            data: { productTopcategoryId: id },
            success: function (result) {
                if (result === "success") {
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
        $("#topCategoryActModal").modal('hide');
    });

    // 하위 카테고리 등록 모달 오픈 시 topCategoryId 세팅
    $("#subCategoryModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let topId = button.data("topid");
        let topName = button.data("topname");
        $("#subTopCategoryId").val(topId);
    });
	
    // 하위 카테고리 등록
    $("#submitSubCategory").click(() => {
        let name = $("#subCategoryName").val().trim();
        let topId = $("#subTopCategoryId").val();
        if (!name) {
            alert("카테고리명을 입력하세요.");
            return;
        }
        
        // 폼에 업로드한 이미지
    	let formData = new FormData(document.getElementById("subCategoryForm"));
    	// 기존의 photo 대신, selectedFile 배열로 대체
    	formData.delete("photo");
    	let files = selectedFiles["#preview_sub"];
    	for (let i = 0; i < files.length; i++) {
    	    formData.append("photo", files[i]);
    	}
    	
    	formData.set("productTopcategoryId", topId);
    	formData.set("productSubcategoryName", name);

        $.ajax({
            url: "/admin/product/subcategory/regist",
            type: "POST",
            data: formData,
            processData: false, 
       		contentType: false, 
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
        $("#subCategoryModal").modal('hide');
        $("#subCategoryForm")[0].reset();
    });

    // 하위 카테고리 수정 모달 오픈 시 데이터 셋팅
    $("#subCategoryEditModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let id = button.data("id");
        let name = button.data("name");
        let image = button.data("image");
        
        $(this).data("id", id);
        $(this).find("#editSubCategoryId").val(id);
        $(this).find("#subCategoryNameLabel").text(name);
        $(this).find("#editSubCategoryName").val(name);
    });

    // 하위 카테고리 수정
    $("#editSubCategory").click(() => {
    	let modal = $("#subCategoryEditModal");
    	
    	let formData = new FormData(document.getElementById("topCategoryEditForm"));
    	
    	formData.delete("photo");
		let files = selectedFiles["#preview_sub_edit_image"];
		for (let i = 0; i < files.length; i++) {
		    formData.append("photo", files[i]);
		}
		// 나머지 데이터 설정
	    formData.set("productSubcategoryId", $("#subCategoryEditModal").data("id"));
	    formData.set("productSubcategoryName", $("#editSubCategoryName").val());
	    
        $.ajax({
            url: "/admin/product/subcategory/update",
            type: "POST",
            data: formData,
            processData: false, 
       		contentType: false, 
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
        $("#subCategoryEditModal").modal('hide');
    });

    // 하위 카테고리 변경 모달 오픈 시 데이터 셋팅
    $("#subCategoryDelModal").on("show.bs.modal", function (e) {
        let button = $(e.relatedTarget);
        let id = button.data("id");
        let name = button.data("name");
        $(this).data("id", id);
        $(this).find("#delSubCategoryName").text(name);
    });

    // 하위 카테고리 변경
    $("#delSubCategory").click(() => {
        let id = $("#subCategoryDelModal").data("id");
        $.ajax({
            url: "/admin/product/subcategory/deactive",
            type: "POST",
            data: { productSubcategoryId: id },
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
        $("#subCategoryDelModal").modal('hide');
    });
</script>
</body>
</html>
                    