package peachstore.repository.product;

import peachstore.domain.ProductCapacity;
/**
 * 상품 용량 DAO
 * @author 김지민
 * @since 2025-08-01
 */
public interface ProductCapacityDAO {
	public void insert(ProductCapacity productCapacity);
	public void deleteByProductId(int productId);
}