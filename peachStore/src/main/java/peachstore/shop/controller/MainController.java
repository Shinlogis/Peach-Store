package peachstore.shop.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderReceipt;
import peachstore.domain.User;
import peachstore.service.orderreceipt.OrderReceiptService;
import peachstore.service.review.ReviewService;
import peachstore.service.user.UserService;

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
	private UserService userService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private OrderReceiptService orderReceiptService;
	
	@GetMapping("/main")
	public String main() {
		return "shop/index";
	}

	@GetMapping("/mypage")
	public ModelAndView myPage(HttpSession session) {
		User user = (User)session.getAttribute("user");

		ModelAndView mav = new ModelAndView();
		// 유저 정보로 주문 리스트 불러오기
		OrderReceipt orderReceipt = new OrderReceipt();
		orderReceipt.setUser(user);
		List<OrderReceipt> receiptList = orderReceiptService.selectByUserId(orderReceipt);

		mav.addObject("receiptList", receiptList);  // 주문 내역 추가

		mav.setViewName("shop/mypage/mypage");
		return mav;
	}


}
