<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    Product product = (Product)request.getAttribute("product");

    int topCategoryId = 0;
    int subCategoryId = 0;
    if (product != null &&
        product.getProductSubcategory() != null &&
        product.getProductSubcategory().getProductTopcategory() != null) {
        topCategoryId = product.getProductSubcategory().getProductTopcategory().getProductTopcategoryId();
        subCategoryId = product.getProductSubcategory().getProductSubcategoryId();
    }
    
    // Java를 JSON 문자열로 변환
    ObjectMapper mapper = new ObjectMapper(); // java <> json
    
    int[] colorArray = new int[product.getProductColors().size()];
    for(int i=0; i<colorArray.length; i++){
    	colorArray[i] = product.getProductColors().get(i).getColor().getColor_id();
    }
    String colorJson = mapper.writeValueAsString(colorArray);
 	
    int[] sizeArray = new int[product.getProductSizes().size()];
    for (int i = 0; i < sizeArray.length; i++) {
        sizeArray[i] = product.getProductSizes().get(i).getSize().getSize_id();
    }
    String sizeJson = mapper.writeValueAsString(sizeArray);
    
    int[] capacityArray = new int[product.getProductCapacities().size()];
    for (int i = 0; i < capacityArray.length; i++) {
        capacityArray[i] = product.getProductCapacities().get(i).getCapacity().getCapacity_id();
    }
    String capacityJson = mapper.writeValueAsString(capacityArray);

  	
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard</title>
  <%@ include file="../inc/head_link.jsp" %>
  
  <style>
    /* Enhanced Styling */
    .content-wrapper {
	  background: #fff;      
	  min-height: 100vh;
	}
    
    .enhanced-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      overflow: hidden;
      transition: all 0.3s ease;
    }
    
    .enhanced-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 25px 80px rgba(0, 0, 0, 0.15);
    }
    
    .card-header-enhanced {
      background: linear-gradient(45deg, #667eea, #764ba2);
      color: white;
      padding: 25px 30px;
      border-radius: 20px 20px 0 0;
      position: relative;
      overflow: hidden;
    }
    
    .card-header-enhanced::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
      transition: left 0.5s;
    }
    
    .card-header-enhanced:hover::before {
      left: 100%;
    }
    
    .card-title-enhanced {
      font-size: 1.8rem;
      font-weight: 700;
      margin: 0;
      color: #222 !important;  
 	  text-shadow: none !important; 
    }
    
    .form-group-enhanced {
      margin-bottom: 25px;
      position: relative;
    }
    
    .form-control-enhanced {
	  border: 2px solid #e9ecef;
	  border-radius: 12px;
	  padding: 15px 20px;
	  font-size: 16px;
	  transition: all 0.3s ease;
	  background: rgba(255, 255, 255, 0.9);  /* ← 배경 거의 흰색 */
	  color: #495057; /* ← 글자색 */
	}
    .form-control-enhanced:focus {
      border-color: #667eea;
      box-shadow: 0 0 20px rgba(102, 126, 234, 0.2);
      transform: translateY(-2px);
      background: white;
    }
    
    .label-enhanced {
      font-weight: 600;
      color: #495057;
      margin-bottom: 8px;
      display: block;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    
    .select-enhanced {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
      background-position: right 12px center;
      background-repeat: no-repeat;
      background-size: 16px 12px;
    }
    
    .row-enhanced {
      margin: 0px -15px;
    }
    .form-control-enhanced {
	  min-width: 180px;
	  min-height: 53px;
	}
	    
    .col-enhanced {
      padding: 0 15px;
    }
    
    .preview-container {
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      border: 2px dashed #667eea;
      border-radius: 15px;
      padding: 30px;
      text-align: center;
      margin-top: 15px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }
    
    .preview-container::before {
      content: '🖼️';
      font-size: 3rem;
      display: block;
      margin-bottom: 10px;
      opacity: 0.5;
    }
    
    .preview-container:hover {
      border-color: #764ba2;
      background: linear-gradient(135deg, #667eea20, #764ba220);
    }
    
    .file-input-wrapper {
      position: relative;
      overflow: hidden;
      display: inline-block;
      width: 100%;
      border: 2px solid #e9ecef;
	  border-radius: 12px;
	  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    
    .custom-file-enhanced {
      position: relative;
      border: 2px solid #e9ecef;
      border-radius: 12px;
      background: white;
      transition: all 0.3s ease;
    }
    
    .custom-file-enhanced:hover {
      border-color: #667eea;
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
    }
    
    .btn-enhanced {
      background: linear-gradient(45deg, #667eea, #764ba2);
      border: none;
      color: white;
      padding: 12px 30px;
      border-radius: 25px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 1px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }
    
    .btn-enhanced::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
      transition: left 0.5s;
    }
    
    .btn-enhanced:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
    }
    
    .btn-enhanced:hover::before {
      left: 100%;
    }
    
    .breadcrumb-enhanced {
      color: rgba(255, 255, 255, 0.1);
      background: rgba(255, 255, 255, 0.1);
      border-radius: 20px;
      padding: 10px 20px;
      backdrop-filter: blur(10px);
    }
    
    .breadcrumb-enhanced a {
      color: rgba(255, 255, 255, 0.1);
      text-decoration: none;
      transition: all 0.3s ease;
    }
    
    .breadcrumb-enhanced a:hover {
      color: white;
      text-shadow: 0 0 10px rgba(255,255,255,0.5);
    }
    
    .content-header-enhanced {
      padding: 30px 0;
    }
    
    .page-title {
      color: #222;
      font-size: 2.5rem;
      font-weight: 700;
      ttext-shadow: none;
      margin: 0;
    }
    
    .summernote-container {
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .card-body-enhanced {
      padding: 40px;
    }
    
    .card-footer-enhanced {
      background: rgba(248, 249, 250, 0.5);
      border-top: 1px solid rgba(0,0,0,0.1);
      padding: 25px 40px;
      text-align: center;
    }
    
    .breadcrumb-enhanced,
	.breadcrumb-enhanced a,
	.breadcrumb-enhanced .breadcrumb-item,
	.breadcrumb-enhanced .breadcrumb-item.active {
	  color: #222 !important;
	  font-weight: 600;
	}
	
	.breadcrumb-enhanced a:hover {
	  color: #764ba2 !important;
	}
	    
    /* Animation for form elements */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    .form-group-enhanced {
      animation: fadeInUp 0.6s ease forwards;
    }
    
    .form-group-enhanced:nth-child(even) {
      animation-delay: 0.1s;
    }
    
    .form-group-enhanced:nth-child(odd) {
      animation-delay: 0.2s;
    }
   .preview-container {
	  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
	  border: 2px dashed #667eea;
	  border-radius: 15px;
	  padding: 30px;
	  text-align: left;
	  margin-top: 15px;
	  display: flex;
	  flex-wrap: wrap;
	  gap: 16px;
	  min-height: 220px;
	  align-items: flex-start;
	}
	.preview-container img {
	  width: 180px;
	  height: 180px;
	  object-fit: cover;
	  border-radius: 14px;
	  margin: 0 10px 10px 0;
	  background: #fafafd;
	  border: 2px solid #eee;
	  box-shadow: 0 4px 20px rgba(30, 41, 59, 0.08);
	  transition: transform 0.2s, border-color 0.2s;
	}
	.preview-container img:hover {
	  transform: scale(1.05);
	  border-color: #667eea;
	}
  </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <%@ include file="../inc/navbar.jsp" %>
  <%@ include file="../inc/left_bar.jsp" %>

  <div class="content-wrapper">
    <div class="content-header content-header-enhanced">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="page-title">✨ 상품 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right breadcrumb-enhanced">
              <li class="breadcrumb-item" color="black">🏠 Home</li>
              <li class="breadcrumb-item active">📦 상품관리 > 📋 상품목록 > 🔍 상품상세</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <section class="content">
      <div class="container-fluid">
        <div class="card enhanced-card">
          <div class="card-header card-header-enhanced">
            <h3 class="card-title-enhanced">🛍️ 상품 상세 정보</h3>
          </div>
          <form id="form1">
            <div class="card-body card-body-enhanced">
              <div class="row row-enhanced">
                <div class="col-sm-6 col-enhanced">
                  <div class="form-group form-group-enhanced">
                    <label class="label-enhanced">📂 상위 카테고리</label>
                    <select class="form-control form-control-enhanced select-enhanced" id="topcategory"></select>
                  </div>
                </div>
                <div class="col-sm-6 col-enhanced">
                  <div class="form-group form-group-enhanced">
                    <label class="label-enhanced">📁 하위 카테고리</label>
                    <select class="form-control form-control-enhanced select-enhanced" name="subCategory.subcategory_id" id="subcategory"></select>
                  </div>
                </div>
              </div>

              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">🔢 상품코드</label>
                <input type="text" class="form-control form-control-enhanced" name="product_code" value="<%= product.getProductCode() %>" placeholder="상품 코드를 입력하세요">
              </div>
              
              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">🏷️ 상품명</label>
                <input type="text" class="form-control form-control-enhanced" name="product_name" value="<%= product.getProductName() %>" placeholder="상품명을 입력하세요">
              </div>
              
              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">💰 가격</label>
                <input type="text" class="form-control form-control-enhanced" name="price" value="<%= product.getPrice() %>" placeholder="가격을 입력하세요">
              </div>
              
              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">📝 간단소개</label>
                <input type="text" class="form-control form-control-enhanced" name="introduce" value="<%= product != null ? product.getIntroduce() : "" %>" placeholder="상품 간단 소개를 입력하세요">
              </div>
              
              <div class="row row-enhanced">
                <div class="col-sm-4 col-enhanced">
                  <div class="form-group form-group-enhanced">
                    <label class="label-enhanced">🎨 색상</label>
                    <select class="form-control form-control-enhanced select-enhanced" name="color" id="color" multiple="multiple">
                    </select>
                  </div>
                </div>
                <div class="col-sm-4 col-enhanced">
                  <div class="form-group form-group-enhanced">
                    <label class="label-enhanced">📏 사이즈</label>
                    <select class="form-control form-control-enhanced select-enhanced" name="size" id="size" multiple="multiple">
                    </select>
                  </div>
                </div>
                <div class="col-sm-4 col-enhanced">
                  <div class="form-group form-group-enhanced">
                    <label class="label-enhanced">🥤 용량</label>
                    <select class="form-control form-control-enhanced select-enhanced" name="capacity" id="capacity" multiple="multiple">
                    </select>
                  </div>
                </div>
              </div>
              
              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">📄 상세 설명</label>
                <div class="summernote-container">
                  <textarea id="summernote" name="detail"></textarea>
                </div>
              </div>
              
              <div class="form-group form-group-enhanced">
                <label class="label-enhanced">📸 상품 이미지</label>
                <div id="preview" class="preview-container">
                  <strong>이미지 미리보기</strong>
                  <p style="margin: 10px 0 0 0; color: #6c757d;">이미지를 선택하면 여기에 미리보기가 표시됩니다</p>
                </div>
              </div>
            </div>
            
            <div class="card-footer card-footer-enhanced">
              <button type="button" class="btn btn-enhanced" id="bt_list">📋 목록보기</button>
            </div>
          </form>
        </div>
      </div>
    </section>
  </div>

  <%@ include file="../inc/footer.jsp" %>
</div>
<%@ include file="../inc/footer_link.jsp" %>
<script src="/static/admin/custom/ProductImg.js"></script>

<script>
  console.log("topCategoryId:", <%= topCategoryId %>);
  console.log("selectedSubCategoryId:", <%= subCategoryId %>);
</script>

<script>
  $('#summernote').summernote({
    height: 200,
  });
  $("#summernote").summernote("code", '<%= product != null ? product.getDetail() : "" %>');

  getTopCategory(<%= topCategoryId %>);
  getSubCategory(<%= topCategoryId %>, <%= subCategoryId %>);
  getColorList(<%= colorJson%>);
  getSizeList(<%= sizeJson%>);
  getCapacityList(<%= capacityJson %>);

  <% if (product != null && product.getProductImgs() != null) {
       for(ProductImg productImg : product.getProductImgs()) { %>
         getImgList("product_<%= product.getProductId() %>", "<%= productImg.getFilename() %>");
  <%   }
     } %>

  $("#topcategory").change(function(){
    getSubCategory($(this).val());
  });

  $("#bt_list").click(() => location.href = "/admin/product/list");

  let selectedFile = [];

  $("#photo").change(function(e){
    let files = e.target.files;
    // Clear preview before adding new images
    const preview = document.getElementById("preview");
    preview.innerHTML = '<strong>이미지 미리보기</strong><p style="margin: 10px 0 0 0; color: #6c757d;">선택된 이미지들</p>';
    
    for(let i=0; i<files.length; i++){
      selectedFile[i] = files[i];
      const reader = new FileReader();
      reader.onload = function(e){
        new ProductImg(document.getElementById("preview"), selectedFile[i], e.target.result, 100, 100);
      }
      reader.readAsDataURL(files[i]);
    }
  });

  function getImgList(dir, filename){
	  $.ajax({
	    url: "/data/" + dir + "/" + filename,
	    type: "get",
	    xhr: function(){
	      const xhr = new XMLHttpRequest();
	      xhr.responseType = "blob";
	      return xhr;
	    },
	    success: function(result){
	      const file = new File([result], filename, {type: result.type});
	      const reader = new FileReader();
	      reader.onload = function(e){
	        //console.log("Loaded image src:", e.target.result); // 디버깅용 출력
	        new ProductImg(document.getElementById("preview"), file, e.target.result, 100, 100);
	      }
	      reader.readAsDataURL(file);
	    }
	  });
	}


  function getTopCategory(v){
    $.ajax({
      url: "/admin/topcategory/list",
      type: "get",
      success: function(result){
        printCategory("#topcategory", result, v);
      }
    });
  }

  function getSubCategory(topcategory_id, v){
    $.ajax({
      url: "/admin/subcategory/list?topcategory_id=" + topcategory_id,
      type: "get",
      success: function(result){
        printCategory("#subcategory", result, v);
      }
    });
  }

  function getColorList(v){
    $.ajax({
      url: "/admin/color/list",
      type: "get",
      success: function(result){
        printCategory("#color", result, v);
      }
    });
  }

  function getSizeList(v){
    $.ajax({
      url: "/admin/size/list",
      type: "get",
      success: function(result){
        printCategory("#size", result, v);
      }
    });
  }

  function getCapacityList(v){
	    $.ajax({
	      url: "/admin/capacity/list",
	      type: "get",
	      success: function(result){
	        printCategory("#capacity", result, v);
	      }
	    });
	  }
  function printCategory(obj, list, v){
	console.log(">> render", obj, "target:", v);
    let tag = "<option value='0'>카테고리 선택</option>";
    for(let i=0; i<list.length; i++){
      if(obj === "#topcategory"){
        tag += "<option value='"+list[i].productTopcategoryId+"'>"+list[i].productTopcategoryName+"</option>";
      } else if(obj === "#subcategory"){
        tag += "<option value='"+list[i].productSubcategoryId+"'>"+list[i].productSubcategoryName+"</option>";
      } else if(obj === "#color"){
        tag += "<option value='"+list[i].color_id+"'>"+list[i].color_name+"</option>";
      } else if(obj === "#size"){
        tag += "<option value='"+list[i].size_id+"'>"+list[i].size_name+"</option>";
      } else if(obj === "#capacity"){
        tag += "<option value='"+list[i].capacity_id+"'>"+list[i].capacity_name+"</option>";
      }
    }
    $(obj).html(tag);
    $(obj).val(v);
  }
</script>
</body>
</html>