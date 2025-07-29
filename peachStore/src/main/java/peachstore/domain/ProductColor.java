package peachstore.domain;

import lombok.Data;

/**
 * 상품별 색상
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class ProductColor {
	private int product_color_id;
	private Color color;
	private Product product;
}
