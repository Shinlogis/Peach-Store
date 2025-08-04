package peachstore.repository.orderreceipt;

import java.util.List;

import peachstore.domain.OrderReceipt;

public interface OrderReceiptDAO {

	public List selectByUserId(OrderReceipt orderReceipt);
	
	public List cancleList(OrderReceipt orderReceipt);
	
	public void cancle(OrderReceipt orderReceipt);
	
	public OrderReceipt selectById(int orderReceiptId);
	
	public List  completedList(OrderReceipt orderReceipt);
}
