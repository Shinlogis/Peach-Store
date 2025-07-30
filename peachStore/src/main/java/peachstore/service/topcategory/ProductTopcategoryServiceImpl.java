package peachstore.service.topcategory;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductTopcategoryException;
import peachstore.repository.topcategory.ProductTopcategoryDAO;

/**
 * 제품 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Service
@RequiredArgsConstructor
public class ProductTopcategoryServiceImpl implements ProductTopcategoryService{

	private final ProductTopcategoryDAO productCategoryDAO;
	
	@Override
	public List<ProductTopcategory> selectAll(String searchKey) {
		return productCategoryDAO.selectAll(searchKey);
	}

	@Override
	public void register(ProductTopcategory productTopcategory) throws ProductTopcategoryException {
		int result = productCategoryDAO.insert(productTopcategory);
		if (result == 0) {
			throw new ProductTopcategoryException("상위 카테고리 등록 실패");
		}
	}
	
	@Override
	public void changeName(int productTopCategoryId, String newName) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.setProductTopcategoryName(newName);
	    
	    int result = productCategoryDAO.update(productTopcategory);
	    if (result == 0) {
	        throw new ProductTopcategoryException("이름 변경 실패");
	    }
	}

	@Override
	public void deactivate(int productTopCategoryId) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.deactivate(); 

	    int result = productCategoryDAO.update(productTopcategory); 
	    if (result == 0) {
	        throw new ProductTopcategoryException("카테고리 비활성화 실패");
	    }
	}

	@Override
	public ProductTopcategory findById(int productTopCategoryId) throws ProductTopcategoryException {
		ProductTopcategory productTopcategory = productCategoryDAO.selectById(productTopCategoryId);
		if (productTopcategory == null || !productTopcategory.isActive()) {
	        throw new ProductTopcategoryException("카테고리 조회 실패. 존재하지 않거나 비활성화");
	    }
		
	    return productTopcategory;
	}

	@Override
	public List<ProductTopcategory> selectAll() {
	    return productCategoryDAO.selectAll();
	}
}
