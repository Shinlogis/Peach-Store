package peachstore.repository;

import java.util.List;

import peachstore.domain.ProductTopcategory;


/**
 * 제품 상위 카테고리 DAO입니다
 * 
 * @author 김예진
 * @since 2025-07-24
 */
public interface ProductTopcategoryDAO {
	
	/**
	 * 제품 상위카테고리 전체 조회
	 * 검색 조건 없이 전체 목록을 반환.
	 * @return 전체 상위카테고리 리스트
	 */
	public List<ProductTopcategory> selectAll();
	
	/**
	 * 제품 상위카테고리 전체 조회
	 * @param productCategory
	 * @return
	 */
	public List<ProductTopcategory> selectAll(String searchKey);
	
	/**
	 * 제품 상위카테고리 등록
	 * @param categoryName
	 */
	public int insert(ProductTopcategory productTopCategory);
	
	/**
	 * 제품 상위카테고리 수정
	 * @param productTopCategory
	 * @return update row 수
	 */
	public int update(ProductTopcategory productTopCategory);
	
	/**
	 * pk값으로 제품 상위카테고리 조회
	 * @param productTopCategoryId
	 * @return
	 */
	public ProductTopcategory selectById(int productTopCategoryId);

}
