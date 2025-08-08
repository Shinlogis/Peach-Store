package peachstore.shop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.SnapShot;
import peachstore.domain.User;
import peachstore.dto.ConfirmPaymentRequest;
import peachstore.dto.PaymentSessionData;
import peachstore.dto.TossConfirmResponse;
import peachstore.service.TossPaymentService;


@Controller
@Slf4j
@RequiredArgsConstructor
public class PaymentController {

	private final TossPaymentService tossPaymentService;

	/**
	 * 결제 품목 정보 보여주기
	 * @param model
	 * @param httpSession
	 * @return
	 */
	@GetMapping("/payment/payment-ready")
	public String getMethodName(Model model, HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("user");
		List<SnapShot> snapshotList = (List<SnapShot>)httpSession.getAttribute("cartSnapshots");
		log.debug("스냅샷 리스트는======="+snapshotList);
		
		String successUrl = "http://localhost:8888/shop/payment/success-handler";
		String failUrl = "http://localhost:8888/shop/payment/fail";
		String orderId = String.valueOf(System.currentTimeMillis());

		log.debug("paymentPage orderId - {}", orderId);
		
		model.addAttribute("orderId", orderId);
		model.addAttribute("successUrl", successUrl);
		model.addAttribute("failUrl", failUrl);
		model.addAttribute("orderName", "주문번호 " + orderId + " 결제");
		model.addAttribute("snapshotList", snapshotList);
		
		model.addAttribute("user", user);
		return "/shop/payment/payment-ready";
	}
	
	/**
	 * 결제 전 입력한 정보를 세션에 저장
	 * @param postCode
	 * @param address
	 * @param detailAddress
	 * @param session
	 * @return
	 */
	@PostMapping("/payment/save-address")
	@ResponseBody
	public ResponseEntity<Void> saveAddressToSession(
			@RequestParam String postCode,
			@RequestParam String address,
			@RequestParam String detailAddress,
			HttpSession session) {
		
		session.setAttribute("postCode", postCode);
		session.setAttribute("address", address);
		session.setAttribute("detailAddress", detailAddress);
		
		return ResponseEntity.ok().build();
	}

	/**
	 * 결제 완료 중간 단계로 이동
	 */
	@GetMapping("/payment/success-handler")
	public String successHandlerPage(@RequestParam String paymentKey, @RequestParam String orderId, @RequestParam long amount, Model model) {
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);

		return "/shop/payment/success-handler";
	}

	
	/**
     * 결제 요청을 보내고 처리하는 메서드
     *
     * @param request
     * @return
     */
    @PostMapping("/payment/confirm")
    public ResponseEntity<TossConfirmResponse> successHandlerPageConfirm(@RequestBody ConfirmPaymentRequest request, HttpSession httpSession) {
    	 // 1. 세션 데이터 추출
        PaymentSessionData sessionData = tossPaymentService.extractPaymentSessionData(httpSession);
        if (!sessionData.isValid()) {
            log.warn("세션에 스냅샷 정보가 없습니다.");
            return ResponseEntity.badRequest().build();
        }

        // 2. 결제 승인 + 완료 처리 + 세션 정리
        TossConfirmResponse response = tossPaymentService.handlePaymentAndSession(request, httpSession, sessionData);
        
        // 성공 결과 반환
        return ResponseEntity.ok(response);
    }

	/**
	 * 결제 성공 페이지
	 * @return
	 */
	@GetMapping("/payment/success")
	public String successPage(HttpSession session, Model model) {
		Integer orderReceiptIdInt = (Integer) session.getAttribute("orderReceiptId");
		Long orderReceiptId = orderReceiptIdInt.longValue();

	    model.addAttribute("orderReceiptId", orderReceiptId);

	    return "/shop/payment/success";
	}


	/**
	 * 결제 실패 페이지
	 */
	@GetMapping("/payment/fail")
	public String failPage(@RequestParam Map<String, String> params, Model model) {
		model.addAllAttributes(params);
		return "/shop/payment/fail";
	}


	
//	/**
//	 * 결제 정보 db 저장
//	 * 
//	 * @param request
//	 * @return
//	 */
//	@PostMapping("/payment/confirm")
//	public ResponseEntity<TossConfirmResponse> successHandlerPageConfirm(@RequestBody ConfirmPaymentRequest request, HttpSession httpSession) {
//		User user = (User) httpSession.getAttribute("user");
//		log.debug("successHandlerPageConfirm 호출");
//		// 토스 결제 승인 요청
//		TossConfirmResponse response = tossPaymentService.confirmPayment(request.getPaymentKey(), request.getOrderId(), request.getAmount());
//
//		// 결제 정보 DB 저장
//		Tosspayment tosspayment = tossPaymentService.insert(request.getOrderId(), request.getPaymentKey(), response.getMethod(), response.getStatus(), request.getAmount(), response.getApprovedAt().toLocalDateTime(), response.getRequestedAt().toLocalDateTime());
//
//		// 세션에서 주소 꺼내기
//		String postCode = (String) httpSession.getAttribute("postCode");
//		String address = (String) httpSession.getAttribute("address");
//		String detailAddress = (String) httpSession.getAttribute("detailAddress");
//		log.debug("주소 정보: {}, {}, {}", postCode, address, detailAddress);
//		
//		// OrderReceipt DB 저장
//		OrderReceipt orderReceipt = orderReceiptService.insert(response.getApprovedAt().toLocalDateTime(), "상품 준비 전", user, tosspayment, postCode, address, detailAddress);
//		
//		// 세션에서 스냅샷 꺼내
//	    List<SnapShot> snapshotList = (List<SnapShot>) httpSession.getAttribute("cartSnapshots");
//	    if (snapshotList == null || snapshotList.isEmpty()) {
//	        log.warn("세션에 스냅샷 정보가 없습니다.");
//	        return ResponseEntity.badRequest().build();
//	    }
//	    log.warn("세션에 넘어온 스냅샷 리스트는" + snapshotList);
//	    
//		// OrderDetail DB 저장
//		for (SnapShot snapShot : snapshotList) {
//			orderDetailService.insert(orderReceipt.getOrder_receipt_id(), snapShot.getSnapshot_id());
//		}
//		
//		// 결제되었으므로 장바구니의 상품 삭제
//		cartItemService.deleteAllByUserId(user.getUser_id());
//		
//		// 세션에서 정보 삭제
//		httpSession.removeAttribute("postCode");
//		httpSession.removeAttribute("address");
//		httpSession.removeAttribute("detailAddress");
//		httpSession.removeAttribute("cartSnapshots");
//		
//		// orderReceiptId 세션에 저장
//		httpSession.setAttribute("orderReceiptId", orderReceipt.getOrder_receipt_id());
//		
//		// 성공 결과 반환
//		return ResponseEntity.ok(response);
//	}

}
