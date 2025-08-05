package peachstore.domain;

import java.time.LocalDateTime;

import lombok.Data;

/**
 * 주문 관련 뷰
 * @author 김지민
 * @since 2025-08-05
 */
@Data
public class OrderView {
	    private int orderReceiptId;
	    private String customerName;
	    private LocalDateTime orderDate;
	    private String productName;
	    private int quantity;
	    private int totalAmount;
	    private String orderStatus;
}
