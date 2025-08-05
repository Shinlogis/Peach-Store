package peachstore.admin.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import peachstore.domain.OrderView;
import peachstore.service.order.OrderService;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/order/orderlist")
    public String showOrderList(Model model) {
        List<Map<String, Object>> rawList = orderService.getAllOrders();
        List<OrderView> orderList = new ArrayList<>();

        for (Map<String, Object> map : rawList) {
            OrderView ov = new OrderView();
            ov.setOrderReceiptId(((Number) map.get("orderReceiptId")).intValue()); 
            ov.setCustomerName((String) map.get("customerName"));
            ov.setOrderDate((LocalDateTime) map.get("orderDate"));
            ov.setProductName((String) map.get("productName"));
            ov.setQuantity(((Number) map.get("quantity")).intValue());     
            ov.setTotalAmount(((Number) map.get("totalAmount")).intValue()); 
            ov.setOrderStatus((String) map.get("orderStatus"));
            orderList.add(ov);
        }

        model.addAttribute("orderList", orderList);
        return "/order/orderlist";
    }

}