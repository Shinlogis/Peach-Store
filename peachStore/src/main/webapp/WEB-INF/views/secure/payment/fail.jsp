<%@ page contentType="text/html; charset=UTF-8"%>
<h2>결제 처리에 실패했습니다.</h2>
<p>주문번호: ${orderId}</p>
<p>결제금액: ${amount}원</p>
<p><a href="/admin/payment/start?orderId=${orderId}&orderReceiptId=${orderReceiptId}&amount=${amount}">다시 시도하기</a></p>
