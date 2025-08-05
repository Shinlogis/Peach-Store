<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard</title>
	<%@ include file="../inc/head_link.jsp" %>
	
	<!-- 추가된 디자인 스타일 -->
	<style>
    :root {
      --primary-color: #667eea;
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --success-color: #10b981;
      --warning-color: #f59e0b;
      --error-color: #ef4444;
      --text-primary: #1f2937;
      --text-secondary: #6b7280;
      --bg-light: #f8fafc;
      --border-light: #e2e8f0;
      --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%) !important;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif !important;
    }

    .content-wrapper {
      background: transparent !important;
      padding: 2rem 1rem;
      min-height: calc(100vh - 3.5rem);
    }

    .content-header {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      margin-bottom: 2rem;
      box-shadow: var(--shadow-lg);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      position: relative;
    }

    .content-header::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: var(--primary-gradient);
    }

    .content-header h1 {
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      font-weight: 700;
      font-size: 2rem;
      margin: 0;
    }

    .breadcrumb {
      background: transparent !important;
      margin: 0;
      padding: 0;
    }

    .breadcrumb-item + .breadcrumb-item::before {
      content: "→";
      color: var(--primary-color);
      font-weight: 600;
    }

    .card {
      background: rgba(255, 255, 255, 0.95) !important;
      backdrop-filter: blur(20px) !important;
      border: none !important;
      border-radius: 24px !important;
      box-shadow: var(--shadow-lg) !important;
      overflow: hidden;
      position: relative;
      transition: all 0.3s ease;
    }

    .card:hover {
      transform: translateY(-2px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }

    .card-header {
      background: var(--primary-gradient) !important;
      border: none !important;
      padding: 1.5rem 2rem !important;
      position: relative;
      overflow: hidden;
    }

    .card-header::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
      animation: shimmer 3s ease-in-out infinite;
    }

    @keyframes shimmer {
      0%, 100% { transform: rotate(0deg); }
      50% { transform: rotate(180deg); }
    }

    .card-title {
      color: white !important;
      font-weight: 600 !important;
      font-size: 1.25rem !important;
      margin: 0 !important;
      position: relative;
      z-index: 1;
    }

    .card-body {
      padding: 2rem !important;
    }

    .form-group {
      margin-bottom: 2rem !important;
      position: relative;
    }

    .form-group label {
      color: var(--text-primary) !important;
      font-weight: 600 !important;
      font-size: 0.875rem !important;
      margin-bottom: 0.75rem !important;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .form-group label::before {
      content: '';
      width: 4px;
      height: 16px;
      background: var(--primary-gradient);
      border-radius: 2px;
    }

    .form-control {
      background: rgba(255, 255, 255, 0.8) !important;
      border: 2px solid var(--border-light) !important;
      border-radius: 12px !important;
      padding: 0.875rem 1rem !important;
      font-size: 0.95rem !important;
      transition: all 0.3s ease !important;
      backdrop-filter: blur(10px);
    }

    .form-control:focus {
      border-color: var(--primary-color) !important;
      box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1) !important;
      background: white !important;
      transform: translateY(-1px);
    }

    .form-control::placeholder {
      color: var(--text-secondary) !important;
      font-style: italic;
    }

    .row {
      margin-left: -0.75rem !important;
      margin-right: -0.75rem !important;
    }

    .row > [class*="col-"] {
      padding-left: 0.75rem !important;
      padding-right: 0.75rem !important;
    }

    .custom-file {
      position: relative;
      background: linear-gradient(135deg, rgba(245, 158, 11, 0.05) 0%, rgba(217, 119, 6, 0.05) 100%);
      border: 2px dashed var(--warning-color);
      border-radius: 16px;
      padding: 2rem;
      text-align: center;
      transition: all 0.3s ease;
      cursor: pointer;
    }

    .custom-file:hover {
      background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(217, 119, 6, 0.1) 100%);
      border-color: var(--warning-color);
      transform: scale(1.02);
    }

    .custom-file-input {
      position: absolute;
      z-index: 2;
      width: 100%;
      height: 100%;
      margin: 0;
      opacity: 0;
      cursor: pointer;
    }

    .custom-file-label {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1;
      color: var(--warning-color);
      font-weight: 600;
      pointer-events: none;
    }

    .custom-file-label::before {
      content: '📁 ';
      font-size: 1.2rem;
    }

    #preview {
      background: var(--bg-light);
      border-radius: 12px;
      padding: 1rem;
      margin-top: 1rem;
      min-height: 100px;
      border: 1px solid var(--border-light);
      color: var(--text-secondary);
      font-style: italic;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .note-editor {
      border-radius: 12px !important;
      border: 2px solid var(--border-light) !important;
      overflow: hidden;
    }

    .note-toolbar {
      background: var(--bg-light) !important;
      border-bottom: 1px solid var(--border-light) !important;
    }

    .card-footer {
      background: rgba(248, 250, 252, 0.8) !important;
      border: none !important;
      padding: 2rem !important;
      display: flex;
      gap: 1rem;
      justify-content: center;
    }

    .btn {
      border-radius: 12px !important;
      padding: 0.875rem 2rem !important;
      font-weight: 600 !important;
      font-size: 0.95rem !important;
      transition: all 0.3s ease !important;
      border: none !important;
      position: relative;
      overflow: hidden;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
      transition: left 0.5s;
    }

    .btn:hover::before {
      left: 100%;
    }

    .btn-secondary {
      background: var(--primary-gradient) !important;
      color: white !important;
      box-shadow: var(--shadow-md);
    }

    .btn-secondary:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-lg);
    }

    .input-group {
      border-radius: 12px;
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }

    .input-group-text {
      background: var(--primary-color) !important;
      color: white !important;
      border: none !important;
      font-weight: 600;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
      .content-wrapper {
        padding: 1rem 0.5rem;
      }
      
      .card-body {
        padding: 1.5rem !important;
      }
      
      .btn {
        width: 100%;
        margin-bottom: 0.5rem;
      }
      
      .card-footer {
        flex-direction: column;
      }
    }

    /* 커스텀 스크롤바 */
    ::-webkit-scrollbar {
      width: 8px;
    }

    ::-webkit-scrollbar-track {
      background: #f1f5f9;
      border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb {
      background: var(--primary-gradient);
      border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
    }
    
    select.form-control {
	  width: 100%;                /* 칸 전체 채움 */
	  min-width: 160px;
	  max-width: 100%;
	  font-size: 1.08rem;         /* 글씨 크기 키움 */
	  height: 50px;               /* 드롭박스 높이 지정 */
	  line-height: 1.2;
	  padding: 0.2rem 1.2rem;     /* 상하/좌우 여백 */
	  box-sizing: border-box;
	  background: #fff;
	  border: 2px solid var(--border-light, #e2e8f0);
	}
	
	select.form-control:focus {
	  outline: none;
	  border-color: var(--primary-color, #667eea);
	  background: #fff;
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
            <h1 class="m-0">상품 등록</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">상품관리>상품등록</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->


    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
      
            <!-- 상품 등록 폼 시작 -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">상품 등록 폼</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form id="form1">
                <div class="card-body">
                	<!-- 카테고리 영역 시작 -->
	                  <div class="row">
	                    <div class="col-sm-6">
	                      <!-- Select multiple-->
	                      <div class="form-group">
	                        <label>상위 카테고리</label>
	                        <select class="form-control" id="topcategory"></select>
	                      </div>
	                    </div>
	                    <div class="col-sm-6">
	                      <div class="form-group">
	                        <label>하위 카테고리</label>
	                        <select class="form-control" name="productSubcategory.productSubcategoryId" id="subcategory"></select>
	                      </div>
	                    </div>
	                  </div>
                	<!-- 카테고리 영역 끝 -->
                  <div class="form-group">
                    <input type="text" class="form-control" name="productCode" placeholder="상품코드 입력">
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="productName" placeholder="상품명 입력">
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="price" placeholder="가격 입력">
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="introduce" placeholder="간단소개 100자 이하 ">
                  </div>
				   <div class="form-group">
				       <label for="color">색상 선택</label>
                       <select class="form-control" name="color"id="color" multiple="multiple">

                       </select>
	              </div>
				  
				  <div class="form-group">
				  	   <label for="size">사이즈 선택</label>
                       <select class="form-control" name="size" id="size" multiple="multiple">
                       </select>
	              </div>
	              
	               <div class="form-group">
				  	   <label for="size">용량 선택</label>
                       <select class="form-control" name="capacity" id="capacity" multiple="multiple">
                       </select>
	              </div>
	              
                  <div class="form-group">
					<!-- 편집 시작 -->
			      	<textarea id="summernote" name="detail"></textarea>
					<!-- 편집기 끝-->
                  </div>
                  
                  <div class="form-group">
                    <div class="input-group">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" name="photo" id="photo" multiple="multiple">
                        <label class="custom-file-label" for="exampleInputFile">상품 이미지 선택</label>
                      </div>
                      <div class="input-group-append">
                        <span class="input-group-text">Upload</span>
                      </div>
                    </div>
                    <div id="preview" style="width:100%">
                    	미리보기
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                  <button type="button" class="btn btn-secondary" id="bt_regist">상품 등록</button>
                  <button type="button" class="btn btn-secondary" id="bt_list">목록 보기</button>
                </div>
              </form>
            </div>
            <!-- 상품 등록 폼 끝-->
        
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

	let selectedFile=[];
	   
	function printCategory(obj, list){
		let tag="<option value='0'disabled hidden selected>카테고리 선택</option>";
		
		for(let i=0;i<list.length;i++){
			if(obj=="#topcategory"){
				tag += "<option value='" + list[i].productTopcategoryId + "'>" + list[i].productTopcategoryName + "</option>";
			}else if(obj=="#subcategory"){
				tag += "<option value='" + list[i].productSubcategoryId + "'>" + list[i].productSubcategoryName + "</option>";
			}else if(obj=="#color"){
				tag+="<option value='"+list[i].color_id+"'>"+list[i].color_name+"</option>";
			}else if(obj=="#size"){
				tag+="<option value='"+list[i].size_id+"'>"+list[i].size_name+"</option>";
			}else if(obj=="#capacity"){
				tag+="<option value='"+list[i].capacity_id+"'>"+list[i].capacity_name+"</option>";
			}
		}
		
		$(obj).html(tag);  // innerHTML=태그 동일
	}
	
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
			success:function(result, status, xhr){ //200번대의 성공 응답 시, 이 함수 실행
				console.log("서버로부터 받은 결과는 ", result);
				//화면에 출력하기 
				printCategory("#color",result);
			},
			error:function(xhr, status, err){
			}
		});
	}
	
	function getSizeList(){
		$.ajax({
			url:"/admin/size/list",
			type:"get",
			success:function(result, status, xhr){ //200번대의 성공 응답 시, 이 함수 실행
				console.log("서버로부터 받은 결과는 ", result);
				//화면에 출력하기 
				printCategory("#size",result);
			},
			error:function(xhr, status, err){
			}
		});
	}
	
	function getCapacityList(){
		$.ajax({
			url:"/admin/capacity/list",
			type:"get",
			success:function(result, status, xhr){ //200번대의 성공 응답 시, 이 함수 실행
				console.log("서버로부터 받은 결과는 ", result);
				//화면에 출력하기 
				printCategory("#capacity",result);
			},
			error:function(xhr, status, err){
			}
		});
	}
	
	$('#summernote').summernote({
		  height: 200,
		  placeholder: "상품 상세 설명을 채우세요",
		  callbacks: {
		    onImageUpload: function(files) {
		      let data = new FormData();
		      data.append('file', files[0]);
		      $.ajax({
		        url: '/admin/product/uploadImage', // 여기에 백엔드 API 경로!
		        method: 'POST',
		        data: data,
		        contentType: false,
		        processData: false,
		        success: function(url) {
		          $('#summernote').summernote('insertImage', url); // URL을 에디터에 삽입
		        }
		      });
		    }
		  }
		});
	   
	   //상위 카테고리 가져오기 
	   getTopCategory(); //상위 카테고리 가져오기
	   getColorList(); //색상 목록 가져오기
	   getSizeList(); //사이즈 목록 가져오기
	   getCapacityList();
	   
	   //파일 컴포넌트의 값 변경 시 이벤트 연결
	   $("#photo").change(function(e){
		   console.log(e);
		   //e.target.files 안에는 브라우저가 읽어들인, 파일의 정보가 배열유사 객체인 FileList에 담겨져 있다.
		   
		   let files = e.target.files;//배열 유사 객체 접근
		   
		   //첨부된 파일 수 만큼 반복
		   for(let i=0; i<files.length; i++){
			  selectedFile[i] = files[i]; //읽기 전용에 들어있었던 각 file들을, 우리만의 배열로 옮기자
			   
			  //파일을 읽기위한 스트림 객체 생성
			  const reader = new FileReader();
			  reader.onload=function(e){ //파일을 스트림으로 읽어들인 정보가 e에 들어있음
			  	console.log("읽은 결과는 ",e);
			  	
			  	//개발자 정의 클래스 인스턴스 생성
			  	let productImg = new ProductImg(document.getElementById("preview"), files[i],e.target.result, 100, 50);
			  	
			  }
			  reader.readAsDataURL(files[i]); // 지정한 파일 읽기   
			}
	   });
	   
	   function appendCapacityNamesToForm() {
		   // 기존 숨은 필드 제거 (중복 방지)
		   $("input[name='capacityName']").remove();

		   // 선택된 용량 옵션들에서 텍스트(=용량명) 추출해서 숨은 input으로 추가
		   $("#capacity option:selected").each(function() {
		     let capacityName = $(this).text();
		     let hidden = $("<input>")
		       .attr("type", "hidden")
		       .attr("name", "capacityName")
		       .val(capacityName);
		     $("#form1").append(hidden);
		   });
		 }

	   
	   function regist(){
		   const productCode = $("input[name='productCode']").val().trim();
		   const productName = $("input[name='productName']").val().trim();
		   const price = $("input[name='price']").val().trim();
		   const topcategory = $("#topcategory").val(); 
		   const subcategory = $("#subcategory").val(); 
		   const color = $("#color").val();
		   const size = $("#size").val();
		   const capacity = $("#capacity").val();
		   
		   if (!topcategory) {
			     alert("⚠️ 상위 카테고리를 선택해주세요.");
			     return;
		   }
		   if (!subcategory) {
			     alert("⚠️ 하위 카테고리를 선택해주세요.");
			     return;
		   }
		   if (!productName) {
			     alert("⚠️ 상품코드를 입력해주세요.");
			     return;
		   }
		   if (!productName) {
		     alert("⚠️ 상품명을 입력해주세요.");
		     return;
		   }

		   if (!price || isNaN(price)) {
		     alert("⚠️ 가격을 숫자로 입력해주세요.");
		     return;
		   }

		   if (!color || color.length === 0) {
		     alert("⚠️ 색상을 하나 이상 선택해주세요.");
		     return;
		   }

		   if (!size || size.length === 0) {
		     alert("⚠️ 사이즈를 하나 이상 선택해주세요.");
		     return;
		   }
		   
		   if (!capacity || capacity.length === 0) {
			  alert("⚠️ 용량을 하나 이상 선택해주세요.");
			  return;
		   }
		   
		   let formData = new FormData(document.getElementById("form1"));
		   formData.delete("photo");
		   
		   for(let i=0; i<selectedFile.length; i++){
		   	formData.append("photo", selectedFile[i]);
		   }

		   //파일마저도 비동기로 업로드 가능!!
		   $.ajax({
			   url: "/admin/product/regist",
			   type: "post",
			   data: formData,
			   processData: false,
			   contentType: false,
			   success: function (result) {
			       alert("✅ 등록 성공");
			       location.href = "/admin/product/list";
			   },
			   error: function (xhr) {
			       alert("❌ 등록 실패");
			   }
			});
	   }
	   
	   function appendCapacityNamesToForm() {
		    $("input[name='capacityName']").remove(); // 기존 히든 input 삭제

		    $("#capacity option:selected").each(function() {
		        let capacityName = $(this).text();
		        if(capacityName && capacityName !== "카테고리 선택") {   // 빈값, 안내문구 제외
		            let hidden = $("<input>")
		                .attr("type", "hidden")
		                .attr("name", "capacityName")
		                .val(capacityName);
		            $("#form1").append(hidden);
		        }
		    });
		}
	   
	   //상위 카테고리의 값을 변경시, 하위 카테고리 가져오기 
	   $("#topcategory").change(function(){
			getSubCategory($(this).val());
		});
	   
	   //등록버튼 이벤트 연결
	   $("#bt_regist").click(()=>{
		  appendCapacityNamesToForm();
		  regist(); 
	   });
	   
	   //목록 버튼 이벤트 연결
	   $("#bt_list").click(()=>{
		  $(location).attr("href", "/admin/product/list");
	});
	</script>
	
</body>
</html>