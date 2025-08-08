package peachstore.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class OrderReceipt {
	private int order_receipt_id;
	private LocalDateTime orderdate;
	private String order_status; // '상품 준비 전', '상품 준비 중', '발송완료' 중 하나
	private User user;
	private String postcode;
	private String address;
	private String detailAddress;
	
	private List<OrderDetail> orderList;
	
	private Tosspayment tosspayment; // 결제 정보
}
