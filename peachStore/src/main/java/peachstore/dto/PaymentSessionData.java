package peachstore.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 결제 전 세션용, 결제 관련 정보 묶음 dto
 */
@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentSessionData {

	private AddressData addressData; // 주소정보
    private String orderId; // 내부 주문 ID
    private long amount; // 결제 금액
}