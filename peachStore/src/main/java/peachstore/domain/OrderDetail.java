package peachstore.domain;


import lombok.Data;

@Data
public class OrderDetail {

	private int orderDetailId;
	private int orderQuantity;
	private OrderReceipt orderReceipt;
	private SnapShot snapshot;

}
