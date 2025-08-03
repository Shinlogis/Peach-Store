package peachstore.domain;

import lombok.Data;
/**
 * 상품각인 도메인
 * @author 이세형
 * @since 2025-08-02
 */
@Data
public class ProductEngraving {
	private int product_engraving_id;
	private int engraving_price;
	private String engraving_text;
}
