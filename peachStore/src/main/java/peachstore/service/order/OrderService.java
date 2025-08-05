package peachstore.service.order;

import java.util.List;
import java.util.Map;

/**
 * 주문 관련 서비스 인터페이스
 * @author 김지민
 * @since 2025-08-05
 */
public interface OrderService {
    List<Map<String, Object>> getAllOrders();
    int updateOrderStatus(int orderReceiptId, String orderStatus);
}