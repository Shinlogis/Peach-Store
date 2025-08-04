<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, peachstore.domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <%@ include file="../inc/head_link.jsp" %>
    <link rel="stylesheet" href="/static/shop/css/main/login.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        body {
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-section {
            padding: 40px 0px 50px;
            min-height: 100vh;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #494949;
            margin-bottom: 10px;
        }

        .page-subtitle {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 40px;
        }

        .container {
            max-width: 1200px;
			width: 100%;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 통계 카드 스타일 */
        .stats-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 20px 30px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-width: 150px;
            border: 1px solid #e0e0e0;
        }

        .stat-number {
            font-size: 24px;
            font-weight: 600;
            color: #494949;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
        }

        .stat-active .stat-number {
            color: #4CAF50;
        }

        .stat-inactive .stat-number {
            color: #f44336;
        }

        /* 액션 바 스타일 */
        .action-bar {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 30px;
            gap: 20px;
        }

        .search-container {
            flex: 1;
            max-width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background: white;
        }

        .search-input:focus {
            outline: none;
            border-color: #4CAF50;
        }

        /* 테이블 컨테이너 */
		.table-wrapper {
			width: 100%;      
			margin: 0 auto;  
			margin-right: auto;
		    background: white;
		    border-radius: 8px;
		    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
		    border: 1px solid #e0e0e0;
		    margin: 0 auto;


		}

        .table-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #e0e0e0;
        }

        .table-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #494949;
            text-align: left;
        }

		table {
		    width: 100%;
		    border-collapse: collapse;
		    background: white;
		}

        th {
            background: #f8f9fa;
            color: #494949;
            font-weight: 600;
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            font-size: 14px;
        }

        td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
            font-size: 13px;
        }

        tr:hover {
            background: #f9f9f9;
        }

        .user-name {
            font-weight: 500;
            color: #494949;
        }

        .user-email {
            color: #666;
            font-size: 12px;
        }

        /* 배지 스타일 */
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-active {
            background: #e8f5e8;
            color: #4CAF50;
            border: 1px solid #4CAF50;
        }

        .badge-inactive {
            background: #ffebee;
            color: #f44336;
            border: 1px solid #f44336;
        }

        .grade-badge {
			width: 120px;      
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;s
            font-size: 11px;
            font-weight: 500;
            background: #e3f2fd;
            color: #1976d2;
        }

        .provider-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: 500;
            background: #f3e5f5;
            color: #7b1fa2;
        }

        /* 버튼 스타일 */
        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            min-width: 80px;
        }

        .btn-activate {
            background: #4CAF50;
            color: white;
        }

        .btn-activate:hover {
            background: #45a049;
        }

        .btn-deactivate {
            background: #f44336;
            color: white;
        }

        .btn-deactivate:hover {
            background: #d32f2f;
        }

        /* 빈 상태 스타일 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #494949;
            margin-bottom: 8px;
        }

        .empty-state p {
            font-size: 14px;
            color: #666;
        }

        /* 반응형 디자인 */
        @media (max-width: 1024px) {
            .container {
                padding: 0 15px;
            }
            
            table {
                font-size: 12px;
            }
            
            th, td {
                padding: 10px 8px;
            }
            
            .action-btn {
                padding: 6px 12px;
                font-size: 11px;
                min-width: 70px;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 24px;
                margin-bottom: 8px;
            }

            .page-subtitle {
                font-size: 13px;
                margin-bottom: 30px;
            }

            .stats-container {
                gap: 15px;
            }

            .stat-card {
                min-width: 120px;
                padding: 15px 20px;
            }

            .action-bar {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }

            .search-container {
                max-width: 100%;
            }

            /* 모바일에서 테이블 스크롤 */
            .table-wrapper {
                overflow-x: auto;
            }

            table {
                min-width: 800px;
                font-size: 11px;
            }

            th, td {
                padding: 8px 6px;
                white-space: nowrap;
            }

            .action-btn {
                padding: 5px 10px;
                font-size: 10px;
                min-width: 60px;
            }
        }

        .loading {
            opacity: 0.6;
            pointer-events: none;
        }
		
		th:nth-child(4), td:nth-child(4) { /* 등급 */
		    max-width: 120px;
		    min-width: 100px;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		th:nth-child(6), td:nth-child(6) { /* 가입경로 */
		    max-width: 210px;
		    min-width: 140px;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		th, td {
		    white-space: normal;    /* nowrap 대신 normal로! */
		    overflow: hidden;       /* 말줄임 할 거 아니면 생략 가능 */
		    text-overflow: ellipsis;/* 필요시 */
		    /* 필요하다면 max-width: 200px; */
		}
		.grade-badge, .provider-badge {
		    display: inline-block;
		    white-space: normal;  /* 줄바꿈 허용 */
		    word-break: break-all;/* 영어/숫자 길게 오면 자동 끊김 */
		    max-width: 100%;
		}
    </style>
</head>
<body>
    <section class="main-section">
        <div class="page-title">PeachStore 회원 관리</div>
        <div class="page-subtitle">등록된 전체 회원 정보를 확인하고 관리할 수 있습니다</div>
        
        <div class="container">
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

            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-number"><%= total %></div>
                    <div class="stat-label">전체 회원</div>
                </div>
                <div class="stat-card stat-active">
                    <div class="stat-number"><%= active %></div>
                    <div class="stat-label">활성 회원</div>
                </div>
                <div class="stat-card stat-inactive">
                    <div class="stat-number"><%= inactive %></div>
                    <div class="stat-label">비활성 회원</div>
                </div>
            </div>

            <div class="action-bar">
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="이름 또는 이메일로 검색..." id="searchInput">
                </div>
            </div>

            <div class="table-wrapper">
                <div class="table-header">
                    <h3>회원 계정 현황</h3>
                </div>
                
                <% if (userList != null && !userList.isEmpty()) { %>
                <table id="memberTable">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>이메일</th>
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
                                    <div class="user-name"><%= u.getUser_name() %></div>
                                </td>
                                <td>
                                    <div class="user-email"><%= u.getEmail() %></div>
                                </td>
                                <td><%= u.getTel() %></td>
                                <td>
                                   <span class="grade-badge"><%= u.getUser_grade() != null ? u.getUser_grade().getUserGradeName() : "" %></span>
                                </td>
                                <td><%= u.getCreated_at() %></td>
                                <td>
									<span class="provider-badge">
									  <%= u.getSns_provider() != null ? u.getSns_provider().getProvider_name() : "" %>
									</span>
                                </td>
                                <td>
                                    <span class="badge <%= u.is_active() ? "badge-active" : "badge-inactive" %>">
                                        <i class="fa fa-<%= u.is_active() ? "check-circle" : "times-circle" %>"></i>
                                        <%= u.is_active() ? "활성" : "비활성" %>
                                    </span>
                                </td>
                                <td>
                                    <form action="/admin/member/setactive" method="post" style="display:inline;" class="status-form">
                                        <input type="hidden" name="user_id" value="<%= u.getUser_id() %>" />
                                        <input type="hidden" name="is_active" value="<%= !u.is_active() %>" />
                                        <button 
                                            type="submit" 
                                            class="action-btn <%= u.is_active() ? "btn-deactivate" : "btn-activate" %>"
                                            data-user-name="<%= u.getUser_name() %>"
                                            data-user-active="<%= u.is_active() %>"
                                            onclick="return confirmAction(this)">
                                            <%= u.is_active() ? "비활성화" : "활성화" %>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                    <div class="empty-state">
                        <h3>등록된 회원이 없습니다</h3>
                        <p>아직 가입한 회원이 없습니다</p>
                    </div>
                <% } %>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        $(document).ready(function() {
            // 검색 기능
            $('#searchInput').on('input', function() {
                const searchTerm = $(this).val().toLowerCase();
                $('.user-row').each(function() {
                    const name = $(this).find('.user-name').text().toLowerCase();
                    const email = $(this).find('.user-email').text().toLowerCase();
                    
                    if (name.includes(searchTerm) || email.includes(searchTerm)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            });

            // 폼 제출 시 로딩 상태
            $('.status-form').on('submit', function() {
                const button = $(this).find('.action-btn');
                button.addClass('loading');
                button.text('처리 중...');
            });
        });

        // 상태 변경 확인
        function confirmAction(btn) {
            var userName = btn.getAttribute('data-user-name') || '';
            var isActive = btn.getAttribute('data-user-active') === 'true';
            var action = isActive ? '비활성화' : '활성화';
            return confirm("정말로 '" + userName + "' 회원을 " + action + "하시겠습니까?");
        }
    </script>
</body>
</html>