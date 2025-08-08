<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="peachstore.domain.SnapShot"%>
<%@page import="peachstore.domain.CartItem"%>
<%@page import="peachstore.domain.ProductImg"%>
<%@page import="peachstore.domain.Product"%>
<%@page import="peachstore.domain.ProductTopcategory"%>
<%@page import="java.util.List"%>
<%
List<ProductTopcategory> topList = (List) request.getAttribute("topList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 성공 - Peach Store</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: #1d1d1f;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    text-align: center;
    padding: 20px;
}

.success-container {
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

.success-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2);
}

.success-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #34d399, #10b981);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 32px;
    position: relative;
    animation: successPulse 2s ease-in-out infinite;
}

.success-icon::after {
    content: '✓';
    color: white;
    font-size: 36px;
    font-weight: bold;
}

@keyframes successPulse {
    0%, 100% { 
        transform: scale(1);
        box-shadow: 0 0 0 0 rgba(52, 211, 153, 0.4);
    }
    50% { 
        transform: scale(1.05);
        box-shadow: 0 0 0 20px rgba(52, 211, 153, 0);
    }
}

.success-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 16px;
    color: #1d1d1f;
    letter-spacing: -0.5px;
    line-height: 1.2;
}

.success-subtitle {
    font-size: 19px;
    font-weight: 400;
    color: #86868b;
    margin-bottom: 12px;
    line-height: 1.4;
}

.order-info {
    background: #f5f5f7;
    border-radius: 16px;
    padding: 24px;
    margin: 32px 0;
    text-align: left;
}

.order-info-title {
    font-size: 17px;
    font-weight: 600;
    color: #1d1d1f;
    margin-bottom: 16px;
    text-align: center;
}

.order-detail {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
}

.order-detail:last-child {
    margin-bottom: 0;
}

.order-label {
    font-size: 15px;
    color: #86868b;
    font-weight: 400;
}

.order-value {
    font-size: 15px;
    color: #1d1d1f;
    font-weight: 500;
}

.order-number {
    color: #0071e3 !important;
    font-weight: 600;
}

.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-top: 40px;
}

.btn {
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

.btn-primary {
    background: #0071e3;
    color: white;
}

.btn-primary:hover {
    background: #0077ed;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(0, 113, 227, 0.3);
}

.btn-secondary {
    background: transparent;
    color: #0071e3;
    border: 2px solid #0071e3;
}

.btn-secondary:hover {
    background: #0071e3;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(0, 113, 227, 0.2);
}

.additional-info {
    margin-top: 32px;
    padding-top: 24px;
    border-top: 1px solid #e5e5e7;
    font-size: 14px;
    color: #86868b;
    line-height: 1.5;
}

.additional-info p {
    margin-bottom: 8px;
}

.email-highlight {
    color: #0071e3;
    font-weight: 500;
}

/* Responsive */
@media (max-width: 768px) {
    .success-container {
        padding: 40px 24px;
        margin: 20px;
        border-radius: 20px;
    }
    
    .success-title {
        font-size: 28px;
    }
    
    .success-subtitle {
        font-size: 17px;
    }
    
    .action-buttons {
        margin-top: 32px;
    }
}

@media (max-width: 480px) {
    body {
        padding: 16px;
    }
    
    .success-container {
        padding: 32px 20px;
    }
    
    .success-title {
        font-size: 24px;
    }
    
    .order-info {
        padding: 20px;
    }
}
</style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon"></div>
        
        <h1 class="success-title">주문해 주셔서 감사합니다</h1>
        <p class="success-subtitle">고객님의 주문이 성공적으로 완료되었습니다</p>
        
        <div class="order-info">
            <div class="order-info-title">주문 정보</div>
            <div class="order-detail">
                <span class="order-label">주문 번호</span>
                <span class="order-value order-number">${orderReceiptId}</span>
            </div>
            <div class="order-detail">
                <span class="order-label">결제 상태</span>
                <span class="order-value">결제 완료</span>
            </div>
            <div class="order-detail">
                <span class="order-label">배송 상태</span>
                <span class="order-value">준비 중</span>
            </div>
        </div>
        
        <div class="additional-info">
            <p>주문 확인 이메일이 고객님의 이메일 주소로 발송됩니다.</p>
            <p>배송 관련 문의사항은 고객센터로 연락해 주세요.</p>
        </div>
        
        <div class="action-buttons">
            <a href="/shop/main" class="btn btn-primary">쇼핑 계속하기</a>
            <a href="/shop/order/list" class="btn btn-secondary">주문 내역 확인</a>
        </div>
    </div>
</body>
</html>