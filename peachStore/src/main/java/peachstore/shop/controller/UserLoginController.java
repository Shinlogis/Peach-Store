package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserLoginController {
	
	@GetMapping("/loginform")
	public String getLoginForm() {
		return "shop/loginform";
	}
}
