package peachstore.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductCategory;
import peachstore.exception.ProductCategoryException;
import peachstore.repository.ProductCategoryDAO;

/**
 * 제품 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Service
@RequiredArgsConstructor
public class ProductCategoryServiceImpl implements ProductCategoryService{

	private final ProductCategoryDAO productCategoryDAO;
	
	@Override
	public List<ProductCategory> selectAll(String searchKey) {
		return productCategoryDAO.selectAll(searchKey);
	}

	@Override
	public void register(ProductCategory productCategory) {
		productCategoryDAO.register(productCategory);
	}
	
	@Override
	public void changeName(int productCategoryId, String newName) {
	    ProductCategory category = findById(productCategoryId);
	    category.setName(newName);
	    
	    int result = productCategoryDAO.update(category);
	    if (result == 0) {
	        throw new ProductCategoryException("이름 변경 실패");
	    }
	}

	@Override
	public void deactivate(int productCategoryId) throws ProductCategoryException {
	    ProductCategory category = findById(productCategoryId);
	    category.deactivate(); 

	    int result = productCategoryDAO.update(category); 
	    if (result == 0) {
	        throw new ProductCategoryException("카테고리 비활성화 실패");
	    }
	}

	@Override
	public ProductCategory findById(int productCategoryId) {
		ProductCategory productCategory = productCategoryDAO.findById(productCategoryId);
		if (productCategory == null || !productCategory.isActive()) {
	        throw new ProductCategoryException("카테고리 조회 실패. 존재하지 않거나 비활성화");
	    }
		
	    return productCategory;
	}
}
