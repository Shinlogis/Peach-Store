package peachstore.domain;


import lombok.Data;

@Data
public class OrderDetail {

	private int order_detail_id;
	private int order_quantity;
	private OrderReceipt orderReceipt;
	private SnapShot snapShot;

}
