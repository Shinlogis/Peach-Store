<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<%@ include file="../inc/head_link.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #ffffff;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.login-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    padding: 50px 40px;
    width: 100%;
    max-width: 450px;
    text-align: center;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.logo {
    margin-bottom: 30px;
}

.logo i {
    font-size: 48px;
    color: #667eea;
    margin-bottom: 15px;
}

.login-title {
    font-size: 28px;
    font-weight: 700;
    color: #333;
    margin-bottom: 10px;
}

.login-subtitle {
    font-size: 16px;
    color: #666;
    margin-bottom: 40px;
}

.form-group {
    position: relative;
    margin-bottom: 25px;
}

.form-group i {
    position: absolute;
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: #999;
    font-size: 18px;
}

.form-input {
    width: 100%;
    padding: 18px 20px 18px 55px;
    border: 2px solid #e1e5e9;
    border-radius: 12px;
    font-size: 16px;
    background: #fff;
    transition: all 0.3s ease;
    outline: none;
}

.form-input:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-input::placeholder {
    color: #999;
    font-weight: 400;
}

.login-btn {
    width: 100%;
    padding: 18px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 12px;
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 15px;
}

.login-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
}

.login-btn:active {
    transform: translateY(0);
}

.error-message {
    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
    color: white;
    padding: 15px 20px;
    border-radius: 12px;
    margin-bottom: 25px;
    font-weight: 500;
    box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
    animation: fadeIn 0.5s ease;
}

.error-message i {
    margin-right: 8px;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* 반응형 디자인 */
@media (max-width: 480px) {
    .login-container {
        padding: 30px 25px;
        margin: 10px;
    }
    
    .login-title {
        font-size: 24px;
    }
    
    .form-input {
        padding: 15px 15px 15px 50px;
    }
    
    .login-btn {
        padding: 15px;
    }
}

/* 로딩 애니메이션 */
.loading {
    position: relative;
    pointer-events: none;
}

.loading::after {
    content: '';
    position: absolute;
    width: 20px;
    height: 20px;
    margin: auto;
    border: 2px solid transparent;
    border-top-color: #ffffff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

@keyframes spin {
    0% { transform: translate(-50%, -50%) rotate(0deg); }
    100% { transform: translate(-50%, -50%) rotate(360deg); }
}
</style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <i class="fas fa-user-shield"></i>
        <div class="login-title">PeachStore</div>
        <div class="login-subtitle">관리자 로그인</div>
    </div>

    <!-- 에러 메시지 표시 -->
    <%
    String error = request.getParameter("error");
    if ("deactivated".equals(error)) {
    %>
    <div class="error-message">
        <i class="fas fa-exclamation-triangle"></i>
        비활성화된 계정입니다. 관리자에게 문의하세요.
    </div>
    <%
    } else if ("1".equals(error)) {
    %>
    <div class="error-message">
        <i class="fas fa-times-circle"></i>
        이메일 또는 비밀번호가 올바르지 않습니다.
    </div>
    <%
    }
    %>

    <form id="loginForm" action="/admin/user/login" method="post">
        <div class="form-group">
            <i class="fas fa-envelope"></i>
            <input class="form-input" type="text" name="email" placeholder="관리자 이메일" required>
        </div>
        
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input class="form-input" type="password" name="password" placeholder="비밀번호" required>
        </div>
        
        <button class="login-btn" type="submit" id="loginBtn">
            <span class="btn-text">로그인</span>
        </button>
    </form>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // 폼 제출 시 로딩 애니메이션
    $("#loginForm").on("submit", function() {
        const btn = $("#loginBtn");
        const btnText = btn.find(".btn-text");
        
        btn.addClass("loading");
        btnText.text("로그인 중...");
        btn.prop("disabled", true);
    });
    
    // 입력 필드 엔터키 처리
    $(".form-input").on("keypress", function(e) {
        if (e.which === 13 && !$(this).is(":last-child")) {
            e.preventDefault();
            $(this).closest(".form-group").next().find(".form-input").focus();
        }
    });
    
    // 에러 메시지 자동 삭제 (URL 정리)
    if (location.search.includes('error=')) {
        setTimeout(() => {
            history.replaceState(null, '', location.pathname);
        }, 100);
    }
    
    // 입력 필드 포커스 애니메이션
    $(".form-input").on("focus", function() {
        $(this).closest(".form-group").find("i").css("color", "#667eea");
    }).on("blur", function() {
        $(this).closest(".form-group").find("i").css("color", "#999");
    });
});
</script>
</body>
</html>