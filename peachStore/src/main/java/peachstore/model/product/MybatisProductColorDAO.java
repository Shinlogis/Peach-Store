package peachstore.model.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ProductColor;
import peachstore.exception.ProductColorException;

/**
 * ProductColorDAO 인터페이스를 구현하며,
 * 상품 등록 시 선택된 색상을 DB에 저장하는 기능
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisProductColorDAO implements ProductColorDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    /**
     * 상품 색상 정보 등록
     * @param productColor 등록할 상품 색상 객체
     * @throws ProductColorException 등록 실패 시 예외 발생
     */
    public void insert(ProductColor productColor) throws ProductColorException {
        int result = sqlSessionTemplate.insert("ProductColor.insert", productColor);
        if (result < 1) {
            throw new ProductColorException("상품 색상 등록 실패");
        }
    }
}
