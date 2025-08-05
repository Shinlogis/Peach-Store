package peachstore.service.orderreceipt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public List completedList(OrderReceipt orderReceipt) {
		return orderReceiptDAO.completedList(orderReceipt);
	}

	@Override
	public int countByUserId(OrderReceipt orderReceipt) {
		return orderReceiptDAO.countByUserId(orderReceipt);
	}

	@Override
	public List<OrderReceipt> paging(OrderReceipt orderReceipt, int startIndex, int pageSize) {
		Map<String, Object> param = new HashMap<>();
        param.put("user", orderReceipt.getUser());  
        param.put("startIndex", startIndex);
        param.put("pageSize", pageSize);

        return orderReceiptDAO.selectByUserIdPaging(param);
	}

	@Override
	public List<OrderReceipt> cancleListPaging(OrderReceipt orderReceipt, int startIndex, int pageSize) {
		Map<String, Object> param = new HashMap<>();
        param.put("user", orderReceipt.getUser());  
        param.put("startIndex", startIndex);
        param.put("pageSize", pageSize);

        return orderReceiptDAO.cancleListPaging(param);
	}

	@Override
	public List<OrderReceipt> completedListPaging(OrderReceipt orderReceipt, int startIndex, int pageSize) {
		Map<String, Object> param = new HashMap<>();
        param.put("user", orderReceipt.getUser());  
        param.put("startIndex", startIndex);
        param.put("pageSize", pageSize);

        return orderReceiptDAO.completedListPaging(param);
	}

}
