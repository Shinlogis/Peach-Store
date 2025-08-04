package peachstore.shop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.service.userGrade.UserGradeService;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserGradeController {

	private final UserGradeService userGradeService;
	
	/**
	 * 등급 갱신여부 요청
	 * @param request
	 * @param userId
	 */
	@GetMapping("/user-grade-update")
	@ResponseBody
	public void gradeSelectByAmount(HttpServletRequest request, int userId) {
		userGradeService.calUserGrade(1);
	}
	
}
