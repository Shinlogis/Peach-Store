<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String paymentKey     = request.getParameter("paymentKey");
  String orderId        = request.getParameter("orderId");
  String amountStr      = request.getParameter("amount");
  String orderReceiptId = request.getParameter("orderReceiptId");

  long amount = Long.parseLong(amountStr);
%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>승인 중...</title></head>
<body>
  <h3>결제 승인 중입니다...</h3>
  <script>
    const paymentKey     = '<%=paymentKey%>';
    const orderId        = '<%=orderId%>';
    const amount         = <%=amount%>;
    const orderReceiptId = <%=orderReceiptId%>;

    fetch("/shop/payment/confirm", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ paymentKey, orderId, amount, orderReceiptId })
    })
    .then(res => {
      if (!res.ok) throw new Error(res.status);
      // 최종 성공 페이지로 이동
      window.location.href = "/shop/payment/success?orderId=" + orderId + "&amount=" + amount;
    })
    .catch(() => {
      // 실패 페이지로 이동
      window.location.href = "/shop/payment/fail?orderId=" + orderId + "&amount=" + amount + "&orderReceiptId=" + orderReceiptId;
    });
  </script>
</body>
</html>
