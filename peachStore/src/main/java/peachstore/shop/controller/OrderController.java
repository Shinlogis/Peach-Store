package peachstore.shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderDetail;
import peachstore.domain.OrderReceipt;
import peachstore.domain.SnapShot;
import peachstore.domain.User;
import peachstore.service.orderdetail.OrderDetailService;
import peachstore.service.orderreceipt.OrderReceiptService;
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
	
	@GetMapping("/order/list")
	public ModelAndView selectAll(OrderReceipt orderReceipt, SnapShot snapShot, HttpSession session) {
		User user = (User)session.getAttribute("user");
		orderReceipt.setUser(user);
		List<OrderDetail> details = new ArrayList<>();
		log.debug("유저 데이터 : {}",user);
		
		List<OrderReceipt> receiptList = orderReceiptService.selectByUserId(orderReceipt);
		log.debug("주문요약 데이터 : {}",receiptList);
		
		for(OrderReceipt receipt : receiptList) {
		List<OrderDetail> detail = orderDetailService.selecByReceitId(receipt.getOrder_receipt_id());
		log.debug("주문상세 데이터 : {}",detail);
			details.addAll(detail);
		}
		//SnapShot shot = snapShotService.select(snapShot);
		
//		for(OrderDetail orderList : detail) {
//			log.debug("상품의 주문한 유저는 " + orderList.getOrderReceipt().getUser().getUser_id());
//			log.debug("상품의 주문일은 " + orderList.getOrderReceipt().getOrderdate());
//		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("orderDetail", details);
		//mav.addObject("orderReceipt", receipt);
		//mav.addObject("snapShot", shot);
		
		mav.setViewName("shop/order/list");
		
		return mav;
	}

}
