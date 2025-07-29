package peachstore.service;

import java.util.List;

import peachstore.domain.ProductSubcategory;

/**
 * 제품 상위카테고리 서비스 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-25
 */
public interface ProductSubcategoryService {

	/**
	 * 상위카테고리와 조인한 하위카테고리 전체 조회
	 * @return
	 */
	public List<ProductSubcategory> selectAllWithTopcategory();
	
	/**
	 * 제품 하위카테고리 등록
	 * @param productSubCategory
	 */
	public void register(ProductSubcategory productSubCategory);
	

}
