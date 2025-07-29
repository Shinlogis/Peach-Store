package peachstore.repository;

import java.util.List;

import peachstore.domain.ProductSubcategory;


/**
 * 제품 하위 카테고리 DAO입니다
 * 
 * @author 김예진
 * @since 2025-07-28
 */
public interface ProductSubcategoryDAO {

	/**
	 * 상위카테고리와 조인한 하위카테고리 전체 조회
	 * @return
	 */
	public List<ProductSubcategory> selectAllWithTopcategory();
	
	/**
	 * 제품 하위카테고리 등록
	 * @param productTopCategory
	 */
	public void register(ProductSubcategory productSubcategory);
	
}
