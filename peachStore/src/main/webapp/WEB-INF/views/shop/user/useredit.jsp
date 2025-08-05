<%@page import="peachstore.domain.OrderReceipt"%>
<%@page import="peachstore.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProductTopcategory> topList = (List<ProductTopcategory>) request.getAttribute("topList");
	/* useGrade를 그냥 user로 사용하면 됨 */
	User userGrade = (User) request.getAttribute("userGrade");
	Integer reviewCount = (Integer) request.getAttribute("reviewCount");
	List<OrderReceipt> order = (List<OrderReceipt>) request.getAttribute("receiptList");
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <title>회원정보</title>
    <%@ include file="../inc/head_link.jsp" %>
    <link rel="stylesheet" href="/static/shop/css/mypage.css" />
    <style>
        .regist_content {
            margin-top: 70px;
            width: 1050px;
            padding-left: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table td, table th {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .label {
            font-weight: bold;
            width: 25%;
            background-color: #f5f5f5;
        }
        .btn-edit {
            padding: 4px 12px;
            font-size: 14px;
            background-color: #d9534f;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn-edit:hover {
            background-color: #c9302c;
        }
        .header-container {
            display: flex; 
            justify-content: space-between; 
            border-bottom: 2px solid black; 
            margin-bottom: 20px;
            align-items: center;
        }
    </style>
</head>

<body>
    <%@ include file="../inc/preloader.jsp" %>
    <%@ include file="../inc/offcanvas.jsp" %>
    <%@ include file="../inc/header.jsp" %>
    <div class="wrapper1">
        <%@ include file="../inc/mypage_category.jsp" %>
        <div>
			<div class="wrapper2">
				<%@include file="../inc/mypage_review_coupon.jsp"%>
			</div>

       <form method="post" action="/shop/user/edit" style="margin: 0;">
        <section class="shop-cart spad regist_content" style="margin-top: 30px;">
            <div class="header-container">
                <h3 class="card-title" style="font-weight: bold;">내 정보</h3>
					<button type="submit" class="btn-edit" onclick="return confirm('회원정보를 수정하시겠습니까?');">확인요청</button>
            </div>
		<input type="hidden" name="user_grade_id" value="<%= userGrade != null ? userGrade.getUser_grade().getUserGradeId() : "" %>" />
            <table>
                <tbody>
                    <tr>
                        <td class="label">아이디</td>
                        <td><%= userGrade != null ? userGrade.getUser_id() : "" %></td>
                    </tr>
                    <tr>
                        <td class="label">이름</td>
                        <td><%= userGrade != null ? userGrade.getUser_name() : "" %></td>
                    </tr>
                    <tr>
                        <td class="label">이메일</td>
                        <td><%= userGrade != null ? userGrade.getEmail() : "" %></td>
                    </tr>
                    <tr>
                        <td class="label">전화번호</td>
                    <td>
                        <input type="text" name="user_tel" value="<%= userGrade != null ? userGrade.getTel() : "" %>" 
                               style="width: 100%; padding: 6px; box-sizing: border-box;" />
                    </td>
                    </tr>
                    <tr>
                        <td class="label">주소</td>
                        <td>                  
                        	<input type="text" name="user_address" value="<%= userGrade != null ? userGrade.getAddress() : "" %>" 
                               style="width: 100%; padding: 6px; box-sizing: border-box;" /></td>
                    </tr>
                    
                    <!-- 필요한 다른 정보 있으면 추가 가능 -->
                </tbody>
            </table>
        </section>
       </form>
        </div>
    </div>

    <%@ include file="../inc/footer.jsp" %>
    <%@ include file="../inc/search.jsp" %>
    <%@ include file="../inc/footer_link.jsp" %>
</body>

</html>
