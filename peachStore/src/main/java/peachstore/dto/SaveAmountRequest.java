package peachstore.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 토스에서 주는 결제 정보 DTO
 * @author 김예진
 * @since 2025-08-02
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SaveAmountRequest {
    private String orderId;
    private Long amount;
}