package peachstore.service;

import java.util.List;

import peachstore.domain.ProductTopcategory;

/**
 * 제품 상위카테고리 서비스 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-25
 */
public interface ProductTopcategoryService {

	/**
	 * 제품 상위카테고리 전체 조회
	 * 
	 * @param searchKey  null일 경우 전체 조회
	 * @return
	 */
	public List<ProductTopcategory> selectAll(String searchKey);
	
	/**
	 * 제품 상위카테고리 등록
	 * @param categoryName
	 */
	public void register(ProductTopcategory productTopCategory);
	
	/**
	 * 제품 상위카테고리 수정
	 * @param productTopCategoryId
	 * @param productTopCategoryName
	 */
	public void changeName(int productTopCategoryId, String productTopCategoryName);
	
	/**
	 * 제품 상위카테고리 비활성화
	 * @param productCategory
	 */
	public void deactivate(int productTopCategoryId);
	

	/**
	 * pk를 통해 제품 상위카테고리 조회
	 * @param productTopCategoryId
	 * @return
	 */
	public ProductTopcategory findById(int productTopCategoryId);

}
