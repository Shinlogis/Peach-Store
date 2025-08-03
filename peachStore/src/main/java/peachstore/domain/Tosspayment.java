package peachstore.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Tosspayment {

    private Long paymentId;

    private String tossPaymentKey;

    private String tossOrderId;

    private OrderReceipt orderReceipt;

    private long totalAmount;

    private String tossPaymentMethod;

    private String tossPaymentStatus;

    private LocalDateTime requestedAt;

    private LocalDateTime approvedAt;
}
