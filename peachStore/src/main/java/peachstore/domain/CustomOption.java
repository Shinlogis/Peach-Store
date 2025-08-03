package peachstore.domain;

import lombok.Data;

/**
 * 커스텀옵션 모델링 수정
 * @author 김지민 -> 이세형
 * @since 2025-08-02
 */
@Data
public class CustomOption {
	private int custom_option_id;
	private ProductSize product_size;
	private ProductColor product_color;
	private ProductCapacity product_capacity; 
	private ProductEngraving product_engraving;
}
