package peachstore.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OrderView {
	    private int orderReceiptId;
	    private String customerName;
	    private LocalDateTime orderDate;
	    private String productName;
	    private int quantity;
	    private int totalAmount;
	    private String orderStatus;
}
