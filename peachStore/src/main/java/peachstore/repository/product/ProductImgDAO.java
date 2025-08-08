package peachstore.repository.product;

import java.util.List;

import peachstore.domain.ProductImg;

/**
 * 상품 사진(ProductImg) 관련 DAO 인터페이스  
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductImgDAO {
	public void insert(ProductImg productImg);
	public List<ProductImg> selectByProductId(int productId); 
	void deleteByFilename(String filename);
}
