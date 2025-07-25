package peachstore.domain;

import lombok.Data;

/**
 * 제품 카테고리
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Data
public class ProductCategory {
	
	private int productCategoryId;
	
	private String productCategoryName;
	
	private boolean isActive;
}
