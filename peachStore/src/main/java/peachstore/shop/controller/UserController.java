package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserController {
	
	//로그인 폼 요청 처리
	@GetMapping("/loginform")
	public String getLoginForm() {
		return "shop/loginform";
	}
	
}
