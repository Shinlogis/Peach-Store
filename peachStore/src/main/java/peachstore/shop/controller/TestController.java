package peachstore.shop.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.repository.UserDAO;

@Slf4j
@Controller
public class TestController {
	
	@Autowired
	private UserDAO userDAO;
	
	@GetMapping("/mypage")
	public String myPage() {
		return "shop/mypage/mypage";
	}
	
	@GetMapping("/review/registForm")
	public String regist() {
		
		return "shop/review/regist";
	}
	
	@GetMapping("/user")
	public String getUser(HttpSession session) {
		
		int user_id = 3;
		User user = userDAO.select(user_id);
		session.setAttribute("user", user);
		
		return "redirect:/shop/main";
		
	}
}
