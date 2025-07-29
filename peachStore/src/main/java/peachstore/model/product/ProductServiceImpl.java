package peachstore.model.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import peachstore.domain.Product;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductImg;
import peachstore.domain.ProductSize;
import peachstore.exception.ProductColorException;
import peachstore.exception.ProductException;
import peachstore.exception.ProductSizeException;
import peachstore.util.FileManager;

@Service
public class ProductServiceImpl implements ProductService{
	

	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ProductColorDAO productColorDAO;
	
	@Autowired
	private ProductSizeDAO productSizeDAO;
	

	@Autowired
	private FileManager fileManager;
	
	@Transactional
	public void regist(Product product, String savePath) throws ProductException, ProductColorException, ProductSizeException{
		productDAO.insert(product);
		
		//2) 유저가 선택한 색상 수 만큼 반복문으로 insert 수행
		for(ProductColor productColor : product.getProductColors()) {
			//누락되어 있었던 product 을 대입해주자 
			productColor.setProduct(product); //mybatis에 의해 pk가 채워진 product 대입
			productColorDAO.insert(productColor);
		}
		
		//3)유저가 선택한 사이즈 수 만큼 반복문을 insert 수행 
		for(ProductSize  productSize : product.getProductSizes()) {
			productSize.setProduct(product);
			productSizeDAO.insert(productSize);
		}
	}


	@Override
	public List selectAll() {
		return productDAO.selectAll();
	}

	@Override
	public Product select(int product_id) {
		return productDAO.select(product_id);
	}

	@Override
	public void update(Product product) {
		
	}

	@Override
	public void delete(Product product) {
		
	}


	@Override
	public void remove(Product product, String savePath) {

		
	}
	

}
