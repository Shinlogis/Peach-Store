<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f3f6fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.07);
            padding: 48px 32px;      
            width: 100%;
            max-width: 600px;        
            min-width: 340px;
            min-height: 400px;          
            overflow: visible; 
        }

        .header {
            text-align: center;
            margin-bottom: 28px;
        }

        .header h2 {
            color: #333;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            color: #666;
            font-size: 13px;
        }

        .error-message {
            background: #ffeded;
            color: #d33;
            padding: 14px;
            border-radius: 10px;
            margin-bottom: 22px;
            border-left: 4px solid #ff9494;
            font-size: 14px;
        }

        .success-message {
            background: #edf7ed;
            color: #2e7d32;
            padding: 14px;
            border-radius: 10px;
            margin-bottom: 22px;
            border-left: 4px solid #4caf50;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 19px;
            position: relative;
        }

        .form-group label {
            display: block;
            color: #555;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 18px;
            transition: all 0.3s;
            background: #fafafa;
            padding-right: 45px;
        }

        .form-control:focus {
            border-color: #667eea;
            background: #fff;
            outline: none;
        }

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
            color: #667eea;
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

        .strength-weak { background: #ff6b6b; width: 25%; }
        .strength-fair { background: #ffa726; width: 50%; }
        .strength-good { background: #66bb6a; width: 75%; }
        .strength-strong { background: #4caf50; width: 100%; }

        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 8px;
            line-height: 1.4;
        }

        .requirement {
            display: flex;
            align-items: center;
            margin: 4px 0;
        }

        .requirement.valid {
            color: #4caf50;
        }

        .requirement.invalid {
            color: #ff6b6b;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            margin-top: 32px; 
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .submit-btn:hover {
            background: #495bd6;
        }

        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        @media (max-width: 520px) {
            .container {
                padding: 22px 10px;
                max-width: 95vw;
                min-width: 0;
            }
        }

        .loading .submit-btn {
            background: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>🔐 비밀번호 변경</h2>
            <p>보안을 위해 주기적으로 비밀번호를 변경해주세요</p>
        </div>

        <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        
        if ("mismatch".equals(error)) {
        %>
        <div class="error-message">
            <strong>⚠️ 비밀번호 불일치</strong><br>
            새 비밀번호가 일치하지 않습니다. 다시 확인해주세요.
        </div>
        <%
        } else if ("wrongpw".equals(error)) {
        %>
        <div class="error-message">
            <strong>⚠️ 현재 비밀번호 오류</strong><br>
            현재 비밀번호가 올바르지 않습니다.
        </div>
        <%
        } else if ("fail".equals(error)) {
        %>
        <div class="error-message">
            <strong>⚠️ 변경 실패</strong><br>
            비밀번호 변경에 실패했습니다. 잠시 후 다시 시도해주세요.
        </div>
        <%
        } else if ("1".equals(success)) {
        %>
        <div class="success-message">
            <strong>✅ 변경 완료</strong><br>
            비밀번호가 성공적으로 변경되었습니다.
        </div>
        <%
        }
        %>

        <form action="/admin/user/changepassword" method="post" id="passwordForm">
            <div class="form-group">
                <label for="currentPassword">🔑 현재 비밀번호</label>
                <input type="password" 
                       id="currentPassword" 
                       name="currentPassword" 
                       class="form-control" 
                       placeholder="현재 비밀번호를 입력하세요" 
                       required>
                <span class="password-toggle" onclick="togglePassword('currentPassword')">👁️</span>
            </div>

            <div class="form-group">
                <label for="newPassword">🆕 새 비밀번호</label>
                <input type="password" 
                       id="newPassword" 
                       name="newPassword" 
                       class="form-control" 
                       placeholder="새 비밀번호를 입력하세요" 
                       required>
                <span class="password-toggle" onclick="togglePassword('newPassword')">👁️</span>
            </div>

            <div class="form-group">
                <label for="confirmPassword">✅ 새 비밀번호 확인</label>
                <input type="password" 
                       id="confirmPassword" 
                       name="confirmPassword" 
                       class="form-control" 
                       placeholder="새 비밀번호를 다시 입력하세요" 
                       required>
                <span class="password-toggle" onclick="togglePassword('confirmPassword')">👁️</span>
                <div id="matchStatus" style="font-size: 12px; margin-top: 8px;"></div>
            </div>

            <button type="submit" class="submit-btn" id="submitBtn">
                🔄 비밀번호 변경하기
            </button>
        </form>
    </div>

    <script>
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const toggle = field.nextElementSibling;
            
            if (field.type === 'password') {
                field.type = 'text';
                toggle.textContent = '🙈';
            } else {
                field.type = 'password';
                toggle.textContent = '👁️';
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
                matchStatus.textContent = '✅ 비밀번호가 일치합니다';
                matchStatus.style.color = '#4caf50';
                submitBtn.disabled = false;
            } else {
                matchStatus.textContent = '❌ 비밀번호가 일치하지 않습니다';
                matchStatus.style.color = '#ff6b6b';
                submitBtn.disabled = true;
            }
        }

        // 폼 제출 시 로딩 상태
        document.getElementById('passwordForm').addEventListener('submit', function() {
            this.classList.add('loading');
            const btn = this.querySelector('.submit-btn');
            btn.innerHTML = '⏳ 변경 중...';
            btn.disabled = true;
        });
    </script>
</body>
</html>