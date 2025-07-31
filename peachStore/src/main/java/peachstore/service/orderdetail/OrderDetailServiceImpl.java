package peachstore.service.orderdetail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.orderdetail.OrderDetailDAO;

@Service
public class OrderDetailServiceImpl implements OrderDetailService{

	@Autowired
	private OrderDetailDAO orderDetailDAO;

	@Override
	public List selecByReceitId(int order_receipt_id) {
		return orderDetailDAO.selecByReceitId(order_receipt_id);
	}
}
