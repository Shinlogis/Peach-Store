package peachstore.repository.product;

import peachstore.domain.ProductSize;

/**
 * 상품 사이즈(ProductSize) 관련 DAO 인터페이스  
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductSizeDAO {
    public void insert(ProductSize productSize);
    public void deleteByProductId(int productId);

}