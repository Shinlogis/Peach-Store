<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | 관리자 등록</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-group label {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .form-control {
            padding: 12px 16px;
            font-size: 15px;
            height: auto;
            border-radius: 8px;
            border: 2px solid #e1e5e9;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .input-group-text {
            padding: 12px 16px;
            font-size: 16px;
            background: #f8f9fa;
            border: 2px solid #e1e5e9;
            border-left: none;
        }

        .password-toggle {
            cursor: pointer;
            color: #999;
            transition: color 0.3s;
        }

        .password-toggle:hover {
            color: #007bff;
        }

        .password-strength {
            height: 4px;
            background: #e1e5e9;
            border-radius: 2px;
            margin-top: 10px;
            overflow: hidden;
        }

        .password-strength-fill {
            height: 100%;
            border-radius: 2px;
            transition: all 0.3s;
            width: 0%;
        }

        .strength-weak { background: #dc3545; width: 25%; }
        .strength-fair { background: #ffc107; width: 50%; }
        .strength-good { background: #28a745; width: 75%; }
        .strength-strong { background: #20c997; width: 100%; }

        .password-requirements {
            font-size: 13px;
            color: #666;
            margin-top: 12px;
            line-height: 1.5;
        }

        .requirement {
            display: flex;
            align-items: center;
            margin: 6px 0;
        }

        .requirement.valid {
            color: #28a745;
        }

        .requirement.invalid {
            color: #dc3545;
        }

        .alert-custom {
            border-radius: 8px;
            border: none;
            padding: 16px 20px;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .card-primary .card-header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            padding: 20px 24px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 600;
            color: white;
        }

        .card-body {
            padding: 30px;
        }

        .card-footer {
            padding: 20px 30px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 15px;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }

        .btn-secondary {
            padding: 12px 30px;
            font-size: 15px;
            border-radius: 8px;
            border: 2px solid #6c757d;
            background: white;
            color: #6c757d;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-1px);
        }

        .select-custom {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 12px center;
            background-repeat: no-repeat;
            background-size: 16px;
            padding-right: 40px;
        }

        .content-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
        }

        .breadcrumb-item {
            font-size: 14px;
        }
		.form-container {
		    width: 100%;
		    max-width: none;
		    margin: 0;
		}
		.card {
		    width: 100%;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border: none;
            border-radius: 12px;
        }

        #matchStatus {
            font-size: 13px;
            margin-top: 8px;
            font-weight: 500;
        }

        .required {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
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
                        <h1 class="m-0">👤 관리자 등록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">관리자 관리 > 관리자 등록</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="form-container">
                            <%
                            String error = request.getParameter("error");
                            String success = request.getParameter("success");
                            
                            if ("exist".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 등록 실패</strong><br>
                                이미 존재하는 이메일입니다. 다른 이메일을 사용해주세요.
                            </div>
                            <%
                            } else if ("fail".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 등록 실패</strong><br>
                                관리자 등록에 실패했습니다. 잠시 후 다시 시도해주세요.
                            </div>
                            <%
                            } else if ("validation".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 입력 오류</strong><br>
                                모든 필드를 올바르게 입력해주세요.
                            </div>
                            <%
                            } else if ("1".equals(success)) {
                            %>
                            <div class="alert-custom alert-success">
                                <strong><i class="fas fa-check-circle"></i> 등록 완료</strong><br>
                                새로운 관리자가 성공적으로 등록되었습니다.
                            </div>
                            <%
                            }
                            %>

                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-user-plus"></i> 새 관리자 등록
                                    </h3>
                                </div>
                                <form action="/admin/user/regist" method="post" id="adminForm">
                                    <div class="card-body">
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle"></i>
                                            새로운 관리자를 시스템에 등록합니다. 모든 필드는 필수 항목입니다.
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="adminName">
                                                        <i class="fas fa-user"></i> 관리자 이름 <span class="required">*</span>
                                                    </label>
                                                    <input type="text" 
                                                           id="adminName" 
                                                           name="adminName" 
                                                           class="form-control" 
                                                           placeholder="관리자 이름을 입력하세요"
                                                           required 
                                                           maxlength="50">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="email">
                                                        <i class="fas fa-envelope"></i> 이메일 주소 <span class="required">*</span>
                                                    </label>
                                                    <input type="email" 
                                                           id="email" 
                                                           name="email" 
                                                           class="form-control" 
                                                           placeholder="이메일 주소를 입력하세요"
                                                           required 
                                                           maxlength="100">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="role">
                                                        <i class="fas fa-shield-alt"></i> 권한 레벨 <span class="required">*</span>
                                                    </label>
                                                    <select id="role" 
                                                            name="role" 
                                                            class="form-control select-custom" 
                                                            required>
                                                        <option value="">권한을 선택하세요</option>
                                                        <option value="ADMIN">ADMIN - 일반 관리자</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-footer">
                                        <button type="submit" class="btn btn-primary" id="submitBtn">
                                            <i class="fas fa-user-plus"></i> 관리자 등록하기
                                        </button>
                                        <button type="button" class="btn btn-secondary ml-2" onclick="history.back()">
                                            <i class="fas fa-arrow-left"></i> 이전으로
                                        </button>
                                        <a href="/admin/user/adminlist" class="btn btn-info ml-2">
                                            <i class="fas fa-list"></i> 관리자 목록
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <%@ include file="../inc/footer.jsp" %>
</div>
<%@ include file="../inc/footer_link.jsp" %>

<script>
    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        const toggle = field.parentElement.nextElementSibling.querySelector('i');
        
        if (field.type === 'password') {
            field.type = 'text';
            toggle.className = 'fas fa-eye-slash';
        } else {
            field.type = 'password';
            toggle.className = 'fas fa-eye';
        }
    }

    // 비밀번호 강도 체크
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        checkPasswordStrength(password);
        checkPasswordMatch();
    });

    document.getElementById('confirmPassword').addEventListener('input', function() {
        checkPasswordMatch();
    });

    function checkPasswordStrength(password) {
        const requirements = {
            length: password.length >= 8,
            upper: /[A-Z]/.test(password),
            lower: /[a-z]/.test(password),
            number: /\d/.test(password)
        };

        // 요구사항 체크 표시
        Object.keys(requirements).forEach(req => {
            const element = document.getElementById(`req-${req}`);
            const check = document.getElementById(`check-${req}`);
            if (requirements[req]) {
                element.classList.add('valid');
                element.classList.remove('invalid');
                check.textContent = '✅';
            } else {
                element.classList.add('invalid');
                element.classList.remove('valid');
                check.textContent = '❌';
            }
        });

        // 강도 바 업데이트
        const strengthFill = document.getElementById('strengthFill');
        const validCount = Object.values(requirements).filter(Boolean).length;
        
        strengthFill.className = 'password-strength-fill';
        if (validCount === 1) strengthFill.classList.add('strength-weak');
        else if (validCount === 2) strengthFill.classList.add('strength-fair');
        else if (validCount === 3) strengthFill.classList.add('strength-good');
        else if (validCount === 4) strengthFill.classList.add('strength-strong');
    }

    function checkPasswordMatch() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const matchStatus = document.getElementById('matchStatus');
        const submitBtn = document.getElementById('submitBtn');

        if (confirmPassword === '') {
            matchStatus.textContent = '';
            submitBtn.disabled = false;
        } else if (password === confirmPassword) {
            matchStatus.innerHTML = '<i class="fas fa-check-circle text-success"></i> 비밀번호가 일치합니다';
            matchStatus.style.color = '#28a745';
            submitBtn.disabled = false;
        } else {
            matchStatus.innerHTML = '<i class="fas fa-times-circle text-danger"></i> 비밀번호가 일치하지 않습니다';
            matchStatus.style.color = '#dc3545';
            submitBtn.disabled = true;
        }
    }

    // 이메일 유효성 검사
    document.getElementById('email').addEventListener('blur', function() {
        const email = this.value;
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (email && !emailPattern.test(email)) {
            this.setCustomValidity('올바른 이메일 형식을 입력해주세요.');
        } else {
            this.setCustomValidity('');
        }
    });

    // 폼 제출 시 로딩 상태
    document.getElementById('adminForm').addEventListener('submit', function(e) {
        const btn = this.querySelector('#submitBtn');
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        // 비밀번호 일치 확인
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        
        // 비밀번호 강도 확인
        const requirements = {
            length: password.length >= 8,
            upper: /[A-Z]/.test(password),
            lower: /[a-z]/.test(password),
            number: /\d/.test(password)
        };
        
        const validCount = Object.values(requirements).filter(Boolean).length;
        if (validCount < 4) {
            e.preventDefault();
            alert('비밀번호는 8자 이상, 대소문자, 숫자를 모두 포함해야 합니다.');
            return false;
        }
        
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 등록 중...';
        btn.disabled = true;
    });

    // 페이지 로드 시 성공 메시지 자동 제거
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert-custom');
        alerts.forEach(function(alert) {
            if (alert.classList.contains('alert-success')) {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            }
        });
    }, 3000);
</script>
</body>
</html>