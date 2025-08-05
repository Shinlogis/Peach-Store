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
<title>PeachStore | 제품 카테고리 관리</title>
<%@ include file="../../inc/head_link.jsp"%>
<style>
    .stats-bar {
        display: flex;
        justify-content: center;
        gap: 25px;
        margin-bottom: 30px;
    }

    .stat-item {
        background: white;
        padding: 25px 35px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        text-align: center;
        min-width: 160px;
        border-left: 5px solid #007bff;
        transition: all 0.3s;
    }

    .stat-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
    }

    .stat-number {
        font-size: 32px;
        font-weight: 700;
        color: #007bff;
        display: block;
        margin-bottom: 10px;
    }

    .stat-label {
        font-size: 15px;
        color: #666;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .stat-item.active .stat-number {
        color: #28a745;
    }

    .stat-item.active {
        border-left-color: #28a745;
    }

    .stat-item.inactive .stat-number {
        color: #dc3545;
    }

    .stat-item.inactive {
        border-left-color: #dc3545;
    }

    .action-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding: 0 5px;
    }

    .search-box {
        position: relative;
        max-width: 400px;
    }

    .search-input {
        width: 100%;
        padding: 15px 20px;
        padding-left: 50px;
        border: 2px solid #e1e5e9;
        border-radius: 12px;
        font-size: 16px;
        background: white;
        transition: all 0.3s;
    }

    .search-input:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .search-icon {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: #999;
        font-size: 18px;
    }

    .add-btn {
        padding: 15px 30px;
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .add-btn:hover {
        background: linear-gradient(135deg, #0056b3, #004085);
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        color: white;
        text-decoration: none;
    }

    .category-container {
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        margin-bottom: 20px;
    }

    .category-header {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        color: white;
        padding: 25px;
        text-align: center;
    }

    .category-header h3 {
        font-size: 22px;
        font-weight: 600;
        margin: 0;
    }

    .top-category-item {
        background: white;
        border-bottom: 1px solid #f1f3f4;
        transition: all 0.3s;
    }

    .top-category-item:hover {
        background: #f8f9ff;
    }

    .top-category-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 25px;
    }

    .category-info {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .category-image {
        width: 80px;
        height: 80px;
        border-radius: 12px;
        object-fit: cover;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .category-details h4 {
        font-size: 20px;
        font-weight: 600;
        color: #333;
        margin: 0 0 8px 0;
    }

    .status-badge {
        display: inline-block;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .status-active {
        background: #d4edda;
        color: #155724;
    }

    .status-inactive {
        background: #f8d7da;
        color: #721c24;
    }

    .category-actions {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .action-btn {
        padding: 12px 20px;
        border: none;
        border-radius: 10px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-manage {
        background: linear-gradient(135deg, #6c757d, #495057);
        color: white;
    }

    .btn-manage:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        color: white;
        text-decoration: none;
    }

    .btn-add-sub {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
    }

    .btn-add-sub:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        color: white;
        text-decoration: none;
    }

    .expand-toggle {
        background: none;
        border: none;
        font-size: 18px;
        color: #666;
        cursor: pointer;
        transition: all 0.3s;
        padding: 8px;
        border-radius: 50%;
    }

    .expand-toggle:hover {
        background: #f8f9fa;
        color: #007bff;
    }

    .expand-toggle.expanded {
        transform: rotate(90deg);
    }

    .sub-categories {
        background: #f8f9fa;
        border-top: 1px solid #e9ecef;
        display: none;
    }

    .sub-categories.show {
        display: block;
    }

    .sub-category-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 20px 40px;
        border-bottom: 1px solid #e9ecef;
        transition: all 0.3s;
    }

    .sub-category-item:hover {
        background: #ffffff;
    }

    .sub-category-item:last-child {
        border-bottom: none;
    }

    .sub-category-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .sub-category-image {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        object-fit: cover;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .sub-category-name {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        margin-right: 12px;
    }

    .sub-category-actions {
        display: flex;
        gap: 10px;
    }

    .btn-edit {
        background: linear-gradient(135deg, #ffc107, #e0a800);
        color: #212529;
    }

    .btn-edit:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
        color: #212529;
        text-decoration: none;
    }

    .btn-delete {
        background: linear-gradient(135deg, #dc3545, #c82333);
        color: white;
    }

    .btn-delete:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        color: white;
        text-decoration: none;
    }

    .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: #666;
    }

    .empty-state .empty-icon {
        font-size: 72px;
        margin-bottom: 20px;
        opacity: 0.6;
    }

    .empty-state h3 {
        font-size: 24px;
        color: #333;
        margin-bottom: 12px;
        font-weight: 600;
    }

    .empty-state p {
        font-size: 16px;
    }

    .content-header h1 {
        font-size: 32px;
        font-weight: 600;
        color: #333;
    }

    .content-header .breadcrumb-item {
        font-size: 15px;
    }

    .content-wrapper {
        background: #f4f6f9;
    }

    .container-fluid {
        padding: 0 25px;
    }

    .dropdown-menu {
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        border: none;
    }

    .dropdown-item {
        padding: 12px 20px;
        font-weight: 500;
        transition: all 0.3s;
    }

    .dropdown-item:hover {
        background: #f8f9ff;
        color: #007bff;
    }

    @media (max-width: 768px) {
        .stats-bar {
            flex-wrap: wrap;
            gap: 15px;
            justify-content: space-around;
        }

        .stat-item {
            min-width: 140px;
            padding: 20px 25px;
        }

        .action-bar {
            flex-direction: column;
            gap: 20px;
            align-items: stretch;
        }

        .search-box {
            max-width: 100%;
        }

        .container-fluid {
            padding: 0 15px;
        }

        .top-category-content {
            flex-direction: column;
            gap: 20px;
            align-items: flex-start;
        }

        .category-actions {
            width: 100%;
            justify-content: space-between;
        }

        .sub-category-item {
            flex-direction: column;
            gap: 15px;
            align-items: flex-start;
        }

        .sub-category-actions {
            width: 100%;
            justify-content: center;
        }
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
                        <h1 class="m-0">카테고리 관리</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">상품관리 > 카테고리 관리</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <p class="text-muted" style="font-size: 16px; margin-top: 10px;">
                            상품 카테고리를 체계적으로 관리하고 구조를 설정할 수 있습니다
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <%
                int totalTopCategories = 0;
                int activeTopCategories = 0;
                int inactiveTopCategories = 0;
                int totalSubCategories = 0;
                
                if(productTopcategories != null) {
                    totalTopCategories = productTopcategories.size();
                    for(ProductTopcategory top : productTopcategories) {
                        if(top.isActive()) {
                            activeTopCategories++;
                        } else {
                            inactiveTopCategories++;
                        }
                    }
                }
                
                if(productSubcategories != null) {
                    totalSubCategories = productSubcategories.size();
                }
                %>

                <!-- 통계 바 -->
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number"><%= totalTopCategories %></div>
                        <div class="stat-label">상위 카테고리</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number"><%= totalSubCategories %></div>
                        <div class="stat-label">하위 카테고리</div>
                    </div>
                    <div class="stat-item active">
                        <div class="stat-number"><%= activeTopCategories %></div>
                        <div class="stat-label">활성 상태</div>
                    </div>
                    <div class="stat-item inactive">
                        <div class="stat-number"><%= inactiveTopCategories %></div>
                        <div class="stat-label">비활성 상태</div>
                    </div>
                </div>

                <!-- 액션 바 -->
                <div class="action-bar">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" class="search-input" placeholder="카테고리 검색..." id="searchKey" value="<%= searchKey %>">
                    </div>
                    <button type="button" class="add-btn" data-toggle="modal" data-target="#topCategoryModal">
                        ➕ 상위 카테고리 추가
                    </button>
                </div>

                <!-- 카테고리 컨테이너 -->
                <div class="category-container">
                    <div class="category-header">
                        <h3>카테고리 목록</h3>
                    </div>
                    
                    <% if(productTopcategories != null && !productTopcategories.isEmpty()) { %>
                        <% for (ProductTopcategory top : productTopcategories) { %>
                        <div class="top-category-item">
                            <div class="top-category-content">
                                <div class="category-info">
                                    <% if (top.getFilename() != null && !top.getFilename().isEmpty()) { %>
                                        <img src="/data/category_<%= top.getProductTopcategoryId() %>/<%= top.getFilename() %>" class="category-image" />
                                    <% } else { %>
                                        <div class="category-image" style="background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #999;">
                                            📁
                                        </div>
                                    <% } %>
                                    <div class="category-details">
                                        <h4><%= top.getProductTopcategoryName() %></h4>
                                        <span class="status-badge <%= top.isActive() ? "status-active" : "status-inactive" %>">
                                            <%= top.isActive() ? "✅ 활성" : "❌ 비활성" %>
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="category-actions">
                                    <!-- 관리 드롭다운 -->
                                    <div class="dropdown">
                                        <button class="action-btn btn-manage dropdown-toggle" type="button"
                                                id="manageDropdown<%= top.getProductTopcategoryId() %>"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            ⚙️ 관리
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="manageDropdown<%= top.getProductTopcategoryId() %>">
                                            <a class="dropdown-item" href="#"
                                               data-toggle="modal" data-target="#topCategoryEditModal"
                                               data-id="<%= top.getProductTopcategoryId() %>"
                                               data-name="<%= top.getProductTopcategoryName() %>"
                                               data-image="/data/category_<%= top.getProductTopcategoryId() %>/<%= top.getFilename() %>">
                                                ✏️ 수정
                                            </a>
                                            <a class="dropdown-item text-danger" href="#"
                                               data-toggle="modal" data-target="#topCategoryActModal"
                                               data-id="<%= top.getProductTopcategoryId() %>"
                                               data-name="<%= top.getProductTopcategoryName() %>">
                                                🔄 상태변경
                                            </a>
                                        </div>
                                    </div>

                                    <!-- 하위 카테고리 등록 버튼 -->
                                    <button type="button" class="action-btn btn-add-sub"
                                            data-toggle="modal" data-target="#subCategoryModal"
                                            data-topid="<%= top.getProductTopcategoryId() %>"
                                            data-topname="<%= top.getProductTopcategoryName() %>">
                                        ➕ 하위 추가
                                    </button>

                                    <!-- 펼침 버튼 -->
                                    <button class="expand-toggle" data-target="#subCategories<%= top.getProductTopcategoryId() %>">
                                        ▶️
                                    </button>
                                </div>
                            </div>

                            <!-- 하위 카테고리 리스트 -->
                            <div class="sub-categories" id="subCategories<%= top.getProductTopcategoryId() %>">
                                <%
                                    boolean hasSubCategories = false;
                                    for (ProductSubcategory sub : productSubcategories) {
                                        if (sub.getProductTopcategory().getProductTopcategoryId() == top.getProductTopcategoryId()) {
                                            hasSubCategories = true;
                                %>
                                <div class="sub-category-item">
                                    <div class="sub-category-info">
                                        <% if (sub.getFilename() != null && !sub.getFilename().isEmpty()) { %>
                                            <img src="/data/subcategory_<%= sub.getProductSubcategoryId() %>/<%= sub.getFilename() %>" class="sub-category-image" />
                                        <% } else { %>
                                            <div class="sub-category-image" style="background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #999;">
                                                📄
                                            </div>
                                        <% } %>
                                        <div>
                                            <span class="sub-category-name"><%= sub.getProductSubcategoryName() %></span>
                                            <span class="status-badge <%= sub.isActive() ? "status-active" : "status-inactive" %>">
                                                <%= sub.isActive() ? "✅ 활성" : "❌ 비활성" %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="sub-category-actions">
                                        <button type="button" class="action-btn btn-edit"
                                                data-toggle="modal" data-target="#subCategoryEditModal"
                                                data-id="<%= sub.getProductSubcategoryId() %>"
                                                data-name="<%= sub.getProductSubcategoryName() %>">
                                            ✏️ 수정
                                        </button>
                                        <button type="button" class="action-btn btn-delete"
                                                data-toggle="modal" data-target="#subCategoryDelModal"
                                                data-id="<%= sub.getProductSubcategoryId() %>"
                                                data-name="<%= sub.getProductSubcategoryName() %>">
                                            🔄 변경
                                        </button>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                    if (!hasSubCategories) {
                                %>
                                <div class="sub-category-item" style="justify-content: center; color: #999; font-style: italic;">
                                    등록된 하위 카테고리가 없습니다
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon">🏷️</div>
                            <h3>등록된 카테고리가 없습니다</h3>
                            <p>새로운 상위 카테고리를 추가해보세요</p>
                        </div>
                    <% } %>
                </div>

                <!-- 모달들은 기존과 동일하게 유지 -->
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
    // 검색 기능
    document.getElementById('searchKey').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const categoryItems = document.querySelectorAll('.top-category-item');
        
        categoryItems.forEach(item => {
            const categoryName = item.querySelector('.category-details h4').textContent.toLowerCase();
            const subCategories = item.querySelectorAll('.sub-category-name');
            let hasMatch = categoryName.includes(searchTerm);
            
            // 하위 카테고리에서도 검색
            subCategories.forEach(sub => {
                if (sub.textContent.toLowerCase().includes(searchTerm)) {
                    hasMatch = true;
                }
            });
            
            if (hasMatch) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });

    // 펼침/접기 기능
    document.querySelectorAll('.expand-toggle').forEach(toggle => {
        toggle.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target');
            const target = document.querySelector(targetId);
            
            if (target.classList.contains('show')) {
                target.classList.remove('show');
                this.classList.remove('expanded');
                this.textContent = '▶️';
            } else {
                target.classList.add('show');
                this.classList.add('expanded');
                this.textContent = '🔽';
            }
        });
    });
    
    // 검색 버튼 클릭
    document.getElementById('searchKey').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            let searchKey = this.value.trim();
            location.href = "/admin/product/category/list?searchKey=" + encodeURIComponent(searchKey);
        }
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
		if (files && files.length > 0) {
    	    for (let i = 0; i < files.length; i++) {
    	        formData.append("photo", files[i]);
    	    }
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
    	
    	let formData = new FormData(document.getElementById("subCategoryEditForm"));
    	formData.delete("photo");
    	let files = selectedFiles["#preview_sub_edit_image"];
    	if (files && files.length > 0) {
    	    for (let i = 0; i < files.length; i++) {
    	        formData.append("photo", files[i]);
    	    }
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
        $("#subCategoryDelModal").modal('hide');
    });
</script>
</body>
</html>