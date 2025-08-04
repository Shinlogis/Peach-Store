package peachstore.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import peachstore.dto.TossConfirmResponse;
import peachstore.repository.tosspayment.TosspaymentDAO;
import peachstore.service.orderreceipt.OrderReceiptService;

/**
 * 토스 결제 서비스
 */
@Slf4j
@Service
public class TossPaymentService {

	private final String secretKey = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R";
	private final String tossUrl = "https://api.tosspayments.com/v1/payments/confirm";

	private final ObjectMapper objectMapper;

	// 생성자 주입
	public TossPaymentService(RestTemplate restTemplate, OrderReceiptService orderReceiptService,
			TosspaymentDAO tosspaymentDAO) {

		this.objectMapper = new ObjectMapper();
		this.objectMapper.registerModule(new JavaTimeModule());
		this.objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	}

	/**
	 * 토스 결제 확정 API 호출 서비스 메서드
	 * 
	 * @param paymentKey 토스 결제 키
	 * @param orderId    주문 ID
	 * @param amount     결제 금액
	 * @return TossConfirmResponse 결제 확인 응답 DTO
	 * @throws RuntimeException
	 */
	public TossConfirmResponse confirmPayment(String paymentKey, String orderId, long amount) {
		log.debug("confirmPayment 진입");
		log.debug("paymentKey={}, orderId={}, amount={}", paymentKey, orderId, amount);

		try {
			// ObjectMapper로 요청 JSON 객체 생성
			ObjectNode requestObj = objectMapper.createObjectNode();
			requestObj.put("paymentKey", paymentKey);
			requestObj.put("orderId", orderId);
			requestObj.put("amount", amount);

			// JSON 문자열로 변환
			String bodyJson = objectMapper.writeValueAsString(requestObj);

			// Basic Auth 헤더 생성
			String auth = secretKey + ":";
			String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes(StandardCharsets.US_ASCII));
			String authHeader = "Basic " + new String(encodedAuth);

			log.debug("Toss Confirm 요청 URL: {}, 헤더 Authorization: {}, 요청 바디: {}", tossUrl, authHeader, bodyJson);

			// OkHttpClient를 사용해 POST 요청 생성
			OkHttpClient client = new OkHttpClient();
			okhttp3.RequestBody body = okhttp3.RequestBody.create(bodyJson, okhttp3.MediaType.get("application/json"));

			Request request = new Request.Builder().url(tossUrl).addHeader("Authorization", authHeader)
					.addHeader("Content-Type", "application/json").post(body).build();

			// 요청 실행 및 응답
			try (Response response = client.newCall(request).execute()) {
				int statusCode = response.code();
				String responseBody = response.body() != null ? response.body().string() : "";

				log.debug("OkHttp confirm status: {},  body: {}", statusCode, responseBody);

				// HTTP 200 OK인 경우에만 JSON 파싱 후 반환
				if (statusCode == 200) {
					return objectMapper.readValue(responseBody, TossConfirmResponse.class);
				} else {
					throw new RuntimeException("Toss Confirm API 호출 실패 " + statusCode);
				}
			}

		} catch (IOException e) {
			log.error("OkHttp 요청 중 IOException 발생", e);
			throw new RuntimeException("Toss Confirm API 호출 중 오류 발생", e);
		} catch (Exception e) {
			log.error("Toss Confirm 처리 중 예외 발생", e);
			throw new RuntimeException("Toss Confirm 처리 실패", e);
		}
	}
}
