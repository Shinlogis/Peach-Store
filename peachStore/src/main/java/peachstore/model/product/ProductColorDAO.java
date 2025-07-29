package peachstore.model.product;

import peachstore.domain.ProductColor;

/**
 * 상품 색상(ProductColor) 관련 DAO 인터페이스
 * 상품 등록 시 선택된 색상 정보를 DB에 저장하기 위한 메서드를 정의
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductColorDAO {

    /**
     * 상품 색상 정보 등록
     * @param productColor 등록할 상품 색상 객체
     */
    public void insert(ProductColor productColor);
}