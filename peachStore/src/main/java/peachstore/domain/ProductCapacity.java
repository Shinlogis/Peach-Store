package peachstore.domain;

import lombok.Data;
import lombok.ToString;

/**
 * 상품별 용량
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class ProductCapacity {
	private int product_capacity_id;  
	private int additional_price;  
	private Capacity capacity;
	
	@ToString.Exclude
	private Product product;
	
}
