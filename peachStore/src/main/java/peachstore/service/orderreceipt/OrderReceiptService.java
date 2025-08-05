package peachstore.service.orderreceipt;

import java.util.List;

import peachstore.domain.OrderReceipt;

public interface OrderReceiptService {

	public List selectByUserId(OrderReceipt orderReceipt);
	
	public List cancleList(OrderReceipt orderReceipt);
	
	public void cancle(OrderReceipt orderReceipt);
	
	/**
	 * pk로 조회
	 * @param orderReceiptId
	 * @return
	 */
	public OrderReceipt selectById(int orderReceiptId);
	
	public List completedList(OrderReceipt orderReceipt);
	
	public int countByUserId(OrderReceipt orderReceipt);
	 
	public List<OrderReceipt> paging(OrderReceipt orderReceipt, int startIndex, int pageSize);
	
	public List<OrderReceipt> cancleListPaging(OrderReceipt orderReceipt, int startIndex, int pageSize);
	
	public List<OrderReceipt> completedListPaging(OrderReceipt orderReceipt, int startIndex, int pageSize);
}
