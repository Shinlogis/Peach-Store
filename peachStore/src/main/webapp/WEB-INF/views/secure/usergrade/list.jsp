<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.peach.admin.domain.UserGrade" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 등급 목록</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
    <h1>사용자 등급 목록</h1>

    <%
        List<UserGrade> grades = (List<UserGrade>) request.getAttribute("grades");
        if (grades != null && !grades.isEmpty()) {
    %>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>등급 ID</th>
                    <th>등급명</th>
                    <th>할인율 (%)</th>
                    <th>등급 부여 기준</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (UserGrade grade : grades) {
                %>
                    <tr>
                        <td><%= grade.getUserGradeId() %></td>
                        <td><%= grade.getUserGradeName() %></td>
                        <td><%= grade.getDiscountRate() %></td>
                        <td><%= grade.getCriteriaAmount() %></td>
                        <td><button class="btn_edit" data-id="<%= grade.getUserGradeId()%>">수정</button></td>
                        <td><button class="btn_deactive" data-id="<%= grade.getUserGradeId()%>">삭제</button></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>표시할 사용자 등급이 없습니다.</p>
    <%
        }
    %>
    <button class="btn_regist">등록</button>
</body>
<script>
$(document).ready(function(){
	// 등록 버튼 클릭 이벤트
	$('.btn_regist').click(()=>{
		location.href = '/admin/usergrade/regist';
	});
	
	// 수정 버튼 클릭 이벤트
	$('.btn_edit').click(function(){
		let userGradeId = $(this).data('id'); // id값 추출
		location.href = '/admin/usergrade/edit?userGradeId='+userGradeId;
	});
	
	// 삭제 버튼 클릭 이벤트
	$('.btn_deactive').click(function(){
		let userGradeId = $(this).data('id');
		if (confirm("삭제하시겠습니까?")){
			$.ajax({
				url: '/admin/usergrade/deactive',
				type: 'post',
				data: {"userGradeId": userGradeId},
				success: function(result, status, xhr){
					if (result == 'success'){
						alert("삭제되었습니다.");
						location.reload(); // 목록 다시 불러오기
					} else{
						alert("삭제 중 오류가 발생했습니다.");
					}
				}
			});
		}
	});
	
});
</script>

</html>
