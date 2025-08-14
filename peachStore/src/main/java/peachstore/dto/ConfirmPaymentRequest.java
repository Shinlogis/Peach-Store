package peachstore.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import peachstore.domain.CartItem;

/**
 * 결제 요청용 DTO
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ConfirmPaymentRequest {
	private String paymentKey;      // 토스 결제 키
	private String orderId;         // 내부 주문 ID
	private long amount;            // 결제 금액
	private int orderReceiptId;     // DB상 주문 영수증 ID
	private List<CartItem> cartItemList; //장바구니 상품 목록 
}
