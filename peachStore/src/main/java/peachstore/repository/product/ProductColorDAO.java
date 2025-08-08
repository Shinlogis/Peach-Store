package peachstore.repository.product;

import peachstore.domain.ProductColor;

/**
 * 상품 색상(ProductColor) 관련 DAO 인터페이스
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductColorDAO {

    public void insert(ProductColor productColor);
    public void deleteByProductId(int productId);

}