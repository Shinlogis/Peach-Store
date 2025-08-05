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
	
	/**
	 * 주문내역 생성
	 * 
	 * @param localDateTime 주문 시각(=결제완료 시각)
	 * @param orderStatus 상품 준비 상태
	 * @param user 주문한 사용자
	 * @param paymentId 결제번호
	 * @return
	 */
	public void insert(LocalDateTime localDateTime, String orderStatus, User user, Tosspayment tosspayment);
}
