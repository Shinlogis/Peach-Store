package peachstore.domain;

import lombok.Data;

/**
 * 상품별 용량
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class CustomOption {
	private int custom_option_id;
	private Size size;
	private Color color;
	private Capacity capacity; 
}
