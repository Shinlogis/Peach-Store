package peachstore.service.orderreceipt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.OrderReceipt;
import peachstore.exception.OrderException;
import peachstore.repository.orderreceipt.OrderReceiptDAO;

@Service
public class OrderReceiptServiceImpl implements OrderReceiptService{
	
	@Autowired
	private OrderReceiptDAO orderReceiptDAO;

	@Override
	public List selectByUserId(OrderReceipt orderReceipt) {
		return orderReceiptDAO.selectByUserId(orderReceipt);
	}

	@Override
	public List cancleList(OrderReceipt orderReceipt) {
		return orderReceiptDAO.cancleList(orderReceipt);
	}

	@Override
	public void cancle(OrderReceipt orderReceipt) throws OrderException{
		orderReceiptDAO.cancle(orderReceipt);
	}

	@Override
	public OrderReceipt selectById(int orderReceiptId) {
		return orderReceiptDAO.selectById(orderReceiptId);
	}

}
