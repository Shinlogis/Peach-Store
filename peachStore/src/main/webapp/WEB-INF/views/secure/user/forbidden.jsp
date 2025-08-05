<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String msg = (String) request.getAttribute("msg");
    String url = (String) request.getAttribute("url");
%>
<script>
    alert("<%=msg%>");
    location.href="<%=url%>";
</script>