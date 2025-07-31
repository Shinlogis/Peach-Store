package peachstore.repository.orderreceipt;

import java.util.List;

import peachstore.domain.OrderReceipt;

public interface OrderReceiptDAO {

	public List selectByUserId(OrderReceipt orderReceipt);
}
