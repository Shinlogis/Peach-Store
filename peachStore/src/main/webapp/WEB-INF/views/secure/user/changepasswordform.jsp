<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | 비밀번호 변경</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 18px;
            user-select: none;
        }

        .password-toggle:hover {
            color: #007bff;
        }

        .form-group {
            position: relative;
        }

        .password-strength {
            height: 4px;
            background: #e1e5e9;
            border-radius: 2px;
            margin-top: 8px;
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
            font-size: 14px;
            color: #666;
            margin-top: 12px;
            line-height: 1.6;
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
            padding: 20px 24px;
            margin-bottom: 24px;
            font-size: 16px;
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
            padding: 20px 24px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 600;
        }

        .card-body {
		    padding: 30px;
		    height: 100%;      
		    display: flex;
		    flex-direction: column;
		    justify-content: center;  
		}

        .card-footer {
            padding: 20px 30px;
            background: #f8f9fa;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            padding: 12px 36px;
            font-weight: 600;
            font-size: 16px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
        }

        .btn-secondary {
            padding: 12px 36px;
            font-size: 16px;
        }

        .form-control {
            padding: 12px 16px;
            font-size: 16px;
            height: auto;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .form-group label {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .input-group-text {
            padding: 12px 16px;
            font-size: 18px;
        }

        .alert-info {
            padding: 16px 20px;
            font-size: 15px;
            border-radius: 8px;
        }

        .password-form-container {
		    max-width: 100% !important;
		    width: 100% !important;
		    margin: 0 auto;
		    padding: 0; /* 필요하면 여백 조정 */
		}
		
		.card.card-primary {
		    width: 100%;
		}

        #matchStatus {
            font-size: 14px;
            margin-top: 10px;
            font-weight: 500;
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
                        <h1 class="m-0">비밀번호 변경</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">계정관리 > 비밀번호 변경</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="password-form-container">
                            <%
                            String error = request.getParameter("error");
                            String success = request.getParameter("success");
                            
                            if ("mismatch".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 비밀번호 불일치</strong><br>
                                새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.
                            </div>
                            <%
                            } else if ("wrongpw".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 현재 비밀번호 오류</strong><br>
                                현재 비밀번호가 올바르지 않습니다.
                            </div>
                            <%
                            } else if ("fail".equals(error)) {
                            %>
                            <div class="alert-custom alert-error">
                                <strong><i class="fas fa-exclamation-triangle"></i> 변경 실패</strong><br>
                                비밀번호 변경에 실패했습니다. 잠시 후 다시 시도해주세요.
                            </div>
                            <%
                            } else if ("1".equals(success)) {
                            %>
                            <div class="alert-custom alert-success">
                                <strong><i class="fas fa-check-circle"></i> 변경 완료</strong><br>
                                비밀번호가 성공적으로 변경되었습니다.
                            </div>
                            <%
                            }
                            %>

                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-key"></i> 비밀번호 변경
                                    </h3>
                                </div>
                                <form action="/admin/user/changepassword" method="post" id="passwordForm">
                                    <div class="card-body">
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle"></i>
                                            보안을 위해 주기적으로 비밀번호를 변경해주세요.
                                        </div>

                                        <div class="form-group">
                                            <label for="currentPassword">
                                                <i class="fas fa-lock"></i> 현재 비밀번호
                                            </label>
                                            <div class="input-group">
                                                <input type="password" 
                                                       id="currentPassword" 
                                                       name="currentPassword" 
                                                       class="form-control" 
                                                       placeholder="현재 비밀번호를 입력하세요" 
                                                       required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text password-toggle" onclick="togglePassword('currentPassword')">
                                                        <i class="fas fa-eye"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="newPassword">
                                                <i class="fas fa-key"></i> 새 비밀번호
                                            </label>
                                            <div class="input-group">
                                                <input type="password" 
                                                       id="newPassword" 
                                                       name="newPassword" 
                                                       class="form-control" 
                                                       placeholder="새 비밀번호를 입력하세요" 
                                                       required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text password-toggle" onclick="togglePassword('newPassword')">
                                                        <i class="fas fa-eye"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="confirmPassword">
                                                <i class="fas fa-check"></i> 새 비밀번호 확인
                                            </label>
                                            <div class="input-group">
                                                <input type="password" 
                                                       id="confirmPassword" 
                                                       name="confirmPassword" 
                                                       class="form-control" 
                                                       placeholder="새 비밀번호를 다시 입력하세요" 
                                                       required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text password-toggle" onclick="togglePassword('confirmPassword')">
                                                        <i class="fas fa-eye"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div id="matchStatus"></div>
                                        </div>
                                    </div>

                                    <div class="card-footer">
                                        <button type="submit" class="btn btn-primary" id="submitBtn">
                                            <i class="fas fa-save"></i> 비밀번호 변경하기
                                        </button>
                                        <button type="button" class="btn btn-secondary ml-2" onclick="history.back()">
                                            <i class="fas fa-arrow-left"></i> 이전으로
                                        </button>
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
    document.getElementById('newPassword').addEventListener('input', function() {
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
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const matchStatus = document.getElementById('matchStatus');
        const submitBtn = document.getElementById('submitBtn');

        if (confirmPassword === '') {
            matchStatus.textContent = '';
            submitBtn.disabled = false;
        } else if (newPassword === confirmPassword) {
            matchStatus.innerHTML = '<i class="fas fa-check-circle text-success"></i> 비밀번호가 일치합니다';
            matchStatus.style.color = '#28a745';
            submitBtn.disabled = false;
        } else {
            matchStatus.innerHTML = '<i class="fas fa-times-circle text-danger"></i> 비밀번호가 일치하지 않습니다';
            matchStatus.style.color = '#dc3545';
            submitBtn.disabled = true;
        }
    }

    // 폼 제출 시 로딩 상태
    document.getElementById('passwordForm').addEventListener('submit', function() {
        const btn = this.querySelector('#submitBtn');
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 변경 중...';
        btn.disabled = true;
    });

    // 페이지 로드 시 에러 메시지가 있으면 자동으로 제거
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