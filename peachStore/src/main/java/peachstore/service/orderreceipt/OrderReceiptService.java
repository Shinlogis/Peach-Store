package peachstore.service.orderreceipt;

import java.time.LocalDateTime;
import java.util.List;

import peachstore.domain.OrderReceipt;
import peachstore.domain.Tosspayment;
import peachstore.domain.User;

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
	/**
	 * 주문내역 생성
	 * @param localDateTime
	 * @param orderStatus
	 * @param user
	 * @param tosspayment
	 * @return OrderReceipt 등록한 주문내역 반환
	 */
	public OrderReceipt insert(LocalDateTime localDateTime, String orderStatus, User user, Tosspayment tosspayment);
}
