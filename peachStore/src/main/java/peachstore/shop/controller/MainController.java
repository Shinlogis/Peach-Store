package peachstore.shop.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.domain.UserGrade;
import peachstore.service.userGrade.UserGradeService;

/**
 * 메인 페이지 컨트롤러
 * 
 * @author 서예닮
 * @since 2025-07-25
 */
@Slf4j
@Controller
public class MainController {

	@Autowired
	private UserGradeService userGradeService;

	@GetMapping("/main")
	public String main() {
		return "shop/index";
	}

	@GetMapping("/mypage")
	public ModelAndView myPage(UserGrade userGrade, HttpSession session) {

		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("user");
		log.debug("마이페이지 접근 유저 정보{}", user);
		
		int userGradeId = user.getUser_grade().getUserGradeId();
		log.debug("유저 등급 정보", userGradeId);

		//UserGrade ug = userGradeService.select(userGradeId);
		
		//mav.addObject("userGrade", ug);
		mav.setViewName("shop/mypage/mypage");

		return mav;
	}

}
