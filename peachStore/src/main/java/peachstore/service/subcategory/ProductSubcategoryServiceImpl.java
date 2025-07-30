package peachstore.service.subcategory;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductSubcategoryException;
import peachstore.repository.subcategory.ProductSubcategoryDAO;
import peachstore.service.topcategory.ProductTopcategoryService;

@Service
@RequiredArgsConstructor
public class ProductSubcategoryServiceImpl implements ProductSubcategoryService {

	private final ProductSubcategoryDAO productSubcategoryDAO;
	private final ProductTopcategoryService productTopcategoryService;

	@Override
	public List<ProductSubcategory> findAllWithTopcategory(String searchKey) {
		return productSubcategoryDAO.findAllWithTopcategory(searchKey);
	}

	@Override
	public void register(String name, int topcategoryId) throws ProductSubcategoryException{
		// 상위 카테고리 조회
		ProductTopcategory productTopcategory = productTopcategoryService.findById(topcategoryId);

		// 하위 카테고리 생성
		ProductSubcategory productSubcategory = new ProductSubcategory();
		productSubcategory.setProductTopcategory(productTopcategory);
		productSubcategory.setProductSubcategoryName(name);
		
		int result = productSubcategoryDAO.insert(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 등록 실패");
		}
	}

	@Override
	public void updateName(String name, int subcategoryId) throws ProductSubcategoryException{
		// 해당 서브 카테고리 조회
		ProductSubcategory productSubcategory = findById(subcategoryId);
		productSubcategory.setProductSubcategoryName(name);
		
		int result = productSubcategoryDAO.update(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 이름 수정 실패");
		}
	}

	@Override
	public void deactivate(int subcategoryId) throws ProductSubcategoryException {
		// 해당 서브 카테고리 조회
		ProductSubcategory productSubcategory = findById(subcategoryId);
		productSubcategory.deactivate();
		
		int result = productSubcategoryDAO.update(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 비활성화 실패");
		}
	}

	@Override
	public ProductSubcategory findById(int subcategoryId) throws ProductSubcategoryException{
		ProductSubcategory productSubcategory = productSubcategoryDAO.findById(subcategoryId);
		if (productSubcategory == null || !productSubcategory.isActive()) {
			throw new ProductSubcategoryException("서브 카테고리 조회 실패. 존재하지 않거나 비활성화");
		}
		return productSubcategory;
	}

	@Override
	public List<ProductSubcategory> findAllByTopcategoryId(int productTopcategoryId) {
		return productSubcategoryDAO.findAllByTopcategoryId(productTopcategoryId);
	}

}
