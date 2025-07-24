<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.peach.admin.dto.GradeCouponDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>쿠폰 목록</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
    <h1>쿠폰 목록</h1>

    <%
        List<GradeCouponDTO> gradeCoupons = (List<GradeCouponDTO>) request.getAttribute("gradeCoupons");
        if (gradeCoupons != null && !gradeCoupons.isEmpty()) {
    %>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>등급별쿠폰 ID</th>
                    <th>등급</th>
                    <th>쿠폰명</th>
                    <th>발급 기준</th>
                    <th>사용 조건</th>
                    <th>할인 한도</th>
                    <th>유효 기간</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (GradeCouponDTO dto : gradeCoupons) {
                %>
                    <tr>
                        <td><%= dto.getGradeCouponId() %></td>
                        <td><%= dto.getUserGradeId() %></td>
                        <td><%= dto.getCouponName() %></td>
                        <td><%= dto.getIssueRule() %></td>
                        <td><%= dto.getUseCondition() %></td>
                        <td><%= dto.getDiscountAmount() %></td>
                        <td><%= dto.getValidDays() %></td>
                        <td><button class="btn_edit" data-id="<%= dto.getGradeCouponId() %>">수정</button></td>
                        <td><button class="btn_deactive" data-id="<%= dto.getGradeCouponId() %>">삭제</button></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>표시할 쿠폰이 없습니다.</p>
    <%
        }
    %>
    <button class="btn_regist">등록</button>
</body>

<script>
$(document).ready(function(){
	// 등록 버튼 클릭 이벤트
	$('.btn_regist').click(() => {
		location.href = '/admin/gradeCoupon/regist';
	});

	// 수정 버튼 클릭 이벤트
	$('.btn_edit').click(function(){
		let couponId = $(this).data('id'); // id 추출
		location.href = '/admin/usergrade/edit?couponId=' + couponId;
	});

	// 삭제 버튼 클릭 이벤트
	$('.btn_deactive').click(function(){
		let couponId = $(this).data('id'); // id 추출
		if (confirm("삭제하시겠습니까?")){
			$.ajax({
				url: '/admin/usergrade/deactive',
				type: 'post',
				data: { couponId: couponId },
				success: function(result, status, xhr){
					if (result === 'success'){
						alert("삭제되었습니다.");
						location.reload();
					} else {
						alert("삭제 중 오류가 발생했습니다.");
					}
				}
			});
		}
	});
});
</script>
</html>
