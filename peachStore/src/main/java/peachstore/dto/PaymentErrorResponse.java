package peachstore.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 결제 에러 메시지 dto
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentErrorResponse {
    private int code;          // "INVALID_REQUEST", "PAYMENT_FAILED"
    private String message;       // "결제에 실패했습니다. 다시 시도해주세요."
}