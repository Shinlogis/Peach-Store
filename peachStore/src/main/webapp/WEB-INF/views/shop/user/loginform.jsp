<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="../inc/head_link.jsp" %>
<link rel="stylesheet" href="/static/shop/css/main/login.css">

</head>
<body>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../inc/header.jsp" %>
	<section style="padding: 40px 0px 50px;">
		<div style="text-align:center;">
			<div class="login-title">Peach에 오신것을 환영합니다.</div>
		</div>
		<div class="container" style="text-align:center">
			<form id="form1">
				<h2 style="text-align:center; color:#494949; font-size:24px; font-weight: 600;">Peach Store에 로그인하세요</h2>
				<div class="row">
					<div class="col">
						<input class="a" type="text" name="id" placeholder="Userid" required>
						<input class="a" type="password" name="hashedpassword" placeholder="Password" required>
						<input class="a" type="submit" value="Login" id="bt_login">
					</div>
				</div>
			</form>
		</div>
		
		<!-- 소셜로그인 버튼 -->
		<div class="row">
			<!-- 카카오 소셜 로그인 버튼 -->
			<a href="#" class="social-login-btn" onclick="login('kakao')">
				<img src="/static/shop/img/login/kakaologin.png" alt="카카오 로그인 버튼" />
			</a>
			
			<!-- 네이버 소셜 로그인 버튼 -->
			<a href="#" class="social-login-btn" onclick="login('naver')">
				<img src="/static/shop/img/login/naverlogin.png" alt="네이버 로그인 버튼" />
			</a>
	
			<!-- 구글 소셜 로그인 버튼 -->
			<button class="gsi-material-button" onclick="login('google')">
				<div class="gsi-material-button-state"></div>
				<div class="gsi-material-button-content-wrapper">
					<div class="gsi-material-button-icon">
						<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
							<path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
							<path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
							<path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
							<path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
							<path fill="none" d="M0 0h48v48H0z"></path>
						</svg>
					</div>
				<span class="gsi-material-button-contents">로그인</span>
				<span style="display: none;">Sign in with Google</span>
				</div>
			</button>
		</div>
		<!-- 소셜로그인 버튼 끝-->
		
		<div class="login-guide">
			<span>peach계정이 없으십니까?</span>
			<a href="/shop/user/joinform">peach계정 생성</a>
		</div>
		
	</section>
	<script type="text/javascript">
		function login(sns){
			$.ajax({
				url:"/shop/user/"+sns+"/authurl",
				type:"GET",
				success:function(result){
					location.href=result;//동의화면 요청
				}
			})
		}
		function homepageLogin(){
			$("#form1").attr({
				action:"/shop/user/login",
				method:"post"
			})
			$("#form1").submit();
		}

		$(()=>{
			$("#bt_login").click(()=>{
				homepageLogin();
			});
		})
	</script>
</body>
</html>
