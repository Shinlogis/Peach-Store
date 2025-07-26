package peachstore.repository;

import java.util.List;

import peachstore.domain.ProductCategory;


/**
 * 제품 카테고리 DAO입니다
 * 
 * @author 김예진
 * @since 2025-07-24
 */
public interface ProductCategoryDAO {
	
	/**
	 * 제품 카테고리 전체 조회
	 * @param productCategory
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
	 * @return update row 수
	 */
	public int update(ProductCategory productCategory);
	
	/**
	 * pk값으로 제품 카테고리 조회
	 * @param productCategoryId
	 * @return
	 */
	public ProductCategory findById(int productCategoryId);

}
