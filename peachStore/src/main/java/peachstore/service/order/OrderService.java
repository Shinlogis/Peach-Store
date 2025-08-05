package peachstore.service.order;

import java.util.List;
import java.util.Map;

public interface OrderService {
    List<Map<String, Object>> getAllOrders();
}