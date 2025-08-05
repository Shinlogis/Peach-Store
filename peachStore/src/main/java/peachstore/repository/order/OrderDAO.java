package peachstore.repository.order;

import java.util.List;
import java.util.Map;

public interface OrderDAO {
	List<Map<String, Object>> getAllOrders();
}
