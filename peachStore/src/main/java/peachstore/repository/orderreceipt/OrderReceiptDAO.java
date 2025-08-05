package peachstore.repository.orderreceipt;

import java.util.List;
import java.util.Map;

import peachstore.domain.OrderReceipt;

public interface OrderReceiptDAO {

	public List selectByUserId(OrderReceipt orderReceipt);
	
	public List cancleList(OrderReceipt orderReceipt);
	
	public void cancle(OrderReceipt orderReceipt);
	
	public OrderReceipt selectById(int orderReceiptId);
	
	public List  completedList(OrderReceipt orderReceipt);
	
	public int countByUserId(OrderReceipt orderReceipt);
   
	public List<OrderReceipt> selectByUserIdPaging(Map<String, Object> param);
	
	public List<OrderReceipt> cancleListPaging(Map<String, Object> param);
	
	public List<OrderReceipt> completedListPaging(Map<String, Object> param);
	
	
	/**
	 * 주문내역 생성
	 * @param orderReceipt
	 * @return
	 */
	public int insert(OrderReceipt orderReceipt);
}
