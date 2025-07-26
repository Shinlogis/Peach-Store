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
	public List<ProductCategory> selectAll(String searchKey);
	
	/**
	 * 제품 카테고리 등록
	 * @param categoryName
	 */
	public void register(ProductCategory productCategory);
	
	/**
	 * 제품 카테고리 수정
	 * @param productCategory
	 * @return
	 */
	public void changeName(int productCategoryId, String productCategoryName);
	
	/**
	 * 제품 카테고리 비활성화
	 * @param productCategory
	 */
	public void deactivate(int productCategoryId);
	

	/**
	 * pk를 통해 제품 카테고리 조회
	 * @param productCategoryId
	 * @return
	 */
	public ProductCategory findById(int productCategoryId);

}
