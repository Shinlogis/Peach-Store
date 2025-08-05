package peachstore.admin.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import peachstore.domain.OrderView;
import peachstore.service.order.OrderService;

/**
 * 주문 관련 컨트롤러
 * @author 김지민
 * @since 2025-08-05
 */
@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/order/orderlist")
    public String showOrderList(Model model) {
        
    	List<Map<String, Object>> rawList = orderService.getAllOrders();
        List<OrderView> orderList = new ArrayList<>();
        
        if (rawList == null) {
            model.addAttribute("orderList", new ArrayList<>());
            return "/order/orderlist";
        }
        
        for (Map<String, Object> map : rawList) {
            OrderView ov = new OrderView();
            ov.setOrderReceiptId(((Number) map.get("orderReceiptId")).intValue()); 
            ov.setCustomerName((String) map.get("customerName"));
            ov.setOrderDate((LocalDateTime) map.get("orderDate"));
            ov.setProductName((String) map.get("productName"));   
            ov.setTotalAmount(((Number) map.get("totalAmount")).intValue()); 
            ov.setOrderStatus((String) map.get("orderStatus"));
            orderList.add(ov);
        }

    model.addAttribute("orderList", orderList);
        return "/order/orderlist";
    }
    
    // 주문 상태 변경
    @PostMapping("/order/updateStatus")
    @ResponseBody
    public String updateOrderStatus(
            @RequestParam("orderId") int orderReceiptId,
            @RequestParam("orderStatus") String orderStatus) {

        int result = orderService.updateOrderStatus(orderReceiptId, orderStatus);

        // 간단하게 처리 결과만 반환
        return result > 0 ? "success" : "fail";
    }
    
    

}