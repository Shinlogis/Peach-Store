package peachstore.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ConfirmPaymentRequest {
	private String paymentKey;      // 토스 결제 키
	private String orderId;         // 내부 주문 ID
	private long amount;            // 결제 금액
	private int orderReceiptId;     // DB상 주문 영수증 ID
}
