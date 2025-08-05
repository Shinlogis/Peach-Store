package peachstore.repository.order;

import java.util.List;
import java.util.Map;
/**
 * 주문 관련 DAO 인터페이스
 * @author 김지민
 * @since 2025-08-05
 */
public interface OrderDAO {
	List<Map<String, Object>> getAllOrders();
    int updateOrderStatus(Map<String, Object> param);
}
