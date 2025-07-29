package peachstore.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OrderReceipt {
	private int order_receipt_id;
	private LocalDateTime orderDate;
	private String order_status; // '상품 준비 전', '상품 준비 중', '발송완료' 중 하나
	private User user;
}
