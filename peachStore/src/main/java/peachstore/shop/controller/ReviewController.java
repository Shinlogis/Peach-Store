package peachstore.shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderDetail;
import peachstore.domain.Review;
import peachstore.domain.User;
import peachstore.service.review.ReviewService;

@Slf4j
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;

	
	//등록 폼
	@GetMapping("/review/registform")
	public ModelAndView registForm(OrderDetail orderDetail) {
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("shop/review/regist");

	    return mav;
	}

	//등록
	@PostMapping("/review/regist")
	@ResponseBody
	public String regist(Review review, HttpServletRequest request, HttpSession session) {
		
		String savePath = request.getServletContext().getRealPath("/data");
		String responseData = "fail";
		
		OrderDetail orderDetail = review.getOrderDetail();
		
		request.setAttribute("orderDetail",orderDetail);
		
		try {
			reviewService.regist(review, savePath);
			responseData = "success";
		} catch (Exception e) {
			e.printStackTrace();
			reviewService.regist(review, savePath);
		}
		return responseData;
	}
	
	
	//조회
	@GetMapping("review/list")
	public ModelAndView getList(HttpSession session, Review review) {
		User user = (User)session.getAttribute("user");
		review.setUser(user);
		
		List<Review> reviewList = reviewService.selectByUserId(user);
		
		log.debug("리뷰 쓸 user_id 는 " + user.getUser_id());
		ModelAndView mav = new ModelAndView();
		mav.addObject("reviewList", reviewList);
		mav.setViewName("/shop/review/list");
		
		return mav;
	}
	
	//수정 폼
	@GetMapping("review/updateform")
	public ModelAndView updateForm(int reviewId) {
		
		Review review = reviewService.findById(reviewId);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("review", review);
		mav.setViewName("/shop/review/update");
		
		return mav;
	}
	
	
	//수정
	@PostMapping("/review/update")
	@ResponseBody
	public String update(Review review, HttpServletRequest request) {
		
		String savePath = request.getServletContext().getRealPath("/data");
		reviewService.updateReview(review, savePath);
		
		return "ok";
	}
	
	
	//삭제
	@PostMapping("review/delete")
	public String delete(Review review, HttpServletRequest request) {
		
		String savePath = request.getServletContext().getRealPath("/data");
		reviewService.remove(review, savePath);
		
		return "redirect:/shop/review/list";
	}
	
	
	
}
