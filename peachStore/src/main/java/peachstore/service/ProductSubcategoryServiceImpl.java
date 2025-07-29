package peachstore.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductSubcategory;
import peachstore.repository.ProductSubcategoryDAO;

@Service
@RequiredArgsConstructor
public class ProductSubcategoryServiceImpl implements ProductSubcategoryService{
	
	private final ProductSubcategoryDAO productSubcategoryDAO;

	@Override
	public List<ProductSubcategory> selectAllWithTopcategory() {
		return productSubcategoryDAO.selectAllWithTopcategory();
	}

	@Override
	public void register(ProductSubcategory productSubCategory) {
		// TODO Auto-generated method stub
		
	}

}
