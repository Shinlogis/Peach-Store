<%@ page contentType="text/html; charset=UTF-8" %>
<%
  // Model 에서 받은 값들
  Long   amount          = (Long)    request.getAttribute("amount");
  String orderId         = (String)  request.getAttribute("orderId");
  String orderName       = (String)  request.getAttribute("orderName");
  String customerName    = (String)  request.getAttribute("customerName");
  Integer orderReceiptId = (Integer) request.getAttribute("orderReceiptId");

  String successUrl      = (String)   request.getAttribute("successUrl");
  String failUrl         = (String)   request.getAttribute("failUrl");

  if (amount == null || orderId == null) {
%>
<script>
  alert("필수 결제 정보가 없습니다.");
  history.back();
</script>
<%
    return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head><meta charset="UTF-8"><title>결제 페이지</title>
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
  <h2>결제 테스트</h2>
  <p>주문번호: <%=orderId%> / 금액: <%=amount%>원</p>
  <button id="pay-button">결제하기</button>
  <script>
    const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");
    document.getElementById("pay-button").addEventListener("click", () => {
      tossPayments.requestPayment("카카오페이", {
        amount:       <%=amount%>,
        orderId:      '<%=orderId%>',
        orderName:    '<%=orderName%>',
        customerName: '<%=customerName%>',
        successUrl:   '<%=successUrl%>',
        failUrl:      '<%=failUrl%>'
      });
    });
  </script>
</body>
</html>
