package peachstore.shop.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.CartItem;
import peachstore.domain.OrderReceipt;
import peachstore.domain.SnapShot;
import peachstore.domain.Tosspayment;
import peachstore.domain.User;
import peachstore.dto.ConfirmPaymentRequest;
import peachstore.dto.TossConfirmResponse;
import peachstore.repository.tosspayment.TosspaymentDAO;
import peachstore.service.TossPaymentService;
import peachstore.service.cart.CartItemService;
import peachstore.service.orderdetail.OrderDetailService;
import peachstore.service.orderreceipt.OrderReceiptService;


@Controller
@Slf4j
@RequiredArgsConstructor
public class PaymentController {

	private final CartItemService cartItemService;
	private final OrderReceiptService orderReceiptService;
	private final OrderDetailService orderDetailService;
	

	private final TossPaymentService tossPaymentService;
	
	private final TosspaymentDAO tosspaymentDAO;

	/**
	 * 결제 품목 정보 보여주기
	 * @param model
	 * @param httpSession
	 * @return
	 */
	@GetMapping("/payment/payment-ready")
	public String getMethodName(Model model, HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("user");
//		List<CartItem> cartItemList = cartItemService.selectCartItemByCartId(user.getUser_id());
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
		
//		model.addAttribute("cartItemList", cartItemList);
		model.addAttribute("user", user);
		return "/shop/payment/payment-ready";
	}
	

	/**
	 * 결제 완료 중간 단계로 이동
	 */
	@GetMapping("/payment/success-handler")
	public String successHandlerPage(@RequestParam String paymentKey, @RequestParam String orderId,
			@RequestParam long amount, Model model, HttpSession session) {
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);

		return "/shop/payment/success-handler";
	}

	/**
	 * 입력한 주소를 세션에 저장
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
	 * 결제 정보 db 저장
	 * 
	 * @param request
	 * @return
	 */
	@PostMapping("/payment/confirm")
	public ResponseEntity<TossConfirmResponse> successHandlerPageConfirm(@RequestBody ConfirmPaymentRequest request, HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("user");
		log.debug("successHandlerPageConfirm 호출");
		// 토스 결제 승인 요청
		TossConfirmResponse response = tossPaymentService.confirmPayment(request.getPaymentKey(), request.getOrderId(), request.getAmount());

		// 1. 결제 정보 DB 저장 후 받아오기
		Tosspayment tosspayment = tosspaymentDAO.insert(request.getOrderId(), request.getPaymentKey(), response.getMethod(), response.getStatus(), request.getAmount(), response.getApprovedAt().toLocalDateTime(), response.getRequestedAt().toLocalDateTime());

		// 세션에서 주소 꺼내기
		String postCode = (String) httpSession.getAttribute("postCode");
		String address = (String) httpSession.getAttribute("address");
		String detailAddress = (String) httpSession.getAttribute("detailAddress");
		log.debug("주소 정보: {}, {}, {}", postCode, address, detailAddress);
		
		// 2. OrderReceipt DB 저장
		OrderReceipt orderReceipt = orderReceiptService.insert(response.getApprovedAt().toLocalDateTime(), "상품 준비 전", user, tosspayment, postCode, address, detailAddress);
		
		// TODO Snapshot insert
	    List<SnapShot> snapshotList = (List<SnapShot>) httpSession.getAttribute("cartSnapshots");
	    if (snapshotList == null || snapshotList.isEmpty()) {
	        log.warn("세션에 스냅샷 정보가 없습니다.");
	        return ResponseEntity.badRequest().build();
	    }
	    log.warn("세션에 넘어온 스냅샷 리스트는" + snapshotList);
		// TODO OrderDetail DB 저장
	    
		for (SnapShot snapShot : snapshotList) {
			orderDetailService.insert(orderReceipt.getOrder_receipt_id(), snapShot.getSnapshot_id());
		}
		
		// 세션에서 주소 삭제
		httpSession.removeAttribute("postCode");
		httpSession.removeAttribute("address");
		httpSession.removeAttribute("detailAddress");
		
		// orderReceiptId 세션에 저장
		httpSession.setAttribute("orderReceiptId", orderReceipt.getOrder_receipt_id());
		
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

	/**
	 * 토스에 결제 승인받기
	 * 
	 * @param confirmPaymentRequest
	 * @return
	 * @throws Exception
	 */
	private String getAuthorizations() {
		log.debug("getAuthorizations");
		String secretKey = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R"; // 토스 Secret Key
		String auth = secretKey + ":";
		return "Basic " + Base64.getEncoder().encodeToString(auth.getBytes());
	}

	/**
	 * 토스에게 결제 승인 요청
	 */
	public String requestConfirm(ConfirmPaymentRequest confirmPaymentRequest) throws IOException {
		log.debug("requestConfirm");
		String tossOrderId = confirmPaymentRequest.getOrderId();
		long amount = confirmPaymentRequest.getAmount();
		String tossPaymentKey = confirmPaymentRequest.getPaymentKey();

		ObjectMapper objectMapper = new ObjectMapper();

		JsonNode requestObj = objectMapper.createObjectNode().put("orderId", tossOrderId).put("amount", amount)
				.put("paymentKey", tossPaymentKey);

		String requestBody = objectMapper.writeValueAsString(requestObj);

		HttpPost post = new HttpPost("https://api.tosspayments.com/v1/payments/confirm");
		post.setHeader("Authorization", getAuthorizations()); // getAuthorizations() 메서드가 Authorization 헤더 문자열 반환
		post.setHeader("Content-Type", "application/json");
		post.setEntity(new StringEntity(requestBody, "UTF-8"));

		try (CloseableHttpClient client = HttpClients.createDefault();
				CloseableHttpResponse response = client.execute(post)) {

			String responseBody = EntityUtils.toString(response.getEntity(), "UTF-8");
			return responseBody;
		}
	}

	/**
	 * 결제 취소 요청
	 */
	public String cancelPayment(String paymentKey, String cancelReason) throws IOException {
		log.debug("cancelPayment");
		String cancelUrl = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";

		// JSON 본문 구성
		String requestBody = "{\"cancelReason\": \"" + cancelReason + "\"}";

		HttpPost post = new HttpPost(cancelUrl);
		post.setHeader("Authorization", getAuthorizations());
		post.setHeader("Content-Type", "application/json");
		post.setEntity(new StringEntity(requestBody, "UTF-8"));

		try (CloseableHttpClient client = HttpClients.createDefault();
				CloseableHttpResponse response = client.execute(post)) {

			String responseBody = EntityUtils.toString(response.getEntity(), "UTF-8");
			return responseBody;
		}
	}
	

//	/*
//	 * 결제 입장
//	 */
//	@GetMapping("/payment/start")
//	public String paymentPage(Model model, int orderReceiptId, Long amount, String userName) {
//		String successUrl = "http://localhost:8888/shop/payment/success-handler?orderReceiptId=" + orderReceiptId;
//		String failUrl = "http://localhost:8888/shop/payment/fail";
//		String orderId = String.valueOf(System.currentTimeMillis());
//
//		log.debug("paymentPage orderId - {}, orderReceiptId - {}, amount - {}, userName - {}", orderId, orderReceiptId, amount, userName);
//		
//		model.addAttribute("orderReceiptId", orderReceiptId);
//		model.addAttribute("orderId", orderId);
//		model.addAttribute("amount", amount);
//		model.addAttribute("customerName", userName);
//		model.addAttribute("successUrl", successUrl);
//		model.addAttribute("failUrl", failUrl);
//		model.addAttribute("orderName", "주문번호 " + orderId + " 결제");
//
//		return "/payment/payment";
//	}

}
