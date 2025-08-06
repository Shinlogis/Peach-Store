<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, java.time.format.DateTimeFormatter, peachstore.domain.OrderView"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주문 관리 | PeachStore Admin</title>
<%@ include file="../inc/head_link.jsp"%>
<style>
/* (생략: 기존 스타일 그대로) */
.content-wrapper { background-color: #f8f9fa; }
.info-box-icon { display: flex; align-items: center; justify-content: center; }
.badge-status { font-size: 0.8rem; padding: 0.375rem 0.75rem; }
.order-info { display: flex; align-items: center; }
.order-id { width: 40px; height: 40px; border-radius: 8px; background: linear-gradient(45deg, #007bff, #6f42c1); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 12px; margin-right: 12px; }
.order-details h6 { margin: 0; font-size: 14px; font-weight: 600; }
.order-details small { color: #6c757d; font-size: 12px; }
.status-badge { border-radius: 20px; font-weight: 600; letter-spacing: 0.5px; }
.status-pending { background: linear-gradient(45deg, #ffc107, #fd7e14); color: white; border: none; }
.status-processing { background: linear-gradient(45deg, #17a2b8, #20c997); color: white; border: none; }
.status-completed { background: linear-gradient(45deg, #28a745, #20c997); color: white; border: none; }
.status-cancelled { background: linear-gradient(45deg, #dc3545, #e83e8c); color: white; border: none; }
.amount-display { font-weight: 600; font-size: 14px; color: #495057; }
.product-name { max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.table td { vertical-align: middle; }
.btn-action { padding: 0.25rem 0.75rem; font-size: 0.8rem; border-radius: 0.375rem; margin: 0 2px; }
.search-container { position: relative; }
.search-container .fas { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #6c757d; }
.search-input { padding-left: 45px; }
.filter-tabs { background: white; border-radius: 8px 8px 0 0; border-bottom: 1px solid #dee2e6; }
.filter-tabs .nav-link { border: none; border-radius: 0; color: #6c757d; font-weight: 500; }
.filter-tabs .nav-link.active { background: linear-gradient(45deg, #007bff, #6f42c1); color: white; border-radius: 8px 8px 0 0; }
@media ( max-width : 768px) {
	.info-box { margin-bottom: 1rem; }
	.table-responsive { font-size: 0.875rem; }
	.order-id { width: 35px; height: 35px; font-size: 10px; }
	.product-name { max-width: 150px; }
}
</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<%@ include file="../inc/navbar.jsp"%>
		<%@ include file="../inc/left_bar.jsp"%>

		<!-- Content Wrapper -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">주문 관리</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/admin/dashboard">대시보드</a></li>
								<li class="breadcrumb-item active">주문 관리</li>
							</ol>
						</div>
					</div>
				</div>
			</div>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<%
                List<OrderView> orderList = (List<OrderView>) request.getAttribute("orderList");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                
                int totalOrders = 0;
                int pendingOrders = 0;
                int processingOrders = 0;
                int completedOrders = 0;
                int cancelledOrders = 0;
                long totalAmount = 0;

                if (orderList != null) {
                    totalOrders = orderList.size();
                    for (OrderView o : orderList) {
                        totalAmount += o.getTotalAmount();
                        String status = o.getOrderStatus();
                        // === 상태명은 반드시 DB/서비스/프론트 일관성 주의!
                        if ("상품 준비 전".equals(status)) {
					    pendingOrders++;
					} else if ("상품 준비 중".equals(status)) {
					    processingOrders++;
					} else if ("발송완료".equals(status)) {
					    completedOrders++;
					} else if ("주문취소".equals(status)) {
					    cancelledOrders++;
					}
                    }
                }
                %>

					<!-- 통계 카드 -->
					<div class="row">
						<div class="col-lg-2 col-6">
							<div class="info-box">
								<span class="info-box-icon bg-info elevation-1"> <i class="fas fa-shopping-cart"></i> </span>
								<div class="info-box-content">
									<span class="info-box-text">전체 주문</span> <span class="info-box-number"><%= totalOrders %></span>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-6">
							<div class="info-box">
								<span class="info-box-icon bg-warning elevation-1"> <i class="fas fa-clock"></i> </span>
								<div class="info-box-content">
									<span class="info-box-text">대기중</span> <span class="info-box-number"><%= pendingOrders %></span>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-6">
							<div class="info-box">
								<span class="info-box-icon bg-primary elevation-1"> <i class="fas fa-truck"></i> </span>
								<div class="info-box-content">
									<span class="info-box-text">처리중</span> <span class="info-box-number"><%= processingOrders %></span>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-6">
							<div class="info-box">
								<span class="info-box-icon bg-success elevation-1"> <i class="fas fa-check-circle"></i> </span>
								<div class="info-box-content">
									<span class="info-box-text">완료</span> <span class="info-box-number"><%= completedOrders %></span>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-6">
							<div class="info-box">
								<span class="info-box-icon bg-danger elevation-1"> <i class="fas fa-ban"></i> </span>
								<div class="info-box-content">
									<span class="info-box-text">취소</span> <span class="info-box-number"><%= cancelledOrders %></span>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-12">
							<div class="info-box">
								<span class="info-box-icon bg-gradient-success elevation-1">
									<i class="fas fa-won-sign"></i>
								</span>
								<div class="info-box-content">
									<span class="info-box-text">총 주문 금액</span> <span class="info-box-number"><%= String.format("%,d", totalAmount) %><small>원</small></span>
								</div>
							</div>
						</div>
					</div>

					<!-- 주문 목록 카드 -->
					<div class="card">
						<!-- 필터 탭 -->
						<div class="filter-tabs">
							<ul class="nav nav-tabs" id="orderTabs" role="tablist">
							  <li class="nav-item"><button class="nav-link active" data-bs-target="#all" type="button">전체 주문</button></li>
							  <li class="nav-item"><button class="nav-link" data-bs-target="#pending" type="button">상품 준비 전</button></li>
							  <li class="nav-item"><button class="nav-link" data-bs-target="#processing" type="button">상품 준비 중</button></li>
							  <li class="nav-item"><button class="nav-link" data-bs-target="#completed" type="button">발송완료</button></li>
							  <li class="nav-item"><button class="nav-link" data-bs-target="#cancelled" type="button">주문취소</button></li>
							</ul>
						</div>

						<div class="card-header" style="border-top: none;">
							<h3 class="card-title">
								<i class="fas fa-shopping-cart mr-1"></i> 주문 현황
							</h3>
							<div class="card-tools">
								<div class="search-container">
									<i class="fas fa-search"></i> <input type="text" class="form-control search-input" placeholder="주문번호, 고객명, 상품명으로 검색..." id="searchInput" style="width: 350px;">
								</div>
							</div>
						</div>

						<div class="card-body">
							<% if (orderList != null && !orderList.isEmpty()) { %>
							<div class="table-responsive">
								<table class="table table-bordered table-striped" id="orderTable">
									<thead>
										<tr>
											<th>주문 정보</th>
											<th>고객명</th>
											<th>상품명</th>
											<th>수량</th>
											<th>총금액</th>
											<th>주문상태</th>
											<th>관리</th>
										</tr>
									</thead>
									<tbody>
									    <% for (OrderView o : orderList) { 
									        String status = o.getOrderStatus();
									        String statusClass = "";
									        if ("상품 준비 전".equals(status)) statusClass = "status-pending";
									        else if ("상품 준비 중".equals(status)) statusClass = "status-processing";
									        else if ("발송완료".equals(status)) statusClass = "status-completed";
									        else if ("주문취소".equals(status)) statusClass = "status-cancelled";
									
									        String orderIdStr = String.valueOf(o.getOrderReceiptId());
									        String shortOrderId = orderIdStr.length() >= 3 ? orderIdStr.substring(orderIdStr.length() - 3) : orderIdStr;
									    %>
									    <tr class="order-row" data-status="<%= status %>">
									        <td>
									            <div class="order-info">
									                <div class="order-id">
									                    #<%= shortOrderId %>
									                </div>
									                <div class="order-details">
									                    <h6>#<%= o.getOrderReceiptId() %></h6>
									                    <small class="text-muted"><%= o.getOrderDate().format(formatter) %></small>
									                </div>
									            </div>
									        </td>
									        <td><strong><%= o.getCustomerName() %></strong></td>
									        <td>
									            <div class="product-name" title="<%= o.getProductName() %>">
									                <%= o.getProductName() %>
									            </div>
									        </td>
									        <td><span class="badge badge-light"><%= o.getQuantity() %>개</span></td>
									        <td><span class="amount-display"><%= String.format("%,d원", o.getTotalAmount()) %></span></td>
									        <td>
									            <span class="badge status-badge <%= statusClass %>"><%= status %></span>
									        </td>
									        <td>
									            <div class="btn-group">
									                <button type="button"
									                    class="btn btn-secondary btn-action dropdown-toggle"
									                    data-toggle="dropdown">
									                    <i class="fas fa-cog mr-1"></i>상태변경
									                </button>
									                <div class="dropdown-menu">
									                    <a class="dropdown-item" href="#" onclick="updateOrderStatus('<%= o.getOrderReceiptId() %>', '상품 준비 전')">상품 준비 전</a>
									                    <a class="dropdown-item" href="#" onclick="updateOrderStatus('<%= o.getOrderReceiptId() %>', '상품 준비 중')">상품 준비 중</a>
									                    <a class="dropdown-item" href="#" onclick="updateOrderStatus('<%= o.getOrderReceiptId() %>', '발송완료')">발송완료</a>
									                    <div class="dropdown-divider"></div>
									                    <a class="dropdown-item text-danger" href="#" onclick="updateOrderStatus('<%= o.getOrderReceiptId() %>', '주문취소')">주문취소</a>
									                </div>
									            </div>
									        </td>
									    </tr>
									    <% } %>
									</tbody>

								</table>
							</div>
							<% } else { %>
							<div class="text-center py-5">
								<i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
								<h4 class="text-muted">주문 내역이 없습니다</h4>
								<p class="text-muted">아직 등록된 주문이 없습니다</p>
							</div>
							<% } %>
						</div>
					</div>
				</div>
			</section>
		</div>

		<%@ include file="../inc/footer.jsp"%>
	</div>
	<%@ include file="../inc/footer_link.jsp"%>

	<script type="text/javascript">
    $(document).ready(function() {
        // 검색 기능
        $('#searchInput').on('input', function() {
            const searchTerm = $(this).val().toLowerCase();
            $('.order-row').each(function() {
                const orderId = $(this).find('.order-details h6').text().toLowerCase();
                const customerName = $(this).find('td:nth-child(2)').text().toLowerCase();
                const productName = $(this).find('.product-name').text().toLowerCase();
                if (orderId.includes(searchTerm) || customerName.includes(searchTerm) || productName.includes(searchTerm)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        // 탭 필터링 (취소 탭까지 추가)
        $('.nav-link').on('click', function() {
		    const target = $(this).attr('data-bs-target');
		    $('.order-row').show();
		    if (target === '#pending') {
		        $('.order-row').each(function() {
		            if ($(this).data('status') !== '상품 준비 전') $(this).hide();
		        });
		    } else if (target === '#processing') {
		        $('.order-row').each(function() {
		            if ($(this).data('status') !== '상품 준비 중') $(this).hide();
		        });
		    } else if (target === '#completed') {
		        $('.order-row').each(function() {
		            if ($(this).data('status') !== '발송완료') $(this).hide();
		        });
		    } else if (target === '#cancelled') {
		        $('.order-row').each(function() {
		            if ($(this).data('status') !== '주문취소') $(this).hide();
		        });
		    }
		});

        // 테이블 애니메이션
        $('.order-row').hover(
            function() {
                $(this).addClass('table-hover');
            },
            function() {
                $(this).removeClass('table-hover');
            }
        );
    });


    // 주문 상태 업데이트
    function updateOrderStatus(orderId, newStatus) {
        Swal.fire({
            title: '주문 상태 변경',
            text: "주문 상태를 '" + newStatus + "'로 변경하시겠습니까?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#007bff',
            cancelButtonColor: '#dc3545',
            confirmButtonText: '네, 변경하겠습니다',
            cancelButtonText: '취소',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/admin/order/updateStatus',
                    type: 'POST',
                    data: {
                        orderId: orderId,
                        orderStatus: newStatus
                    },
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: '상태 변경 완료',
                            text: '주문 상태가 성공적으로 변경되었습니다.',
                            timer: 2000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // 페이지 새로고침
                        });
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: '오류 발생',
                            text: '상태 변경 중 오류가 발생했습니다.'
                        });
                    }
                });
            }
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
