package peachstore.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductCategoryException;
import peachstore.repository.ProductTopcategoryDAO;

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
	public void register(ProductTopcategory productTopcategory) {
		productCategoryDAO.register(productTopcategory);
	}
	
	@Override
	public void changeName(int productTopCategoryId, String newName) {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.setProductTopcategoryName(newName);
	    
	    int result = productCategoryDAO.update(productTopcategory);
	    if (result == 0) {
	        throw new ProductCategoryException("이름 변경 실패");
	    }
	}

	@Override
	public void deactivate(int productTopCategoryId) throws ProductCategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.deactivate(); 

	    int result = productCategoryDAO.update(productTopcategory); 
	    if (result == 0) {
	        throw new ProductCategoryException("카테고리 비활성화 실패");
	    }
	}

	@Override
	public ProductTopcategory findById(int productTopCategoryId) {
		ProductTopcategory productTopcategory = productCategoryDAO.findById(productTopCategoryId);
		if (productTopcategory == null || !productTopcategory.isActive()) {
	        throw new ProductCategoryException("카테고리 조회 실패. 존재하지 않거나 비활성화");
	    }
		
	    return productTopcategory;
	}
}
