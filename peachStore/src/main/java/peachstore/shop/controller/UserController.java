package peachstore.shop.controller;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.SimpleTriggerContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.service.cart.CartService;
import peachstore.service.user.SnsProviderService;
import peachstore.service.user.UserService;
/**
 * 유저로그인용 컨트롤러 입니다.
 * @author 이세형
 * @since 2025-07-30
 * */
@Slf4j
@Controller
public class UserController {

	@Autowired
	private OAuth20Service googleOAuthService;

	@Autowired
	private OAuth20Service naverOAuthService;

	@Autowired
	private OAuth20Service kakaoOAuthService;

	@Autowired
	private SnsProviderService snsProviderService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;

	// 로그인 폼 요청 처리
	@GetMapping("/user/loginform")
	public String getLoginForm() {
		return "shop/user/loginform";
	}

	// 로그아웃 요청 처리
	@GetMapping("/user/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		// 로그 아웃 할 시 다시 로그인 폼으로 가도록 변경
		return "redirect:/shop/main";
	}

	// 회원가입 폼 요청 처리
	@GetMapping("/user/joinform")
	public ModelAndView getJoinForm() {
		List<User> userList = userService.selectAllJoin();
		ModelAndView mav = new ModelAndView();
		mav.addObject("userList", userList);
		mav.setViewName("shop/user/joinform");
		
		return mav;
	}

	@PostMapping("/user/join")
	public String userJoin(User user,String password) {
		
		userService.userJoin(user);
		log.debug("새로 생성되는 유저의 pk는"+user.getUser_id());
		cartService.createCart(user.getUser_id());
		return "redirect:/shop/main";
	}
	
    @GetMapping("/user/checkid")
    @ResponseBody
    public String checkId(@RequestParam("id") String id) {
        User user = userService.selectById(id);
        if (user != null) {
            return "duplicated";
        } else {
            return "available";
        }
    }
    
	// 가입 회원 로그인 로직
    
	@PostMapping("/user/login")
	public String homepageLogin(User user, HttpSession session) {
		log.debug("user 레퍼런스주소" + user);
		User obj;
		try {
			obj = userService.homepageLogin(user);
//		if(user==null) {user=null이면 로그인 됨
			if (obj == null) {
//			존재하지 않는 회원인경우 알림 띄우는 로직 구현하기
				return "redirect:/shop/user/loginform";
			}
			
			session.setAttribute("user", obj);
			return "redirect:/shop/main";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "redirect:/shop/user/error";
		}
	}

	//에러페이지 리턴
	@GetMapping("/user/error")
	public String errorPage() {
		return "shop/user/error";
	}
	/*
	 * ========================================================================
	 * 구글 로그인 처리
	 * ========================================================================
	 */

	@GetMapping("/user/google/authurl")
	@ResponseBody
	public String getGoogleAuthUrl() {
		return googleOAuthService.getAuthorizationUrl();
	}

	@GetMapping("/callback/sns/google")
	public String googleCallback(String code, HttpSession session)
			throws ExecutionException, InterruptedException, IOException {
		// 빈 등록시 이미 ClientID, Secret다 존재
		// 토큰 요청시 Authorization 코드만 추가하면 됨
		OAuth2AccessToken accessToken = googleOAuthService.getAccessToken(code);

		OAuthRequest request = new OAuthRequest(Verb.GET, "https://www.googleapis.com/oauth2/v2/userinfo");
		googleOAuthService.signRequest(accessToken, request);

		Response response = googleOAuthService.execute(request);

		// json파싱
		JsonObject json = JsonParser.parseString(response.getBody()).getAsJsonObject();

		// 필요한 개인 정보를 key값으로 조회하여 가져오기
		String email = json.get("email").getAsString();
		String name = json.get("name").getAsString();
		String openId = json.get("id").getAsString();

		// 회원가입 확인 및 등록 : 토큰을 통해 얻은 회원정보가 우리 쇼핑몰에 등록되어 있는지 체크
		User user = userService.selectById(openId);
		if (user == null) {
			// 동일한 계정이 이미 존재한다면 로그인만 처리
			user = new User();

			// 회원 등록
			user.setSns_provider(snsProviderService.selectByName("google"));
			user.setId(openId);
			user.setEmail(email);
			user.setUser_name(name);

			userService.register(user);
			cartService.createCart(user.getUser_id());
		}
		// 없으면 가입 후, 있으면 로그인
		// session에 user라는 이름의 객체를 저장
		session.setAttribute("user", user);

		return "redirect:/shop/main";
	}

	/*
	 * =================================================
	 * 네이버 로그인 처리
	 * ======================================================
	 */

	@GetMapping("/user/naver/authurl")
	@ResponseBody
	public String getNaverAuthUrl() {
		return naverOAuthService.getAuthorizationUrl();
	}

	// naver에 등록해 놓은 콜백 주소로 전송되는 콜백 요청 처리
	@GetMapping("/callback/sns/naver")
	public String naverCallback(@RequestParam("code") String code, String state, HttpSession session)
			throws ExecutionException, InterruptedException, IOException {

		OAuth2AccessToken accessToken = naverOAuthService.getAccessToken(code);

		// 발급받은 토큰을 이용하여 회원정보 조회
		OAuthRequest request = new OAuthRequest(Verb.GET, "https://openapi.naver.com/v1/nid/me");
		naverOAuthService.signRequest(accessToken, request);
		Response response = naverOAuthService.execute(request); // 요청 후 그 결과를 받자

		JsonObject responseJson = JsonParser.parseString(response.getBody()).getAsJsonObject();
		JsonObject userJson = responseJson.getAsJsonObject("response");

		String id = userJson.get("id").getAsString();
		String email = userJson.get("email").getAsString();
		String name = userJson.get("name").getAsString();
		
		User user = userService.selectById(id);
		if (user == null) {
			// 동일한 계정이 이미 존재한다면 로그인만 처리
			user = new User();

			// 회원 등록
			user.setSns_provider(snsProviderService.selectByName("naver"));
			user.setId(id);
			user.setEmail(email);
			user.setUser_name(name);

			userService.register(user);
			cartService.createCart(user.getUser_id());
		}
		// 없으면 가입 후, 있으면 로그인
		session.setAttribute("user", user);// 세션이 살아있는 한, Member를 사용할 수 있음

		return "redirect:/shop/main";
	}
}
