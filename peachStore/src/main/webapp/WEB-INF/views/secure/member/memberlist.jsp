<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, peachstore.domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 관리 | PeachStore Admin</title>
    <%@ include file="../inc/head_link.jsp" %>
    
    <style>
        .content-wrapper {
            background-color: #f8f9fa;
        }
        
        .info-box-icon {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .badge-status {
            font-size: 0.8rem;
            padding: 0.375rem 0.75rem;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(45deg, #007bff, #6f42c1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 14px;
            margin-right: 10px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
        }
        
        .user-details h6 {
            margin: 0;
            font-size: 14px;
            font-weight: 600;
        }
        
        .user-details small {
            color: #6c757d;
            font-size: 12px;
        }
        
        .grade-badge {
            background: linear-gradient(45deg, #17a2b8, #20c997);
            color: white;
            border: none;
        }
        
        .provider-badge {
            background: linear-gradient(45deg, #6f42c1, #e83e8c);
            color: white;
            border: none;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        .btn-action {
            padding: 0.25rem 0.75rem;
            font-size: 0.8rem;
            border-radius: 0.375rem;
        }
        
        .search-container {
            position: relative;
        }
        
        .search-container .fas {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .search-input {
            padding-left: 45px;
        }
        
        @media (max-width: 768px) {
            .info-box {
                margin-bottom: 1rem;
            }
            
            .table-responsive {
                font-size: 0.875rem;
            }
            
            .user-avatar {
                width: 30px;
                height: 30px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%@ include file="../inc/navbar.jsp" %>
    <%@ include file="../inc/left_bar.jsp" %>

    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">회원 관리</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="/admin/dashboard">대시보드</a></li>
                            <li class="breadcrumb-item active">회원 관리</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <%
                List<User> userList = (List<User>) request.getAttribute("userList");
                int total = 0;
                int active = 0;
                int inactive = 0;

                if (userList != null) {
                    total = userList.size();
                    for (User u : userList) {
                        if (u.is_active()) active++;
                        else inactive++;
                    }
                }
                %>

                <!-- 통계 카드 -->
                <div class="row">
                    <div class="col-lg-4 col-6">
                        <div class="info-box">
                            <span class="info-box-icon bg-info elevation-1">
                                <i class="fas fa-users"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">전체 회원</span>
                                <span class="info-box-number"><%= total %></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-6">
                        <div class="info-box">
                            <span class="info-box-icon bg-success elevation-1">
                                <i class="fas fa-user-check"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">활성 회원</span>
                                <span class="info-box-number"><%= active %></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-6">
                        <div class="info-box">
                            <span class="info-box-icon bg-warning elevation-1">
                                <i class="fas fa-user-times"></i>
                            </span>
                            <div class="info-box-content">
                                <span class="info-box-text">비활성 회원</span>
                                <span class="info-box-number"><%= inactive %></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 회원 목록 카드 -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-users mr-1"></i>
                            회원 계정 현황
                        </h3>
                        <div class="card-tools">
                            <div class="search-container">
                                <i class="fas fa-search"></i>
                                <input type="text" class="form-control search-input" placeholder="이름 또는 이메일로 검색..." id="searchInput" style="width: 300px;">
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <% if (userList != null && !userList.isEmpty()) { %>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped" id="memberTable">
                                <thead>
                                    <tr>
                                        <th>회원 정보</th>
                                        <th>전화번호</th>
                                        <th>등급</th>
                                        <th>가입일</th>
                                        <th>가입경로</th>
                                        <th>상태</th>
                                        <th>관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (User u : userList) { %>
                                        <tr class="user-row">
                                            <td>
                                                <div class="user-info">
                                                    <div class="user-avatar">
                                                        <%= u.getUser_name().substring(0, 1).toUpperCase() %>
                                                    </div>
                                                    <div class="user-details">
                                                        <h6><%= u.getUser_name() %></h6>
                                                        <small class="text-muted"><%= u.getEmail() %></small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= u.getTel() %></td>
                                            <td>
                                                <span class="badge grade-badge">
                                                    <%= u.getUser_grade() != null ? u.getUser_grade().getUserGradeName() : "일반" %>
                                                </span>
                                            </td>
                                            <td>
                                                <small><%= u.getCreated_at() %></small>
                                            </td>
                                            <td>
                                                <span class="badge provider-badge">
                                                    <%= u.getSns_provider() != null ? u.getSns_provider().getProvider_name() : "일반 가입" %>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge badge-status <%= u.is_active() ? "badge-success" : "badge-danger" %>">
                                                    <i class="fas fa-<%= u.is_active() ? "check" : "times" %> mr-1"></i>
                                                    <%= u.is_active() ? "활성" : "비활성" %>
                                                </span>
                                            </td>
                                            <td>
                                                <form action="/admin/member/setactive" method="post" style="display:inline;" class="status-form">
                                                    <input type="hidden" name="user_id" value="<%= u.getUser_id() %>" />
                                                    <input type="hidden" name="is_active" value="<%= !u.is_active() %>" />
                                                    <button 
                                                        type="submit" 
                                                        class="btn btn-action <%= u.is_active() ? "btn-warning" : "btn-success" %>"
                                                        data-user-name="<%= u.getUser_name() %>"
                                                        data-user-active="<%= u.is_active() %>"
                                                        onclick="return confirmAction(this)">
                                                        <i class="fas fa-<%= u.is_active() ? "user-slash" : "user-check" %> mr-1"></i>
                                                        <%= u.is_active() ? "비활성화" : "활성화" %>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">등록된 회원이 없습니다</h4>
                                <p class="text-muted">아직 가입한 회원이 없습니다</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <%@ include file="../inc/footer.jsp" %>
</div>
<%@ include file="../inc/footer_link.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        // 검색 기능
        $('#searchInput').on('input', function() {
            const searchTerm = $(this).val().toLowerCase();
            $('.user-row').each(function() {
                const name = $(this).find('.user-details h6').text().toLowerCase();
                const email = $(this).find('.user-details small').text().toLowerCase();
                
                if (name.includes(searchTerm) || email.includes(searchTerm)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        // 폼 제출 시 로딩 상태
        $('.status-form').on('submit', function(e) {
            e.preventDefault();
            const form = this;
            const button = $(this).find('.btn-action');
            const originalText = button.html();
            
            button.prop('disabled', true);
            button.html('<i class="fas fa-spinner fa-spin mr-1"></i>처리 중...');
            
            // 실제로는 AJAX로 처리하거나 폼을 제출
            setTimeout(() => {
                form.submit();
            }, 500);
        });

        // 테이블 애니메이션
        $('.user-row').hover(
            function() {
                $(this).addClass('table-hover');
            },
            function() {
                $(this).removeClass('table-hover');
            }
        );
    });

    // 상태 변경 확인 (SweetAlert2 사용)
    function confirmAction(btn) {
        const userName = btn.getAttribute('data-user-name') || '';
        const isActive = btn.getAttribute('data-user-active') === 'true';
        const action = isActive ? '비활성화' : '활성화';
        const icon = isActive ? 'warning' : 'question';
        const confirmButtonColor = isActive ? '#f39c12' : '#28a745';
        
        Swal.fire({
            title: '회원 상태 변경',
            text: `정말로 '${userName}' 회원을 ${action}하시겠습니까?`,
            icon: icon,
            showCancelButton: true,
            confirmButtonColor: confirmButtonColor,
            cancelButtonColor: '#dc3545',
            confirmButtonText: `네, ${action}하겠습니다`,
            cancelButtonText: '취소',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                $(btn).closest('form').submit();
            }
        });
        
        return false; // 기본 폼 제출 방지
    }

    // 성공/에러 메시지 표시 (필요시 사용)
    function showAlert(type, title, message) {
        Swal.fire({
            icon: type,
            title: title,
            text: message,
            timer: 3000,
            showConfirmButton: false,
            toast: true,
            position: 'top-end'
        });
    }
</script>

</body>
</html>