<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User)session.getAttribute("user"); 
List<ProductTopcategory> topList =(List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>
<%@ include file="../inc/head_link.jsp" %>


<!-- Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css" rel="stylesheet">


<style type="text/css">
.regist_content{
	width: 1000px;
	margin: auto;
	margin-top: 70px;

}
.custom-file{
	margin-top: 10px;
}
</style>


</head>

<body>
    <!-- Page Preloder -->
<%@ include file="../inc/preloader.jsp" %>
    <!-- Offcanvas Menu Begin -->
<%@ include file="../inc/offcanvas.jsp" %>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
<%@ include file="../inc/header.jsp" %>
    <!-- Header Section End -->
    
    <!-- 글 쓰기 시작 -->
			<section class="regist_content">
			<h3 style=" margin-bottom: 50px; font-weight:bold;">문의하기</h3>
				<!-- Main content -->
				<section class="content">
					<!-- Default box -->
					<div class="card">
						<div class="card-body">
							<form id="form1">
							<input type="hidden" name="user.user_id" value="<%=user.getUser_id() %>">
								<div class="form-group">
									<label >제목</label> <input type="text"
										id="title" name="title" class="form-control" required />
								</div>
								<div class="form-group">
									<label >작성자</label> <input type="text" value="<%=user.getUser_name() %>"
										 class="form-control" required readonly/>
								</div>
								<div class="form-group">
									<div>
									<label >내용</label> 
									<textarea id="summernote" name="inquiry_text"></textarea>
								</div>
								
								<div class="form-group">
									<div class="custom-file">
										<label for="exampleInputFile">이미지 선택</label> <input type="file" class="form-control"
										id="photo" name="photo" multiple="multiple" required />
									</div>
									
									<br><br>
									<div id="preview" style="width: 100%;">파일 미리보기</div>
								</div>
								
								<input type="hidden" name="is_active" value="true">
								
								<div class="form-group">
									<button type="button" class="btn btn-primary" id="bt_regist">문의 등록</button>
								</div>
							</form>
						</div>
					</div>
				</section>
				<!-- 글 쓰기 끝 -->

    

<!-- Footer Section Begin -->
<%@ include file="../inc/footer.jsp" %>
<!-- Footer Section End -->

<!-- Search Begin -->
<%@ include file="../inc/search.jsp" %>
<!-- Search End -->

<!-- Js Plugins -->
<%@ include file="../inc/footer_link.jsp" %>
<script src="/static/shop/custom/InquiryImg.js"></script>


<script>
	  let selectedFile = [];
	  
	  function regist() {
		let formData = new FormData(document.getElementById("form1"));
		
		formData.delete("photo");
		for(let i=0; i<selectedFile.length; i++){
			formData.append("photo", selectedFile[i]);
		}
		
		$.ajax({
			url:"/shop/inquiry/regist",
			type:"post",
			data:formData,
			processData:false, /*form을 이루는 데이터를 대상으로 문자열로 변환되는 것을 방지(바이너리 파일이 포함되어 있어서)*/
			contentType:false, /*브라우저가 자동으로 content-type을 설정하도록 하는 것을 방지*/
			success:function(result, status, xhr){
				alert(result);
			},
			error:function(xhr, status, err){
				alert(err);
			}
		});
		
	}
	  
	  
	  
  $(()=>{
	$('#summernote').summernote({
		height:300
	});
	
	

	$("#photo").change(function(e){
		console.log(e);
		
		let files = e.target.files;
		
		for(let i=0; i<files.length; i++){
			selectedFile[i] = files[i];
		
			const reader = new FileReader();
		
			reader.onload=function(e){	
				console.log("읽은 결과 ", e);
				//file의 url은 e.target.result
				
				let inquiryImg = new InquiryImg(document.getElementById("preview"), selectedFile[i], e.target.result, 100,100);
				
			}
		
		
			reader.readAsDataURL(selectedFile[i]);
		}
	});
	
	$("#bt_regist").click(()=>{
		regist();
	});
	
});
  
  
  
  
  
</script>


</body>

</html>