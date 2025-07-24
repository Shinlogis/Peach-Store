<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>쿠폰 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>쿠폰 등록</h2>
	 <form id="gradeCouponForm">
	    <input type="hidden" name="gradeCouponId" value="${gradeCouponDTO.gradeCouponId}"/>
	
	    <label>등급 기준</label><br/>
	    <select name="userGradeId" id="userGradeName" required>
	    </select><br/><br/>
	
	    <label>쿠폰 이름</label><br/>
	    <input type="text" name="couponName" value="${gradeCouponDTO.couponName}" required/><br/><br/>
	
	    <label>발급 조건</label><br/>
	    <input type="text" name="issueRule" value="${gradeCouponDTO.issueRule}" required/><br/><br/>
	    
	    <label>사용 조건</label><br/>
	    <input type="text" name="useCondition" value="${gradeCouponDTO.useCondition}" required/><br/><br/>
	    
	    <label>할인 한도</label><br/>
	    <input type="number" name="discountAmount" value="${gradeCouponDTO.discountAmount}" required/><br/><br/>
	    
	    <label>유효기간</label><br/>
	    <input type="date" name="validDays" value="${gradeCouponDTO.validDays}" required/><br/><br/>
	
	    <button type="button" id="btnSave">저장</button>
	</form>

    <script>
        $(document).ready(function(){
        	
        	// 
        	
            $('#btnSave').click(function(){
                $('#gradeCouponForm').attr({
                    action: '/admin/gradeCoupon/save',
                    method: 'post'
                });
                $('#gradeCouponForm').submit();
            });
        });
        
        // 화면에 등급명을 출력하는 메서드
        function printUserGradeName(obj, list){
        	let tag="<option value='0'>등급 선택</option>";
        	
        	for (let i=0; i<list.length; i++){
				tag+="<option value='"+list[i]. userGradeId+"'>"+list[i].userGradeName+"</option>";
        	}
        }
        
        // 등급명 목록 가져오기
        function getUserGradeName(){
        	$.ajax({
        		url: "/admin/grade/list",
        		type: "get",
        		success: function(result, status, xhr){
        			printUserGradeName("#userGradeName", result);
        		}
        	});
        }
    </script>
</body>
</html>
