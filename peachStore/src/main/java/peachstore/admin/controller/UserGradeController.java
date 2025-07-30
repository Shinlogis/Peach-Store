package peachstore.admin.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.UserGrade;
import peachstore.exception.UserGradeException;
import peachstore.service.userGrade.UserGradeService;

/**
 * 사용자 등급 컨트롤러
 * @author 김예진
 * @since 2025-07-30
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class UserGradeController {
	
	private final UserGradeService userGradeService;
	
	/**
	 * 사용자 등급 전체 조회
	 * @return
	 */
	@GetMapping("/usergrade/list")
	public String listAll(Model model) {
		List<UserGrade> grades = userGradeService.findAll();
		model.addAttribute("grades", grades);
		return "/usergrade/list";
	}
	
	/**
	 * 사용자 등급 등록
	 * @param userGradeName 등급명
	 * @param discountRate 할인율
	 * @param criteriaAmount 누적구매기준금액
	 * @return
	 */
	@PostMapping("/usergrade/register")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> register(String userGradeName, BigDecimal discountRate, int criteriaAmount){
		userGradeService.register(userGradeName, discountRate, criteriaAmount);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "등급이 성공적으로 등록되었습니다.");
		
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}

	/**
	 * 사용자 등급 수정
	 * @param userGradeName
	 * @param userGradeId
	 * @return
	 */
	@PostMapping("/usergrade/update")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> register(String userGradeName, int criteriaAmount, BigDecimal discountRate, int userGradeId){
		log.debug("받은 id: {}, name: {}, amount: {}, rate: {}", userGradeId, userGradeName, criteriaAmount, discountRate);
		userGradeService.update(userGradeName, criteriaAmount, discountRate, userGradeId);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "등급이 성공적으로 변경되었습니다.");
		
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}
	
	/**
	 * 사용자 등급 상태 변경
	 * @param userGradeId
	 * @return
	 */
	@PostMapping("/usergrade/toggleActivation")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> register(int userGradeId){
		userGradeService.toggleActivation(userGradeId);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "등급이 성공적으로 변경되었습니다.");
		
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}
	
	/**
	 * 사용자 등급 삭제
	 * @param userGradeId
	 * @return
	 */
	@PostMapping("/usergrade/delete")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> delete(int userGradeId){
		userGradeService.delete(userGradeId);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "등급이 성공적으로 삭제되었습니다.");
		
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}
}
