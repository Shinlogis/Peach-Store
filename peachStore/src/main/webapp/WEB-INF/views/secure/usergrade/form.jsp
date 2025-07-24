<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원 등급 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>회원 등급 등록</h2>
	 <form id="userGradeForm">
	    <input type="hidden" name="userGradeId" value="${userGrade.userGradeId}"/>
	
	    <label>등급명</label><br/>
	    <input type="text" name="userGradeName" value="${userGrade.userGradeName}" required/><br/><br/>
	
	    <label>등급 기준 금액</label><br/>
	    <input type="text" name="criteriaAmount" value="${userGrade.criteriaAmount}" required/><br/><br/>
	
	    <label>할인율</label><br/>
	    <input type="number" name="discountRate" value="${userGrade.discountRate}" required/><br/><br/>
	
	    <button type="button" id="btnSave">저장</button>
	</form>

    <script>
        $(document).ready(function(){ // 페이지가 다 로드된 후에 실행
            $('#btnSave').click(function(){
                $('#userGradeForm').attr({
                    action: '/admin/usergrade/save',
                    method: 'post'
                });
                $('#userGradeForm').submit();
            });
        });
    </script>
</body>
</html>
