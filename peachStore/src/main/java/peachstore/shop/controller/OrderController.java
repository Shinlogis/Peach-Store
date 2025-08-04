package peachstore.shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderReceipt;
import peachstore.domain.Review;
import peachstore.domain.SnapShot;
import peachstore.domain.User;
import peachstore.service.orderdetail.OrderDetailService;
import peachstore.service.orderreceipt.OrderReceiptService;
import peachstore.service.review.ReviewService;
import peachstore.service.snapshot.SnapShotService;

@Slf4j
@Controller
public class OrderController {

	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private OrderReceiptService orderReceiptService;
	@Autowired
	private SnapShotService snapShotService;
	@Autowired
	private ReviewService reviewService;

	// 주문 리스트
	@GetMapping("/order/list")
	public ModelAndView selectAll(OrderReceipt orderReceipt, SnapShot snapShot, HttpSession session) {
		User user = (User) session.getAttribute("user");
		orderReceipt.setUser(user);
		log.debug("유저 데이터 : {}", user);

		List<OrderReceipt> receiptList = orderReceiptService.selectByUserId(orderReceipt);
		log.debug("주문요약 데이터 : {}", receiptList);

		ModelAndView mav = new ModelAndView();

		mav.addObject("receiptList", receiptList);

		mav.setViewName("shop/order/orderList");

		return mav;
	}

	// 주문 취소 리스트
	@GetMapping("/order/cancle/list")
	public ModelAndView selectCancle(OrderReceipt orderReceipt, SnapShot snapShot, HttpSession session) {
		User user = (User) session.getAttribute("user");
		orderReceipt.setUser(user);
		log.debug("유저 데이터 : {}", user);

		List<OrderReceipt> cancleList = orderReceiptService.cancleList(orderReceipt);
		log.debug("주문요약 데이터 : {}", cancleList);

		ModelAndView mav = new ModelAndView();

		mav.addObject("cancleList", cancleList);

		mav.setViewName("shop/order/cancleList");

		return mav;
	}

	// 주문취소
	@PostMapping("/order/cancle")
	public String cancle(OrderReceipt orderReceipt) {
		orderReceiptService.cancle(orderReceipt);

		return "redirect:/shop/order/list";
	}

	// 발송완료 리스트
	@GetMapping("/order/ordercompleted")
	public ModelAndView selectComleted(OrderReceipt orderReceipt, Review review, SnapShot snapShot,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		orderReceipt.setUser(user);
		log.debug("유저 데이터 : {}", user);

		List<OrderReceipt> completedList = orderReceiptService.completedList(orderReceipt);
		log.debug("주문요약 데이터 : {}", completedList);

		//이미 쓴 리뷰 중복방지
		List<Review> reviewList = reviewService.selectByUserId(user);

		List<Integer> writtenReview = new ArrayList<>();

		for (Review r : reviewList) {
			int id = r.getOrderDetail().getOrder_detail_id();
			writtenReview.add(id);
		}

		ModelAndView mav = new ModelAndView();

		mav.addObject("completedList", completedList);
		mav.addObject("writtenReview", writtenReview);

		mav.setViewName("shop/order/ordercompleted");

		return mav;
	}

}
