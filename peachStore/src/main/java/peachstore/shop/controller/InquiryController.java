package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class InquiryController {

	@GetMapping("/inquiry/registForm")
	public String registForm() {
		
		return "/shop/inquiry/regist";
	}
	
	
	@PostMapping("/inquiry/regist")
	@ResponseBody
	public String regist() {
		
		return null;
	}
	
}
