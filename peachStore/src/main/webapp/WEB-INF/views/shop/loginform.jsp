<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="./inc/head_link.jsp" %>
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
}

* {
  box-sizing: border-box;
}

/* style loginform title */
.login-title{
	font-size: 48px;
    font-weight: 800;
    margin:auto;
    margin-bottom:50px;
}    

/* style the container */
.container {
  position: relative;
  border-radius: 5px;
  padding: 20px 0 30px 0;
  width:35%;
} 

/* style inputs and link buttons */
input,
.btn {
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 4px;
  margin: 5px 0;
  opacity: 0.85;
  display: inline-block;
  font-size: 17px;
  line-height: 20px;
  text-decoration: none; /* remove underline from anchors */
}

input:hover,
.btn:hover {
  opacity: 1;
}

/* add appropriate colors to fb, twitter and google buttons */
.fb {
  background-color: #3B5998;
  color: white;
}

.twitter {
  background-color: #55ACEE;
  color: white;
}

.google {
  background-color: #dd4b39;
  color: white;
}

/* style the submit button */
input[type=submit] {
  color: #494949;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

/* Two-column layout */
.col {
  float: left;
  width: 50%;
  margin: auto;
  padding: 0 50px;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* vertical line */
.vl {
  position: absolute;
  left: 50%;
  transform: translate(-50%);
  border: 2px solid #ddd;
  height: 175px;
}

/* text inside the vertical line */
.vl-innertext {
  position: absolute;
  top: 50%;
  transform: translate(-50%, -50%);
  background-color: #f1f1f1;
  border: 1px solid #ccc;
  border-radius: 50%;
  padding: 8px 10px;
}

/* hide some text on medium and large screens */
.hide-md-lg {
  display: none;
}

/* bottom container */
.bottom-container {
  text-align: center;
  background-color: #666;
  border-radius: 0px 0px 4px 4px;
}

/* Responsive layout - when the screen is less than 650px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 650px) {
  .col {
    width: 100%;
    margin-top: 0;
  }
  /* hide the vertical line */
  .vl {
    display: none;
  }
  /* show the hidden text on small screens */
  .hide-md-lg {
    display: block;
    text-align: center;
  }
}

.a{
	border-radius:8px;
	border: 1px solid #494949;
	color:#494949;
}

.gsi-material-button {
  -moz-user-select: none;
  -webkit-user-select: none;
  -ms-user-select: none;
  -webkit-appearance: none;
  background-color: #f2f2f2;
  background-image: none;
  border: none;
  -webkit-border-radius: 4px;
  border-radius: 4px;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  color: #1f1f1f;
  cursor: pointer;
  font-family: 'Roboto', arial, sans-serif;
  font-size: 14px;
  height: 40px;
  letter-spacing: 0.25px;
  outline: none;
  overflow: hidden;
  padding: 0 12px;
  position: relative;
  text-align: center;
  -webkit-transition: background-color .218s, border-color .218s, box-shadow .218s;
  transition: background-color .218s, border-color .218s, box-shadow .218s;
  vertical-align: middle;
  white-space: nowrap;
  width: auto;
  max-width: 400px;
  min-width: min-content;
}

.gsi-material-button .gsi-material-button-icon {
  height: 20px;
  margin-right: 12px;
  min-width: 20px;
  width: 20px;
}

.gsi-material-button .gsi-material-button-content-wrapper {
  -webkit-align-items: center;
  align-items: center;
  display: flex;
  -webkit-flex-direction: row;
  flex-direction: row;
  -webkit-flex-wrap: nowrap;
  flex-wrap: nowrap;
  height: 100%;
  justify-content: space-between;
  position: relative;
  width: 100%;
}

.gsi-material-button .gsi-material-button-contents {
  -webkit-flex-grow: 1;
  flex-grow: 1;
  font-family: 'Roboto', arial, sans-serif;
  font-weight: 500;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: top;
}

.gsi-material-button .gsi-material-button-state {
  -webkit-transition: opacity .218s;
  transition: opacity .218s;
  bottom: 0;
  left: 0;
  opacity: 0;
  position: absolute;
  right: 0;
  top: 0;
}

.gsi-material-button:disabled {
  cursor: default;
  background-color: #ffffff61;
}

.gsi-material-button:disabled .gsi-material-button-state {
  background-color: #1f1f1f1f;
}

.gsi-material-button:disabled .gsi-material-button-contents {
  opacity: 38%;
}

.gsi-material-button:disabled .gsi-material-button-icon {
  opacity: 38%;
}

.gsi-material-button:not(:disabled):active .gsi-material-button-state, 
.gsi-material-button:not(:disabled):focus .gsi-material-button-state {
  background-color: #001d35;
  opacity: 12%;
}

.gsi-material-button:not(:disabled):hover {
  -webkit-box-shadow: 0 1px 2px 0 rgba(60, 64, 67, .30), 0 1px 3px 1px rgba(60, 64, 67, .15);
  box-shadow: 0 1px 2px 0 rgba(60, 64, 67, .30), 0 1px 3px 1px rgba(60, 64, 67, .15);
}

.gsi-material-button:not(:disabled):hover .gsi-material-button-state {
  background-color: #001d35;
  opacity: 8%;
}
.social-login-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 40px;
  max-width: 400px;
  min-width: min-content;
  padding: 0 12px;
  border: none;
  border-radius: 4px;
  background-color: transparent;
  cursor: pointer;
  box-sizing: border-box;
}

.social-login-btn img {
  height: 100%;
  object-fit: contain;
}

.row {
  display: flex;
  justify-content: center;  /* 가로 방향 가운데 정렬 */
  align-items: center;      /* 세로 정렬 (높이 맞출 때) */
  gap: 12px;                /* 버튼 사이 간격 */
  flex-wrap: wrap;          /* 창 작으면 줄바꿈 허용 */
}

.login-guide {
  text-align: center;
  font-size: 14px;
  color: #444;
  margin-bottom: 12px;
  white-space: nowrap;  /* 줄바꿈 방지 */
}

</style>
</head>
<body>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="./inc/header.jsp" %>
	<section style="padding: 40px 0px 50px;">
		<div style="text-align:center;">
			<div class="login-title">Peach에 오신것을 환영합니다.</div>
		</div>
		<div class="container" style="text-align:center">
			<form action="/action_page.php">
				<h2 style="text-align:center; color:#494949; font-size:24px; font-weight: 600;">Peach Store에 로그인하세요</h2>
				<div class="row">
					<div class="col">
						<input class="a" type="text" name="username" placeholder="Username" required>
						<input class="a" type="password" name="password" placeholder="Password" required>
						<input class="a" type="submit" value="Login">
					</div>
				</div>
			</form>
		</div>
		
		<!-- <div class="bottom-container">
			<div class="row">
				<div class="col">
					<a href="/shop/joinform" style="color:white" class="btn">회원가입하기</a>
				</div>
			</div>
		</div> -->
		
		
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
			<a href="/shop/joinform">peach계정 생성</a>
		</div>
		
	</section>
	<script type="text/javascript">
		function login(sns){
			$.ajax({
				url:"/shop/user/"+sns+"/authurl",
				type:"GET",
				success:function(result){
				alert(result);
					location.href=result;//동의화면 요청
				}
			})
		
		}
	</script>
</body>
</html>
