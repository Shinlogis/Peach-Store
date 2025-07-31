package peachstore.service.orderreceipt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.OrderReceipt;
import peachstore.repository.orderreceipt.OrderReceiptDAO;

@Service
public class OrderReceiptServiceImpl implements OrderReceiptService{
	
	@Autowired
	private OrderReceiptDAO orderReceiptDAO;

	@Override
	public List selectByUserId(OrderReceipt orderReceipt) {
		return orderReceiptDAO.selectByUserId(orderReceipt);
	}

}
