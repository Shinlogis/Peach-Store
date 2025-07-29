package peachstore.model.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import peachstore.domain.Product;
import peachstore.exception.ProductException;
import peachstore.util.FileManager;

@Service
public class ProductServiceImpl implements ProductService{
	

	@Autowired
	private ProductDAO productDAO;
	

	@Autowired
	private FileManager fileManager;
	
	@Transactional
	public void regist(Product product, String savePath) throws ProductException {
		productDAO.insert(product);
		
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
