package peachstore.repository.subcategory;

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
	public List<ProductSubcategory> findAllWithTopcategory(String searchKey);
	
	/**
	 * 제품 하위카테고리 등록
	 * @param productTopCategory
	 */
	public int insert(ProductSubcategory productSubcategory);
	
	/**
	 * 하위카테고리 수정
	 * @param productSubcategory
	 * @return
	 */
	public int update(ProductSubcategory productSubcategory);
	
	/**
	 * id로 서브카테고리 조회
	 * @param subId
	 * @return
	 */
	public ProductSubcategory findById(int subcategoryId);
	
	/**
	 * 해당 id의 상위 카테고리의 모든 하위 카테고리
	 * @param productTopcategoryId
	 * @return
	 */
	public List<ProductSubcategory> findAllByTopcategoryId(int productTopcategoryId);
}
