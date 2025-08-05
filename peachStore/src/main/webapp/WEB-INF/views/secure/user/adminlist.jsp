<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="peachstore.domain.Admin" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | 관리자 목록</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-item {
            background: white;
            padding: 25px 35px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            min-width: 160px;
            border-left: 5px solid #007bff;
            transition: all 0.3s;
        }

        .stat-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #007bff;
            display: block;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 15px;
            color: #666;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-item.active .stat-number {
            color: #28a745;
        }

        .stat-item.active {
            border-left-color: #28a745;
        }

        .stat-item.inactive .stat-number {
            color: #dc3545;
        }

        .stat-item.inactive {
            border-left-color: #dc3545;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding: 0 5px;
        }

        .search-box {
            position: relative;
            max-width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 15px 20px;
            padding-left: 50px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            background: white;
            transition: all 0.3s;
        }

        .search-input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .search-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }

        .add-btn {
            padding: 15px 30px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .add-btn:hover {
            background: linear-gradient(135deg, #0056b3, #004085);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
            color: white;
            text-decoration: none;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .table-header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 25px;
            text-align: center;
        }

        .table-header h3 {
            font-size: 22px;
            font-weight: 600;
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
            padding: 20px 15px;
            text-align: center;
            border-bottom: 2px solid #e9ecef;
            font-size: 16px;
        }

        td {
            padding: 20px 15px;
            text-align: center;
            border-bottom: 1px solid #f1f3f4;
            vertical-align: middle;
            font-size: 15px;
        }

        tr:hover {
            background: #f8f9ff;
            transition: background 0.2s;
        }

        .admin-name {
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }

        .admin-email {
            color: #666;
            font-size: 14px;
            margin-top: 4px;
        }

        .role-badge {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 25px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin {
            background: #e3f2fd;
            color: #1976d2;
        }

        .role-super {
            background: #fce4ec;
            color: #c2185b;
        }

        .role-moderator {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .status-active {
            color: #28a745;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 15px;
        }

        .status-inactive {
            color: #dc3545;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 15px;
        }

        .action-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-activate {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-activate:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }

        .btn-deactivate {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-deactivate:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #666;
        }

        .empty-state .empty-icon {
            font-size: 72px;
            margin-bottom: 20px;
            opacity: 0.6;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .empty-state p {
            font-size: 16px;
        }

        .content-header h1 {
            font-size: 32px;
            font-weight: 600;
            color: #333;
        }

        .content-header .breadcrumb-item {
            font-size: 15px;
        }

        .content-wrapper {
            background: #f4f6f9;
        }

        .container-fluid {
            padding: 0 25px;
        }

        @media (max-width: 768px) {
            .stats-bar {
                flex-wrap: wrap;
                gap: 15px;
                justify-content: space-around;
            }

            .stat-item {
                min-width: 140px;
                padding: 20px 25px;
            }

            .action-bar {
                flex-direction: column;
                gap: 20px;
                align-items: stretch;
            }

            .search-box {
                max-width: 100%;
            }

            .container-fluid {
                padding: 0 15px;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 15px 10px;
            }

            .add-btn {
                padding: 12px 25px;
                font-size: 15px;
            }
        }

        .loading {
            opacity: 0.6;
            pointer-events: none;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <%@ include file="../inc/navbar.jsp" %>
    <%@ include file="../inc/left_bar.jsp" %>

    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">👥 PeachStore 관리자 목록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">관리자 관리 > 관리자 목록</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <p class="text-muted" style="font-size: 16px; margin-top: 10px;">
                            시스템 관리자들을 관리하고 권한을 설정할 수 있습니다
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <section class="content">
            <div class="container-fluid">
                <%
                List<peachstore.domain.Admin> adminList = (List<peachstore.domain.Admin>)request.getAttribute("adminList");
                int totalAdmins = 0;
                int activeAdmins = 0;
                int inactiveAdmins = 0;
                
                if(adminList != null) {
                    totalAdmins = adminList.size();
                    for(Admin a : adminList) {
                        if(a.isActive()) {
                            activeAdmins++;
                        } else {
                            inactiveAdmins++;
                        }
                    }
                }
                %>

                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number"><%= totalAdmins %></div>
                        <div class="stat-label">전체 관리자</div>
                    </div>
                    <div class="stat-item active">
                        <div class="stat-number"><%= activeAdmins %></div>
                        <div class="stat-label">활성 상태</div>
                    </div>
                    <div class="stat-item inactive">
                        <div class="stat-number"><%= inactiveAdmins %></div>
                        <div class="stat-label">비활성 상태</div>
                    </div>
                </div>

                <div class="action-bar">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" class="search-input" placeholder="관리자 검색..." id="searchInput">
                    </div>
                    <a href="/admin/user/registform" class="add-btn">
                        ➕ 새 관리자 추가
                    </a>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <h3>관리자 계정 현황</h3>
                    </div>
                    
                    <% if(adminList != null && !adminList.isEmpty()) { %>
                    <table id="adminTable">
                        <thead>
                            <tr>
                                <th>👤 이름</th>
                                <th>📧 이메일</th>  
                                <th>🔐 권한</th>
                                <th>📊 상태</th>
                                <th>⚙️ 관리</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (Admin a : adminList) { %>
                            <tr class="admin-row">
                                <td>
                                    <div class="admin-name"><%= a.getAdminName() %></div>
                                </td>
                                <td>
                                    <div class="admin-email"><%= a.getEmail() %></div>
                                </td>
                                <td>
                                    <span class="role-badge role-<%= a.getRole().toLowerCase() %>">
                                        <%= a.getRole() %>
                                    </span>
                                </td>
                                <td>
                                    <% if(a.isActive()) { %>
                                        <div class="status-active">
                                            <span>🟢</span> 활성
                                        </div>
                                    <% } else { %>
                                        <div class="status-inactive">
                                            <span>🔴</span> 비활성
                                        </div>
                                    <% } %>
                                </td>
                                <td>
                                    <form action="/admin/user/setactive" method="post" style="display:inline;" class="status-form">
                                        <input type="hidden" name="adminId" value="<%= a.getAdminId() %>" />
                                        <input type="hidden" name="isActive" value="<%= a.isActive() ? "false" : "true" %>" />
                                        <button
                                            type="submit"
                                            class="action-btn <%= a.isActive() ? "btn-deactivate" : "btn-activate" %>"
                                            data-admin-name="<%= a.getAdminName() %>"
                                            data-admin-active="<%= a.isActive() %>"
                                            onclick="return confirmAction(this)">
                                            <%= a.isActive() ? "🚫 비활성화" : "✅ 활성화" %>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon">👥</div>
                            <h3>등록된 관리자가 없습니다</h3>
                            <p>새로운 관리자를 추가해보세요</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </section>
    </div>

    <%@ include file="../inc/footer.jsp" %>
</div>
<%@ include file="../inc/footer_link.jsp" %>

<script>
    // 검색 기능
    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = document.querySelectorAll('.admin-row');
        
        rows.forEach(row => {
            const name = row.querySelector('.admin-name').textContent.toLowerCase();
            const email = row.querySelector('.admin-email').textContent.toLowerCase();
            
            if (name.includes(searchTerm) || email.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // 상태 변경 확인
    function confirmAction(btn) {
        var adminName = btn.getAttribute('data-admin-name') || '';
        var isActive = btn.getAttribute('data-admin-active') === 'true';
        var action = isActive ? '비활성화' : '활성화';
        return confirm("정말로 '" + adminName + "' 관리자를 " + action + "하시겠습니까?");
    }

    // 폼 제출 시 로딩 상태
    document.querySelectorAll('.status-form').forEach(form => {
        form.addEventListener('submit', function() {
            const button = this.querySelector('.action-btn');
            button.style.opacity = '0.6';
            button.style.pointerEvents = 'none';
            button.innerHTML = '⏳ 처리 중...';
        });
    });

    // 테이블 행 클릭 효과
    document.querySelectorAll('.admin-row').forEach(row => {
        row.addEventListener('click', function(e) {
            if (!e.target.matches('button') && !e.target.closest('form')) {
                this.style.background = '#f0f7ff';
                setTimeout(() => {
                    this.style.background = '';
                }, 200);
            }
        });
    });
</script>
</body>
</html>