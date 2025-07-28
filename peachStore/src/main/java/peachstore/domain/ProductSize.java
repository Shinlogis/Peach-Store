package peachstore.domain;

import lombok.Data;

/**
 * 상품별 크기
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class ProductSize {
	private int product_size_id;
	private int additional_price;
	private Size size;
	private Product product;
}
