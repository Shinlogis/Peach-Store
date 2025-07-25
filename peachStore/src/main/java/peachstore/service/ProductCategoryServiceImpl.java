package peachstore.service;

import java.util.List;

import org.springframework.stereotype.Service;

import peachstore.domain.ProductCategory;
import peachstore.repository.ProductCategoryDAO;

/**
 * 제품 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Service
public class ProductCategoryServiceImpl implements ProductCategoryService{

	private final ProductCategoryDAO productCategoryDAO;
	
	public ProductCategoryServiceImpl(ProductCategoryDAO productCategoryDAO) {
	    this.productCategoryDAO = productCategoryDAO;
	}
	
	@Override
	public List<ProductCategory> selectAll() {
		return productCategoryDAO.selectAll();
	}

	@Override
	public void save(ProductCategory productCategory) {
		productCategoryDAO.save(productCategory);
	}

}
