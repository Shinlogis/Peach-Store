<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, peachstore.domain.Admin" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 목록</title>
    <%@ include file="../inc/head_link.jsp" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f3f6fa;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h2 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            color: #666;
            font-size: 14px;
        }

        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-item {
            background: white;
            padding: 15px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
            min-width: 120px;
        }

        .stat-number {
            font-size: 24px;
            font-weight: 700;
            color: #667eea;
        }

        .stat-label {
            font-size: 12px;
            color: #666;
            margin-top: 4px;
        }

        .table-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.07);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .table-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .table-header h3 {
            font-size: 18px;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
            padding: 16px 12px;
            text-align: center;
            border-bottom: 2px solid #e9ecef;
            font-size: 14px;
        }

        td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid #f1f3f4;
            vertical-align: middle;
        }

        tr:hover {
            background: #f8f9ff;
            transition: background 0.2s;
        }

        .admin-name {
            font-weight: 600;
            color: #333;
        }

        .admin-email {
            color: #666;
            font-size: 13px;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
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
            color: #2e7d32;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .status-inactive {
            color: #d32f2f;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-activate {
            background: linear-gradient(135deg, #4caf50, #45a049);
            color: white;
        }

        .btn-activate:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .btn-deactivate {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            color: white;
        }

        .btn-deactivate:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state .empty-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 8px;
        }

        .empty-state p {
            font-size: 14px;
        }

        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 0 10px;
        }

        .search-box {
            position: relative;
            max-width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 10px 16px;
            padding-left: 40px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 14px;
            background: white;
        }

        .search-input:focus {
            border-color: #667eea;
            outline: none;
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .add-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.3);
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }

            .stats-bar {
                flex-wrap: wrap;
                gap: 10px;
            }

            .stat-item {
                min-width: 100px;
                padding: 12px 20px;
            }

            table {
                font-size: 13px;
            }

            th, td {
                padding: 12px 8px;
            }

            .action-bar {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .search-box {
                max-width: 100%;
            }
        }

        .loading {
            opacity: 0.6;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>👥 PeachStore 관리자 목록</h2>
            <p>시스템 관리자들을 관리하고 권한을 설정할 수 있습니다</p>
        </div>

        <%
        List<peachstore.domain.Admin> adminList = (List<peachstore.domain.Admin>)request.getAttribute("adminList");
        int totalAdmins = 0;
        int activeAdmins = 0;
        int inactiveAdmins = 0;
        
        if(adminList != null) {
            totalAdmins = adminList.size();
            for(peachstore.domain.Admin admin : adminList) {
                if(admin.isActive()) {
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
            <div class="stat-item">
                <div class="stat-number" style="color: #4caf50;"><%= activeAdmins %></div>
                <div class="stat-label">활성 상태</div>
            </div>
            <div class="stat-item">
                <div class="stat-number" style="color: #f44336;"><%= inactiveAdmins %></div>
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
                <% for (peachstore.domain.Admin admin : adminList) { %>
                    <tr class="admin-row">
                        <td>
                            <div class="admin-name"><%= admin.getAdminName() %></div>
                        </td>
                        <td>
                            <div class="admin-email"><%= admin.getEmail() %></div>
                        </td>
                        <td>
                            <span class="role-badge role-<%= admin.getRole().toLowerCase() %>">
                                <%= admin.getRole() %>
                            </span>
                        </td>
                        <td>
                            <% if(admin.isActive()) { %>
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
                                <input type="hidden" name="adminId" value="<%= admin.getAdminId() %>" />
                                <input type="hidden" name="isActive" value="<%= admin.isActive() ? "false" : "true" %>" />
								<button
								    type="submit"
								    class="action-btn <%= admin.isActive() ? "btn-deactivate" : "btn-activate" %>"
								    data-admin-name="<%= admin.getAdminName() %>"
								    data-admin-active="<%= admin.isActive() %>"
								    onclick="return confirmAction(this)">
								    <%= admin.isActive() ? "🚫 비활성화" : "✅ 활성화" %>
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