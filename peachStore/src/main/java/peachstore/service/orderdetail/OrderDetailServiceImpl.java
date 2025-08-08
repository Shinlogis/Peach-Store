package peachstore.service.orderdetail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.exception.OrderReceiptException;
import peachstore.repository.orderdetail.OrderDetailDAO;

@Service
public class OrderDetailServiceImpl implements OrderDetailService{

	@Autowired
	private OrderDetailDAO orderDetailDAO;

	@Override
	public List selecByReceitId(int order_receipt_id) {
		return orderDetailDAO.selecByReceitId(order_receipt_id);
	}

	/**
	 * 등록 서비스
	 */
	@Override
	public int insert(int orderReceiptId, int snapshotId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("order_receipt_id", orderReceiptId);
		paramMap.put("snapshot_id", snapshotId);
		
		int result = orderDetailDAO.insert(paramMap);
		if (result == 0) {
			throw new OrderReceiptException("주문상세 등록 실패");
		}
		return result;
	}
}
