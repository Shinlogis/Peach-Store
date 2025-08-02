package peachstore.repository.product;

import peachstore.domain.ProductSize;

/**
 * 상품 사이즈(ProductSize) 관련 DAO 인터페이스  
 * 상품 등록 시 선택된 사이즈 정보를 DB에 저장하기 위한 메서드를 정의
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductSizeDAO {
    public void insert(ProductSize productSize);
}