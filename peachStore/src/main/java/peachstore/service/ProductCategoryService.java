package peachstore.service;

import java.util.List;

import peachstore.domain.ProductCategory;

/**
 * 제품 카테고리 서비스 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-25
 */
public interface ProductCategoryService {
	
	/**
	 * 제품 카테고리 전체 조회
	 * @return
	 */
	public List<ProductCategory> selectAll();
	
	/**
	 * 제품 카테고리 등록
	 * @param categoryName
	 */
	public void save(ProductCategory productCategory);
}
