<%@page import="peachstore.domain.ReviewImg"%>
<%@page import="peachstore.domain.Review"%>
<%@page import="peachstore.domain.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user");
	Review review = (Review)request.getAttribute("review");
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
							<input type="hidden" value="<%= review.getReviewId()%>" name="reviewId">
								
								<div class="form-group">
									<label >작성자</label> <input type="text" value="<%=user.getUser_name() %>"
										name="writer" class="form-control" required readonly />
								</div>
								<div class="form-group">
									<div>
									<label >내용</label> 
									<textarea id="summernote" name="content"></textarea>
								</div>
								
								<div class="form-group">
									<div class="custom-file">
										<label for="exampleInputFile">이미지 선택</label> <input type="file" class="form-control"
										id="photo" name="photo" multiple="multiple" required />
									</div>
									
									<br><br>
									<div id="preview" style="width: 100%;">파일 미리보기</div>
									
								</div>
								
								
								<div class="form-group">
									<button type="button" class="btn btn-primary" id="bt_update">리뷰 수정</button>
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
	  const container = document.getElementById("preview");  // 미리보기 컨테이너 미리 선언

	 
	  
	  function update() {
		let formData = new FormData(document.getElementById("form1"));
		
		formData.delete("photo");
		
		for(let i=0; i<selectedFile.length; i++){			
			formData.append("photo", selectedFile[i]);			
		}
		
		console.log("수정 폼데이터 ", formData)
		
		$.ajax({
			url:"/shop/review/update",
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
	//비동기 방식으로, 서버의 이미지를 다운로드 받기 
		function getImgList(dir, filename){
			console.log("넘겨받은 파일명은 ", dir, "/",filename);
			$.ajax({
				url:"/data/"+dir+"/"+filename, 
				type:"GET",

				xhr: function(){
					const xhr = new XMLHttpRequest();
					xhr.responseType="blob"; //blob 형태의 데이터 요청 
					return xhr;
				},
				success:function(result, status, xhr){
					console.log("서버로부터 받은 바이너리 정보는 ",result);
					
					//서버로 부터 전송받은 바이너리 데이터를 이용하여 File 객체로 만들기 
					const file = new File([result], filename, {type: result.type});
					
					selectedFile.push(file);
					
					//생성된 File을 읽어들여, img src속성에 대입!!!
					const reader = new FileReader();
					reader.onload=function(e){
						console.log("읽어들인 정보 ", e);
						
						//container, file, src, width, height
						let inquiryImg = new InquiryImg(document.getElementById("preview"),file, e.target.result, 100,100 );
					}
					reader.readAsDataURL(file);//대상 파일 읽기 
				}
				
			});
		}
	  
	  
  $(()=>{
	$('#summernote').summernote({
		height:300
	});
	$("#summernote").summernote("code","<%= review.getContent() %>")
	
	 //  기존 이미지 출력 - 서버에서 렌더링할 때, 파일명만 배열에 저장하고 InquiryImg 생성
	  
	 <% for(ReviewImg reviewImg : review.getImgList()){%>
		  getImgList("r_<%=review.getReviewId()%>","<%=reviewImg.getFilename()%>");	  
	 <%} %>
	

	$("#photo").change(function(e){
		console.log(e);
		
		let files = e.target.files;
		
		for(let i=0; i<files.length; i++){
			//selectedFile[i] = files[i];
			//파일 추가
			selectedFile.push(files[i]);
		
			const reader = new FileReader();
		
			reader.onload=function(e){	
				console.log("읽은 결과 ", e);
				let inquiryImg = new InquiryImg(document.getElementById("preview"), files[i], e.target.result, 100,100);
			}
		
		
			reader.readAsDataURL(files[i]);
		}
	});
	
	$("#bt_update").click(()=>{
		update();
	});
	
});
  
  
  
  
  
</script>


</body>

</html>