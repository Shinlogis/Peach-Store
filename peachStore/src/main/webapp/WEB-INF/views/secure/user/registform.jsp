<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 등록</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f3f6fa; /* 기존 그라데이션 대신 밝은 배경 */
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

        .form-group {
            margin-bottom: 19px;
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
        }

        .form-control:focus {
            border-color: #667eea;
            background: #fff;
        }

        select.form-control {
		    padding-top: 12px;
		    padding-bottom: 12px;
		    line-height: 1.4;
		    height: 48px;
		    font-size: 18px;
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

        @media (max-width: 520px) {
            .container {
                padding: 22px 10px;
                max-width: 95vw;
                min-width: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>👨‍💼 관리자 등록</h2>
            <p>새로운 관리자 계정을 생성합니다</p>
        </div>

        <%
        String error = request.getParameter("error");
        if ("1".equals(error)) {
        %>
        <div class="error-message">
            <strong>⚠️ 등록 실패</strong>
            이메일이 중복되었거나 필수 정보가 누락되었습니다.<br>
            다시 확인해주세요.
        </div>
        <%
        }
        %>

        <form action="/admin/user/regist" method="post" id="registForm">
            <div class="form-group">
                <label for="email">📧 이메일 (아이디)</label>
                <input type="email" 
                       id="email" 
                       name="email" 
                       class="form-control" 
                       placeholder="admin@example.com" 
                       required>
            </div>

            <div class="form-group">
                <label for="adminName">👤 관리자 이름</label>
                <input type="text" 
                       id="adminName" 
                       name="adminName" 
                       class="form-control" 
                       placeholder="아무개" 
                       required>
            </div>

            <div class="form-group">
                <label for="role">🔐 권한 등급</label>
                <select id="role" name="role" class="form-control" required>
                    <option value="">권한을 선택하세요</option>
                    <option value="admin">일반 관리자</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">
                ✨ 관리자 등록하기
            </button>
        </form>
    </div>

    <script>
        // 폼 제출 시 로딩 상태
        document.getElementById('registForm').addEventListener('submit', function() {
            this.classList.add('loading');
            const btn = this.querySelector('.submit-btn');
            btn.innerHTML = '⏳ 등록 중...';
        });

        // 이메일 형식 실시간 검증
        document.getElementById('email').addEventListener('input', function() {
            const email = this.value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailRegex.test(email)) {
                this.style.borderColor = '#ff6b6b';
            } else {
                this.style.borderColor = '#e1e5e9';
            }
        });
    </script>
</body>
</html>
