package peachstore.domain;

import lombok.Data;
import lombok.ToString;

/**
 * 상품별 이미지
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class ProductImg {
	private int product_img_id; //
	private String filename;
	
	@ToString.Exclude
	private Product product;

}
