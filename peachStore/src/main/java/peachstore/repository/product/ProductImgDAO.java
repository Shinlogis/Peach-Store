package peachstore.repository.product;

import java.util.List;

import peachstore.domain.ProductImg;

public interface ProductImgDAO {
	public void insert(ProductImg productImg);
	List<ProductImg> selectByProductId(int productId); 
}
