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
			
			//현재 들어오는 요청 객체가 세션정보를 공유하고 있는지 체크
			//세션안에 회원정보가 들어있다면, 원래 가던곳으로 그대로 보내주고
			//세션안에 회원정보가 없다면 로그인폼으로 자동 전달
			
			log.warn("필터가 동작함");
		
			//클라이언트의 요청이 /shop/cart/list, /shop/member/mypage 등등의 로그인이 피룡한 서비스인 경우엔
			//세션 정보가 없다면ㅡ 아래의 chain.doFilter()를 만나지 않도록 처리, 내부의 서블릿을 만나지도 못하고
			//톰캣으로 하여금 로그인 폼을 응답정보로 보내도록 하자.
			String uri=request.getRequestURI();
			if(//회원이 아니어도 접속이 가능한 uri
				uri.equals("/shop/shop/main")||
				uri.equals("/shop/member/loginform")||
				uri.equals("/shop/member/kakao/authurl")||
				uri.equals("/shop/member/google/authurl")||
				uri.equals("/shop/member/naver/authurl")||
				uri.equals("/shop/callback/sns/google")||
				uri.equals("/shop/callback/sns/naver")||
				uri.equals("/shop/callback/sns/kakao")||
				uri.equals("/shop/member/logout")||
				uri.equals("/shop/product/list")||
				uri.equals("/shop/product/detail")||
				uri.equals("/shop/member/registerform")||
				uri.equals("/shop/member/register")||
				uri.equals("/shop/member/login")
				
				
				
			) {
				chain.doFilter(req, res);
				//doFilter를 만나면 실행부는 원래 실행하려고 했던 곳으로 감(서블릿, 필터를 향해)
				//정보공유를 명확히 하기위해 관습 상 return값을 줌
				return;
			}
			
			HttpSession session = request.getSession(false);//기존의 세션을 얻어옴(false), true : 새로운 세션생성
			boolean isLoggined = (session != null && session.getAttribute("member") != null); 
				
			if(isLoggined == false) {//로그인 하지 않은 경우엔 강제로 loginform만나게 하자.
				HttpServletResponse response=(HttpServletResponse)res;
				response.sendRedirect("/shop/member/loginform");
			}else {
				chain.doFilter(req,res);
			}
		}

		@Override
		public void destroy() {

		}
}
