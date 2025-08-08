package peachstore.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginCheckFilter implements Filter{


	//쇼핑몰의 기능 중 로그인이 요구되는 요청마다 세션 존재 여부를 체크하면 코드 중복이 일어나므로
	//따라서 해당 요청에 필터수준에서 세션 체크를 진행
		@Override
		public void init(FilterConfig filterConfig) throws ServletException {

		}

		@Override
		public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
				throws IOException, ServletException {
			HttpServletRequest request = (HttpServletRequest)req;
			String uri=request.getRequestURI();
			if(//회원이 아니어도 접속이 가능한 uri
			//이 요청들에서 자체적으로 예외처리가 더 필요할듯
				uri.equals("/shop/main")||
				uri.equals("/shop/user/loginform")||
				uri.equals("/shop/user/kakao/authurl")||
				uri.equals("/shop/user/google/authurl")||
				uri.equals("/shop/user/naver/authurl")||
				uri.equals("/shop/callback/sns/google")||
				uri.equals("/shop/callback/sns/naver")||
				uri.equals("/shop/callback/sns/kakao")||
				uri.equals("/shop/user/logout")||
				uri.equals("/shop/product/list")||
				uri.equals("/shop/product/detail")||
				uri.equals("/shop/user/joinform")||
				uri.equals("/shop/user/join")||
				uri.equals("/shop/user/login")||
				uri.equals("/shop/product/list")||
				uri.equals("/shop/product")||
				uri.equals("/shop/product/detail")||
				uri.equals("/shop/user/checkid")||
				uri.equals("/shop/user/error")||
				
				 // admin용
				uri.equals("/admin/main")||
			    uri.equals("/admin/user/loginform") ||
			    uri.equals("/admin/user/login") ||
			    uri.equals("/admin/user/logout") 
				
				
			) {
				chain.doFilter(req, res);
				//doFilter를 만나면 실행부는 원래 실행하려고 했던 곳으로 감(서블릿, 필터를 향해)
				//정보공유를 명확히 하기위해 관습 상 return값을 줌
				return;
			}
			
			HttpSession session = request.getSession(false);//기존의 세션을 얻어옴(false), true : 새로운 세션생성
			 // 1. admin 영역
		    if (uri.startsWith("/admin/")) {
		        boolean isAdminLoggined = (session != null && session.getAttribute("admin") != null);
		        if (!isAdminLoggined) {
		            ((HttpServletResponse) res).sendRedirect("/admin/user/loginform");
		            return;
		        }
		    }
		    // 2. shop 영역
		    else if (uri.startsWith("/shop/")) {
		        boolean isUserLoggined = (session != null && session.getAttribute("user") != null);
		        if (!isUserLoggined) {
		            ((HttpServletResponse) res).sendRedirect("/shop/user/loginform");
		            return;
		        }
		    }
		    chain.doFilter(req, res);
		}

		@Override
		public void destroy() {

		}
}
