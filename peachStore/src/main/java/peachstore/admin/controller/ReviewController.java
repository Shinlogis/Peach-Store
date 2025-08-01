package peachstore.admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@PostMapping("/review/deactive")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deactivate(int reviewId , String status){
		reviewService.deactivate(reviewId, "숨김");
		return null;
	}
	
}
