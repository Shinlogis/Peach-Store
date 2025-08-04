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
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <%@ include file="../inc/navbar.jsp" %>
  <%@ include file="../inc/left_bar.jsp" %>

  <div class="content-wrapper">
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">상품 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">상품관리 > 상품목록 > 상품상세</li>
            </ol>
          </div>
        </div>
      </div>
    </div>

    <section class="content">
      <div class="container-fluid">
        <div class="card card-primary">
          <div class="card-header">
            <h3 class="card-title">상품 상세</h3>
          </div>
          <form id="form1">
          	<input type="hidden" name="productId" value="<%= product.getProductId() %>">
            <div class="card-body">
              <div class="row">
                <div class="col-sm-6">
                  <div class="form-group">
                    <label>상위 카테고리</label>
                    <select class="form-control" name="productTopcategory_id" id="topcategory"></select>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="form-group">
                    <label>하위 카테고리</label>
                    <select class="form-control" name="productSubcategory_id" id="subcategory"></select>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label>상품코드</label>
                <input type="text" class="form-control" name="productCode" value="<%= product.getProductCode() %>">
              </div>
              <div class="form-group">
                <label>상품명</label>
                <input type="text" class="form-control" name="productName" value="<%= product.getProductName() %>">
              </div>
              <div class="form-group">
                <label>가격</label>
                <input type="text" class="form-control" name="price" value="<%= product.getPrice() %>">
              </div>
              <div class="form-group">
                <label>간단소개</label>
                <input type="text" class="form-control" name="introduce" value="<%= product != null ? product.getIntroduce() : "" %>">
              </div>
              <div class="form-group">
                <label>색상</label>
                <select class="form-control" name="color" id="color" multiple="multiple">
                </select>
              </div>
              <div class="form-group">
                <label>사이즈</label>
                <select class="form-control" name="size" id="size" multiple="multiple">
                </select>
              </div>
              <div class="form-group">
                <label>용량</label>
                <select class="form-control" name="capacity" id="capacity" multiple="multiple">
                </select>
              </div>
              <div class="form-group">
                <textarea id="summernote" name="detail"></textarea>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="custom-file">
                    <input type="file" class="custom-file-input" name="photo" id="photo" multiple="multiple">
                    <label class="custom-file-label">상품 이미지 선택</label>
                  </div>
                  <div class="input-group-append">
                    <span class="input-group-text">Upload</span>
                  </div>
                </div>
                <div id="preview" style="width:100%;background:skyblue">
                  미리보기
                </div>
              </div>
              <div class="form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Check me out</label>
              </div>
            </div>
            <div class="card-footer">
			  <button type="button" class="btn btn-success" id="bt_edit">수정하기</button>
			  <button type="button" class="btn btn-secondary" id="bt_list">목록보기</button>
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

  $("#bt_edit").click(() => edit());
  
  let selectedFile = [];
  let deletedFilenames = [];
  
  $("#photo").change(function(e){
    let files = e.target.files;
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
	        const container = document.getElementById("preview");

	        const wrapper = document.createElement("div");
	        wrapper.style.position = "relative";
	        wrapper.style.display = "inline-block";
	        wrapper.style.margin = "5px";

	        new ProductImg(wrapper, file, e.target.result, 100, 100);

	        const delBtn = document.createElement("button");
	        delBtn.innerText = "X";
	        delBtn.style.position = "absolute";
	        delBtn.style.top = "0";
	        delBtn.style.right = "0";
	        delBtn.style.backgroundColor = "red";
	        delBtn.style.color = "white";
	        delBtn.onclick = () => {
	          wrapper.remove(); // 화면에서 제거
	          deletedFilenames.push(filename); // 삭제 리스트에 추가
	        };

	        wrapper.appendChild(delBtn);
	        container.appendChild(wrapper);
	      };
	      reader.readAsDataURL(file);
	    }
	  });
	}
	
  function edit(){
	  let formData = new FormData(document.getElementById("form1"));

	  formData.delete("photo");
	  for(let i=0; i<selectedFile.length; i++){
	    formData.append("photo", selectedFile[i]);
	  }

	  for (let filename of deletedFilenames) {
	    formData.append("deleteFiles", filename); 
	  }

	  $.ajax({
	    url: "/admin/product/edit",
	    type: "post",
	    data: formData,
	    processData: false,
	    contentType: false,
	    success: function(){
	      alert("수정 성공");
	      location.href = "/admin/product/list";
	    },
	    error: function(err){
	      console.error("❌ 수정 실패", err);
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