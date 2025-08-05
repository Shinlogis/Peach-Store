<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Failed</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .error-container {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        .error-container h1 {
            color: #ff4d4f;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .error-container a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #ffffff;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.2s ease;
        }

        .error-container a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="error-container">
    <h1>⚠ 로그인 정보가 올바르지 않습니다.</h1>
    <a href="/shop/loginform">돌아가기</a>
</div>

</body>
</html>
