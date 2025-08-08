package peachstore.service.subcategory;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;

/**
 * 제품 상위카테고리 서비스 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-25
 */
public interface ProductSubcategoryService {

	/**
	 * 상위카테고리와 조인한 하위카테고리 조회
	 * 
	 * @param searchKey null일 경우 전체 조회
	 * @return
	 */
	public List<ProductSubcategory> findAllWithTopcategory(String searchKey);
	
	/**
	 * 제품 하위카테고리 등록
	 * @param productSubCategory
	 */
	public void register(String name, int topcategoryId);
	

	/**
	 * 제품 하위카테고리 등록
	 * @param productTopCategory
	 * @param savePath 파일 저장 경로
	 */
	public void register(String productSubCategoryName, int productTopcategoryId, String savePath, MultipartFile photo);
	
	/**
	 * 하위카테고리 수정
	 * @param productSubCategoryId
	 * @param newName
	 * @param savePath
	 * @param photo
	 */
	public void change(int productSubCategoryId, String newName, String savePath, MultipartFile photo);
	
	/**
	 * 하위 카테고리 이름 수정
	 * @param name
	 * @param subcategoryId
	 */
	public void updateName(String name, int subcategoryId);
	
	/**
	 * 하위 카테고리 비활성화
	 * @param subcategoryId
	 */
	public void toggleActivation(int subcategoryId);

	/**
	 * id로 서브카테고리 조회
	 * @param subcategoryId
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
