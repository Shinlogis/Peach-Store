<%@ page contentType="text/html; charset=UTF-8"%>
<nav class="main-header navbar navbar-expand navbar-white navbar-light">

  <!-- Left navbar links -->
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" data-widget="pushmenu" href="#" role="button">
        <i class="fas fa-bars"></i>
      </a>
    </li>
    <li class="nav-item d-none d-sm-inline-block">
      <a href="/admin/main" class="nav-link">Home</a>
    </li>
    <li class="nav-item d-none d-sm-inline-block">
      <a href="/shop/main" class="nav-link" target="_blank">ShoppingMall Home</a>
    </li>
  </ul>

  <!-- Right navbar links -->
  <ul class="navbar-nav ml-auto">

    <!-- Navbar Search -->
    <li class="nav-item">
      <a class="nav-link" data-widget="navbar-search" href="#" role="button">
        <i class="fas fa-search"></i>
      </a>
      <div class="navbar-search-block">
        <form class="form-inline">
          <div class="input-group input-group-sm">
            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
              <button class="btn btn-navbar" type="submit">
                <i class="fas fa-search"></i>
              </button>
              <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
        </form>
      </div>
    </li>
	
	<%
	    Object admin = session.getAttribute("admin");
	%>
	<li class="nav-item">
	  <% if (admin == null) { %>
	    <a class="nav-link" href="/admin/user/loginform" role="button">
	      <i class="fas fa-sign-in-alt"></i> 로그인
	    </a>
	  <% } else { %>
	    <a class="nav-link" href="/admin/user/logout" role="button">
	      <i class="fas fa-sign-out-alt"></i> 로그아웃
	    </a>
	  <% } %>
	</li>

  </ul>
</nav>
