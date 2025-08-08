package peachstore.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import peachstore.domain.CartItem;

@Getter @Setter
public class ConfirmPaymentRequest {
	private String paymentKey;      // 토스 결제 키
	private String orderId;         // 내부 주문 ID
	private long amount;            // 결제 금액
	private int orderReceiptId;     // DB상 주문 영수증 ID
	private List<CartItem> cartItemList; //장바구니 상품 목록 
}
