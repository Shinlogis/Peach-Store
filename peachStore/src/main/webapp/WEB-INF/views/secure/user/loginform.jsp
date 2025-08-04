<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<%@ include file="../inc/head_link.jsp" %>
	<link rel="stylesheet" href="/static/shop/css/main/login.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<section style="padding: 40px 0px 50px;">
		<div style="text-align:center;">
			<div class="login-title">PeachStore 관리자 로그인</div>
		</div>

		<div class="container" style="text-align:center">
			<form id="form1" action="/admin/user/login" method="post">
				<h2 style="text-align:center; color:#494949; font-size:24px; font-weight: 600;">
					Peach Store에 로그인하세요
				</h2>
				<div class="row">
					<div class="col">
						<input class="a" type="text" name="id" placeholder="Adminid" required>
						<input class="a" type="password" name="password" placeholder="Password" required>
						<input class="a" type="submit" value="Login" id="bt_login">
					</div>
				</div>
			</form>
		</div>

	</section>

	<script type="text/javascript">
		// submit 버튼에 이벤트 바인딩 (디자인 상 유지)
		$(() => {
			$("#bt_login").click(() => {
				$("#form1").submit();
			});
		});
	</script>
</body>
</html>
