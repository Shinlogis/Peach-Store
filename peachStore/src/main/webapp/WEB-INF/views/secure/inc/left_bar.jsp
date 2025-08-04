<%@ page contentType="text/html; charset=UTF-8"%>
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/static/admin/index3.html" class="brand-link">
      <img src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">쇼핑몰 관리자</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="/static/admin/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">사용자명</a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
         
          <!--상품관리 메뉴 시작-->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
               상품관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/product/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>상품목록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/product/registform" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>상품등록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/product/category/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>카테고리 관리</p>
                </a>
              </li>
            </ul>
          </li>
          <!--상품관리 메뉴 끝-->
      
            <!--리뷰관리 메뉴 시작-->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                리뷰관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/review/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>리뷰내역</p>
                </a>
              </li>
            </ul>
          </li>
          <!--리뷰관리 메뉴 끝-->
      
          <!--회원관리 메뉴 시작-->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                회원관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/usergrade/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>멤버십 등급</p>
                </a>
              </li>
            </ul>
          </li>
          <!--회원관리 메뉴 끝-->
      
          <!--고객센터 메뉴 시작-->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
               고객센터
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/inquiry/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>문의관리</p>
                </a>
              </li>
            </ul>
          </li>
          <!--고객센터 메뉴 끝-->
        
      
        
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>