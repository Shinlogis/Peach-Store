package peachstore.service.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.order.OrderDAO;

/**
 * 주문 관련 서비스 구현
 * @author 김지민
 * @since 2025-08-05
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Override
    public List<Map<String, Object>> getAllOrders() {
    	return orderDAO.getAllOrders();
    }

	@Override
	public int updateOrderStatus(int orderReceiptId, String orderStatus) {
		Map<String, Object> param = new HashMap<>();
        param.put("orderReceiptId", orderReceiptId);
        param.put("orderStatus", orderStatus);
        return orderDAO.updateOrderStatus(param);
	}
}