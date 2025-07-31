package peachstore.service.orderreceipt;

import java.util.List;

import peachstore.domain.OrderReceipt;

public interface OrderReceiptService {

	public List selectByUserId(OrderReceipt orderReceipt);
}
