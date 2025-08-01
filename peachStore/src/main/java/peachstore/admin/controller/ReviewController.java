package peachstore.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import peachstore.domain.Review;
import peachstore.service.review.ReviewService;
import peachstore.util.Paging;


/**
 * 리뷰 컨트롤러
 * @author 김예진
 * @since 2025-07-31
 */
@Controller
@RequiredArgsConstructor
public class ReviewController {
	private final ReviewService reviewService;
	
	/**
	 * 리뷰 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping("/review/list")
	public String listAll(HttpServletRequest request ,Model model) {
		List<Review> list = reviewService.selectAll();
		Paging paging = new Paging();
		paging.init(list, request);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "/review/list";
	}
	
	/**
	 * 리뷰 숨김 처리
	 * @param reviewId
	 * @param status
	 * @return
	 */
	@PostMapping("/review/toggle")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deactivate(@RequestParam int reviewId) {
		Map<String, Object> response = new HashMap<>();
		try {
			reviewService.deactivate(reviewId);
			response.put("success", true);
			response.put("message", "성공적으로 업데이트되었습니다.");
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 리뷰 삭제
	 * @param reviewId
	 * @return
	 */
	@PostMapping("/review/delete")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> delete(int reviewId) {
		Map<String, Object> response = new HashMap<>();
		try {
			reviewService.delete(reviewId);
			response.put("success", true);
			response.put("message", "성공적으로 삭제되었습니다.");
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
