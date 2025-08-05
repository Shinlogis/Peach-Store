<%@page import="peachstore.domain.ProductCapacity"%>
<%@page import="peachstore.service.product.CapacityServiceImpl"%>
<%@page import="peachstore.domain.Capacity"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.util.Paging"%>
<%@page import="peachstore.domain.Size"%>
<%@page import="peachstore.domain.ProductSize"%>
<%@page import="peachstore.domain.ProductColor"%>
<%@page import="peachstore.domain.Color"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="java.util.List"%>
<%
	List<Product> productList =(List)request.getAttribute("productList");
	Paging paging =(Paging)request.getAttribute("paging");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>PeachStore 관리자</title>
	<%@ include file="../inc/head_link.jsp" %>
	
	<!-- 추가 스타일 -->
	<style>
		.content-wrapper {
			background-color: #f8f9fa;
		}
		
		.product-stats {
			margin-bottom: 20px;
		}
		
		.info-box-icon {
			display: flex;
			align-items: center;
			justify-content: center;
		}
		
		.product-image-container {
			position: relative;
			width: 80px;
			height: 80px;
			border-radius: 12px;
			overflow: hidden;
			box-shadow: 0 2px 8px rgba(0,0,0,0.1);
			background: linear-gradient(45deg, #f8f9fa, #e9ecef);
			display: flex;
			align-items: center;
			justify-content: center;
		}
		
		.product-image-container img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			transition: transform 0.3s ease;
		}
		
		.product-image-container:hover img {
			transform: scale(1.1);
		}
		
		.no-image-placeholder {
			color: #6c757d;
			font-size: 12px;
			text-align: center;
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			height: 100%;
		}
		
		.no-image-placeholder i {
			font-size: 20px;
			margin-bottom: 4px;
			opacity: 0.5;
		}
		
		.product-name-link {
			color: #495057;
			text-decoration: none;
			font-weight: 600;
			transition: color 0.3s ease;
		}
		
		.product-name-link:hover {
			color: #007bff;
			text-decoration: none;
		}
		
		.price-display {
			font-weight: 700;
			font-size: 16px;
			color: #28a745;
		}
		
		.attribute-list {
			color: #495057;
			font-size: 13px;
			line-height: 1.4;
		}
		
		.attribute-item {
			display: inline;
			margin-right: 8px;
		}
		
		.attribute-item:not(:last-child):after {
			content: ",";
			margin-right: 4px;
		}
		
		.category-badge {
			background-color: #e9ecef;
			color: #495057;
			padding: 4px 12px;
			border-radius: 4px;
			font-size: 12px;
			font-weight: 500;
			border: 1px solid #dee2e6;
		}
		
		.btn-action {
			padding: 6px 12px;
			font-size: 12px;
			border-radius: 6px;
			font-weight: 600;
			margin: 0 2px;
			transition: all 0.3s ease;
		}
		
		.btn-action:hover {
			transform: translateY(-1px);
			box-shadow: 0 4px 8px rgba(0,0,0,0.2);
		}
		
		.card {
			border: none;
			box-shadow: 0 0 20px rgba(0,0,0,0.1);
			border-radius: 15px;
			overflow: hidden;
		}
		
		.card-header {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			border: none;
			padding: 20px;
		}
		
		.card-title {
			font-weight: 700;
			font-size: 18px;
			margin: 0;
		}
		
		.search-container {
			position: relative;
		}
		
		.search-container .fas {
			position: absolute;
			right: 15px;
			top: 50%;
			transform: translateY(-50%);
			color: #6c757d;
		}
		
		.search-input {
			border-radius: 25px;
			border: 2px solid rgba(255,255,255,0.3);
			background: rgba(255,255,255,0.2);
			color: white;
			padding-right: 45px;
		}
		
		.search-input::placeholder {
			color: rgba(255,255,255,0.8);
		}
		
		.search-input:focus {
			background: rgba(255,255,255,0.3);
			border-color: rgba(255,255,255,0.5);
			color: white;
			box-shadow: 0 0 0 0.2rem rgba(255,255,255,0.25);
		}
		
		.table {
			background: white;
		}
		
		.table thead th {
			background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
			border: none;
			font-weight: 700;
			color: #495057;
			padding: 15px 12px;
			font-size: 14px;
		}
		
		.table tbody tr {
			transition: all 0.3s ease;
			border: none;
		}
		
		.table tbody tr:hover {
			background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 50%, #f8f9fa 100%);
			transform: translateY(-1px);
			box-shadow: 0 4px 12px rgba(0,0,0,0.1);
		}
		
		.table tbody td {
			padding: 15px 12px;
			vertical-align: middle;
			border: none;
			border-bottom: 1px solid #f1f3f4;
		}
		
		.pagination {
			margin: 0;
		}
		
		.page-link {
			border: none;
			color: #6c757d;
			font-weight: 600;
			margin: 0 2px;
			border-radius: 8px;
			transition: all 0.3s ease;
		}
		
		.page-link:hover {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			transform: translateY(-1px);
		}
		
		.page-item.active .page-link {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			border: none;
		}
		
		.empty-state {
			text-align: center;
			padding: 60px 20px;
			color: #6c757d;
		}
		
		.empty-state i {
			font-size: 4rem;
			margin-bottom: 20px;
			opacity: 0.5;
		}
		
		.empty-state h4 {
			font-weight: 600;
			margin-bottom: 10px;
		}
		
		@media (max-width: 768px) {
			.info-box {
				margin-bottom: 15px;
			}
			
			.product-image-container {
				width: 60px;
				height: 60px;
			}
			
			.table-responsive {
				font-size: 13px;
			}
			
			.attribute-list {
				max-width: 150px;
			}
			
			.btn-action {
				padding: 4px 8px;
				font-size: 11px;
			}
			
			.attribute-list {
				font-size: 12px;
			}
		}
		
		/* 애니메이션 효과 */
		@keyframes fadeInUp {
			from {
				opacity: 0;
				transform: translateY(20px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
		
		.table tbody tr {
			animation: fadeInUp 0.5s ease forwards;
		}
		
		.info-box {
			animation: fadeInUp 0.5s ease forwards;
		}
		
		.card {
			animation: fadeInUp 0.6s ease forwards;
		}
	</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/static/admin/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>

  <!-- Navbar -->
	<%@ include file="../inc/navbar.jsp" %>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
	<%@ include file="../inc/left_bar.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">상품 목록</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">상품관리>상품목록</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->


    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
      
      	<!-- 상품 통계 카드 추가 -->
      	<%
      		int totalProducts = productList != null ? productList.size() : 0;
      		int activeProducts = 0;
      		int lowStockProducts = 0;
      		long totalValue = 0;
      		
      		if (productList != null) {
      			for (Product p : productList) {
      				activeProducts++; // 실제로는 활성 상태 체크 로직 필요
      				totalValue += p.getPrice();
      				// lowStockProducts 로직도 재고 정보에 따라 구현
      			}
      		}
      	%>
      	</div>
      	</section>
      
        <!-- 상품 목록 시작 -->
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                	<i class="fas fa-shopping-bag mr-2"></i>
                	상품 관리 현황
                </h3>

                <div class="card-tools">
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>No</th>
                      <th>이미지</th>
                      <th>카테고리</th>
                      <th>상품명</th>
                      <th>가격</th>
                      <th>색상</th>
                      <th>사이즈</th>
                      <th>용량</th>                      
                      <th>관리</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		int curPos=paging.getCurPos(); 
                  		int num=paging.getNum();
                  		
                  	%>
                  	<% if (productList == null || productList.size() == 0) { %>
					  <tr>
					  	<td colspan="9" class="empty-state">
					  		<i class="fas fa-box-open"></i>
					  		<h4>등록된 상품이 없습니다</h4>
					  		<p>새로운 상품을 등록해보세요</p>
					  	</td>
					  </tr>
					<% } else {
					     for(int i = 0; i < productList.size(); i++) {
					       Product product = productList.get(i);
					%>
					<tr>
					  <td><strong><%= paging.getNum() - i %></strong></td>
					  <td>
					    <div class="product-image-container">
					    <%
					      List<ProductImg> imgs = product.getProductImgs();
					      if (imgs != null && !imgs.isEmpty() && imgs.get(0).getFilename() != null) {
					    %>
					      <img src="/data/product_<%=product.getProductId()%>/<%=imgs.get(0).getFilename()%>" alt="상품이미지">
					    <% } else { %>
					      <div class="no-image-placeholder">
					      	<i class="fas fa-image"></i>
					      	<span>이미지 없음</span>
					      </div>
					    <% } %>
					    </div>
					  </td>
					  <td>
					  	<span class="badge category-badge">
					  		<%=product.getProductSubcategory().getProductSubcategoryName()%>
					  	</span>
					  </td>
					  <td>
					  	<a href="/admin/product/detail?product_id=<%=product.getProductId()%>" class="product-name-link">
					  		<%=product.getProductName()%>
					  	</a>
					  </td>
					  <td>
					  	<span class="price-display"><%=String.format("%,d", product.getPrice())%>원</span>
					  </td>
					  <td>
					    <div class="attribute-list">
					    <%
					      List<ProductColor> colorList = product.getProductColors();
					      for (int j = 0; j < colorList.size(); j++) {
					        Color color = colorList.get(j).getColor();
					    %>
					        <span class="attribute-item"><%=color.getColor_name()%></span>
					    <%
					      }
					    %>
					    </div>
					  </td>
					  <td>
					    <div class="attribute-list">
					    <%
					      List<ProductSize> sizeList = product.getProductSizes();
					      for (int j = 0; j < sizeList.size(); j++) {
					        Size size = sizeList.get(j).getSize();
					    %>
					        <span class="attribute-item"><%=size.getSize_name()%></span>
					    <%
					      }
					    %>
					    </div>
					  </td>
					  <td>
					    <div class="attribute-list">
					    <%
					      List<ProductCapacity> capacityList = product.getProductCapacities();
					      for (int j = 0; j < capacityList.size(); j++) {
					        Capacity capacity = capacityList.get(j).getCapacity();
					    %>
					        <span class="attribute-item"><%=capacity.getCapacity_name()%></span>
					    <%
					      }
					    %>
					    </div>
					  </td>
					  <td>
						<a href="/admin/product/editform?product_id=<%=product.getProductId()%>" class="btn btn-warning btn-action">
							<i class="fas fa-edit mr-1"></i>수정
						</a>
						<button class="btn btn-danger btn-action" onclick="deleteProduct(<%=product.getProductId()%>)">
							<i class="fas fa-trash mr-1"></i>삭제
						</button>
					  </td>
					</tr>
					<%
					 }
					}
					%>
					</tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer d-flex justify-content-center">
  					<ul class="pagination pagination-sm m-0">
				 	<!-- 이전 페이지 버튼 -->
					<li class="page-item">
						<a class="page-link" href="/admin/product/list?currentPage=<%= paging.getFirstPage() - 1 %>">
							<i class="fas fa-chevron-left"></i>
						</a>
					</li>
					
					<!-- 페이지 번호 목록 -->
					<% for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
					     if (i > paging.getTotalPage()) break;
					%>
					  <li class="page-item <%= i == paging.getCurrentPage() ? "active" : "" %>">
					    <a class="page-link" href="/admin/product/list?currentPage=<%= i %>"><%= i %></a>
					  </li>
					<% } %>
					
					<!-- 다음 페이지 버튼 -->
					<li class="page-item">
						<a class="page-link" href="/admin/product/list?currentPage=<%= paging.getLastPage() + 1 %>">
							<i class="fas fa-chevron-right"></i>
						</a>
					</li>
				</ul>
              </div>
            
            </div>
            <!-- /.card -->
          </div>
        </div>
            
        <!-- 상품 목록 끝-->
        
      </div>
      <!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
	<%@ include file="../inc/footer.jsp" %>

  <!-- Control Sidebar -->
	<%//@ include file="../inc/right_bar.jsp" %>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->
	<%@ include file="../inc/footer_link.jsp" %>
	<script src="/static/admin/custom/ProductImg.js"></script>
	<script>
	function printCategory(obj, list){
		let tag="<option value='0'>카테고리 선택</option>";
		
		for(let i=0;i<list.length;i++){
			if(obj=="#topcategory"){
				tag+="<option value='"+list[i].topcategory_id+"'>"+list[i].top_name+"</option>";
			}else if(obj=="#subcategory"){
				tag+="<option value='"+list[i].subcategory_id+"'>"+list[i].sub_name+"</option>";
			}else if(obj=="#color"){
				tag+="<option value='"+list[i].color_id+"'>"+list[i].color_name+"</option>";
			}else if(obj=="#size"){
				tag+="<option value='"+list[i].size_id+"'>"+list[i].size_name+"</option>";
			}
		}
		
		$(obj).html(tag);  // innerHTML=태그 동일
	}
	
	$(function(){
	    // input 입력
	    $('input[name="table_search"]').on('input', function() {
	        const searchTerm = $(this).val().toLowerCase();
	        $('tbody tr').each(function() {
	            const productName = $(this).find('.product-name-link').text().toLowerCase();
	            const category = $(this).find('.category-badge').text().toLowerCase();
	            if (productName.includes(searchTerm) || category.includes(searchTerm)) {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });
	    // 아이콘 클릭
	    $('.search-container .fa-search').on('click', function() {
	        const $input = $(this).siblings('input[name="table_search"]');
	        $input.focus();
	        // 검색어가 있을 때만 검색 동작
	        const searchTerm = $input.val().toLowerCase();
	        $('tbody tr').each(function() {
	            const productName = $(this).find('.product-name-link').text().toLowerCase();
	            const category = $(this).find('.category-badge').text().toLowerCase();
	            if (productName.includes(searchTerm) || category.includes(searchTerm)) {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });
	});

	
	//비동기 방식으로 서버에 요청을 시도하여, 데이터 가져오기 
	function getTopCategory(){
		$.ajax({
			url:"/admin/topcategory/list",
			type:"get",
			success:function(result, status, xhr){ //200번대의 성공 응답 시, 이 함수 실행
				console.log("서버로부터 받은 결과는 ", result);
				//화면에 출력하기 
				printCategory("#topcategory",result);
			},
			error:function(xhr, status, err){
			}
		});
	}
	
	function getSubCategory(topcategory_id){
		$.ajax({
			url :"/admin/subcategory/list?topcategory_id="+topcategory_id,
			type:"get",
			success:function(result, status, xhr){
				console.log(result);
				printCategory("#subcategory",result);
			}
		});
	}
	
	function getColorList(){
		$.ajax({
			url:"/admin/color/list",
			type:"get",
			success:function(result, status, xhr){
				
				console.log("색상은 ",result);
				
				printCategory("#color", result);
			}
		});
	}
	
	function getSizeList(){
		$.ajax({
			url:"/admin/size/list",
			type:"get",
			success:function(result, status, xhr){
				printCategory("#size", result);
			}
		});
	}

	//크롬브라우저에서 지원하는 e.target.files 유사 배열은 읽기전용 이라서, 
	//개발자가 쓰기 가 안되므로, 배열을 하나 선언하여,담아서 처리
	//주의) 아래의 배열은, 개발자가 정의한 배열일 뿐이지, form 태그가 전송할 컴포넌트는 아니므로, 
	//submit 시, selectedFile에 들어있는 파일을 전송할 수는 없다!!!
	//해결책? form태그에 인식을 시켜야 한다.. (javascript로 프로그래밍적 formData 객체를 사용해야 함)
	//HTML 작성된 기존 폼에서 텍스트 입력관련된 컴포넌트는 사용하되, 이미지 업로드 컴포넌트는 재설정해야 함...
	
	let selectedFile=[];
	
	function regist(){
		//기존 폼을 이용하되, file 컴포넌트 파라미터만 새로 교체(selectedFile 배열로 대체)
		//js에서 프로그래밍 적 form 생성 
		let formData = new FormData(document.getElementById("form1"));
		
		//formData 동기/비동기 둘다 지원하지만, 대부분은 비동기방식을 많이 씀 
		//Jquery Ajax 자체에서 formData 를 비동기방식으로 간단하게 사용할 수 있는 코드를 지원 
		//기존 photo 버리고, 우리가 선언한 배열로 대체 
		//formData.append("email", "zino11198@naver.com"); // <input type="text" name="email">
		//formData는 개발자가 명시하지 않아도, 디폴트로 multipart/form-data 가 지정되어 잇음
		
		formData.delete("photo");//기존의 photo 파라미터 제거하기 append의 반대
		
		for(let i=0;i<selectedFile.length;i++){
			formData.append("photo", selectedFile[i]); 
		}
		
		//파일마저도 비동기로 업로드 가능!!!
		$.ajax({
			url:"/admin/product/regist",
			type:"post",
			data:formData,
			processData:false, /*form 이루는 대상으로 , 문자열로 변환되는 것을 방지(바이너리 파일포함때문)*/
			contentType:false, /*브라우저가 자동으로 content-type 을 설정하도록 하는 것 방지*/
			success:function(result, status, xhr){
				alert("업로드 성공");
			},
			error:function(xhr, status, err){
				alert(err);
			}
		});
	}
	
	$(()=>{
	   $('#summernote').summernote({
		height:200,
		placeholder:"상품 상세 설명을 채우세요"
	   });
	   getTopCategory(); //상위 카테고리 가져오기 
	   getColorList(); //색상 목록 가져오기 
	   getSizeList(); //사이즈 목록 가져오기 
	   
	   //상위 카테고리의 값을 변경시, 하위 카테고리 가져오기 
	   $("#topcategory").change(function(){
			getSubCategory($(this).val());
		});
	   
	   
	   //파일 컴포넌트의 값 변경 시 이벤트 연결 
	   $("#photo").change(function(e){
			console.log(e);
			//e.target.files 안에는 브라우저가 읽어들인, 파일의 정보가 배열유사 객체인 FileList에 담겨져 있다.
			
			let files=e.target.files;//배열 유사 객체 얻기
			
			//첨부된 파일 수 만큼 반복
			for(let i=0;i<files.length;i++){
				selectedFile[i]=files[i]; //읽기 전용에 들어있었던 각 file들을,우리만의 배열로 옮기자 
				
				//파일을 읽기위한 스트림 객체 생성 
				const reader = new FileReader();
				
				reader.onload=function(e){ //파일을 스트림으로 읽어들인 정보가 e에 들어있음 
					console.log("읽은 결과 ", e);		
					
					//개발자 정의 클래스 인스턴스 생성 container, src, width, height 
					let productImg = new ProductImg(document.getElementById("preview"), files[i]  ,e.target.result, 100,100);
				}				
				reader.readAsDataURL(files[i]); //지정한 파일을 읽기
			}
	   });
	   
	   //등록버튼 이벤트 연결 
	   $("#bt_regist").click(()=>{		
			regist();
	   });
	   
	   //목록 버튼 이벤트 연결 
	   $("#bt_list").click(()=>{		
			$(location).attr("href", "/admin/product/list");
	   });
	
	function deleteProduct(productId) {
	    Swal.fire({
	        title: '상품 삭제',
	        text: '정말로 이 상품을 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#dc3545',
	        cancelButtonColor: '#6c757d',
	        confirmButtonText: '네, 삭제하겠습니다',
	        cancelButtonText: '취소',
	        reverseButtons: true
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: '/admin/product/delete',
	                type: 'POST',
	                data: { product_id: productId },
	                success: function() {
	                    Swal.fire({
	                        icon: 'success',
	                        title: '삭제 완료',
	                        text: '상품이 성공적으로 삭제되었습니다.',
	                        timer: 2000,
	                        showConfirmButton: false
	                    }).then(() => {
	                        location.reload();
	                    });
	                },
	                error: function(xhr) {
	                    Swal.fire({
	                        icon: 'error',
	                        title: '삭제 실패',
	                        text: '삭제 중 오류가 발생했습니다: ' + xhr.responseText
	                    });
	                }
	            });
	        }
	    });
	}
	
	