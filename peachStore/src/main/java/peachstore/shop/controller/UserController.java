package peachstore.shop.controller;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.service.SnsProviderService;
import peachstore.service.UserService;
@Slf4j
@Controller
public class UserController {

	@Autowired
	private OAuth20Service googleOAuthService;

	@Autowired
	private SnsProviderService snsProviderService;

	@Autowired
	private UserService userService;

	// 로그인 폼 요청 처리
	@GetMapping("/loginform")
	public String getLoginForm() {
		return "shop/loginform";
	}

	// 로그아웃 요청 처리
	@GetMapping("/user/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		// 로그 아웃 할 시 다시 로그인 폼으로 가도록 변경
		return "redirect:/shop/user/loginform";
	}

	/*
	 * ======================================================================== 구글
	 * 로그인 처리
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
			user.setSnsProvider(snsProviderService.selectByName("google"));
			user.setId(openId);
			user.setEmail(email);
			user.setUser_name(name);

			userService.register(user);
		}
		// 없으면 가입 후, 있으면 로그인
		session.setAttribute("user", user);// 세션이 살아있는 한, Member를 사용할 수 있음

		return "redirect:/shop/main";
	}
	
}
