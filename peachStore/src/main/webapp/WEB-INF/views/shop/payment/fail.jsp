<%@page import="java.util.List"%>
<%@page import="peachstore.domain.ProductSubcategory"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<ProductTopcategory> topList =(List)request.getAttribute("topList");
	List<ProductSubcategory> subList=(List)request.getAttribute("subList");
	String topname=(String)request.getAttribute("topName");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패 - Peach Store</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- 헤더 CSS 및 외부 링크 -->
    <%@ include file="../inc/head_link.jsp" %>

    <!-- 페이지 전용 CSS -->
    <link rel="stylesheet" href="/static/shop/css/product/accessoryList.css">

    <style>
.fail-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 70vh; /* 헤더 아래 위치하도록 적절한 높이 */
    padding: 20px;
}

.fail-wrapper .fail-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 24px;
    padding: 60px 40px;
    max-width: 480px;
    width: 100%;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    position: relative;
    overflow: hidden;
}

.fail-wrapper .fail-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #ff758c, #ff7eb3);
}

.fail-wrapper .fail-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #f87171, #ef4444);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 32px;
    position: relative;
    animation: failPulse 2s ease-in-out infinite;
}

.fail-wrapper .fail-icon::after {
    content: '✕';
    color: white;
    font-size: 36px;
    font-weight: bold;
}

@keyframes failPulse {
    0%, 100% {
        transform: scale(1);
        box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4);
    }
    50% {
        transform: scale(1.05);
        box-shadow: 0 0 0 20px rgba(239, 68, 68, 0);
    }
}

.fail-wrapper .fail-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 16px;
    color: #1d1d1f;
    letter-spacing: -0.5px;
    line-height: 1.2;
}

.fail-wrapper .fail-subtitle {
    font-size: 19px;
    font-weight: 400;
    color: #86868b;
    margin-bottom: 24px;
    line-height: 1.4;
}

.fail-wrapper .action-buttons {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-top: 32px;
}

.fail-wrapper .btn {
    padding: 17px 32px;
    border-radius: 12px;
    font-size: 17px;
    font-weight: 500;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s ease;
    letter-spacing: 0.3px;
    border: none;
    cursor: pointer;
}

.fail-wrapper .btn-primary {
    background: #0071e3;
    color: white;
}

.fail-wrapper .btn-primary:hover {
    background: #0077ed;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(0, 113, 227, 0.3);
}

.fail-wrapper .btn-secondary {
    background: transparent;
    color: #0071e3;
    border: 2px solid #0071e3;
}

.fail-wrapper .btn-secondary:hover {
    background: #0071e3;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(0, 113, 227, 0.2);
}

/* Responsive */
@media (max-width: 768px) {
    .fail-wrapper .fail-container {
        padding: 40px 24px;
        margin: 20px;
        border-radius: 20px;
    }

    .fail-wrapper .fail-title {
        font-size: 28px;
    }

    .fail-wrapper .fail-subtitle {
        font-size: 17px;
    }

    .fail-wrapper .action-buttons {
        margin-top: 28px;
    }
}

@media (max-width: 480px) {
    .fail-wrapper .fail-container {
        padding: 32px 20px;
    }

    .fail-wrapper .fail-title {
        font-size: 24px;
    }
}

    </style>
</head>

<body>
    <!-- Header Section Begin -->
    <%@ include file="../inc/header.jsp" %>
    <!-- Header Section End -->

    <div class="fail-wrapper">
        <div class="fail-container">
            <div class="fail-icon"></div>

            <h1 class="fail-title">결제에 실패했습니다</h1>
            <p class="fail-subtitle">문제가 발생하여 결제가 완료되지 않았습니다.<br>다시 시도하거나 고객센터에 문의해 주세요.</p>

            <div class="action-buttons">
                <a href="/shop/main" class="btn btn-secondary">홈으로 이동</a>
            </div>
        </div>
    </div>

    <!-- Footer Section -->
    <%@ include file="../inc/footer_link.jsp" %>

    <!-- AdminLTE for demo purposes -->
    <script src="/static/admin/dist/js/demo.js"></script>
    <script src="/static/admin/dist/js/pages/dashboard.js"></script>
</body>
</html>
