package peachstore.repository.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ProductSize;
import peachstore.exception.ProductSizeException;

/**
 * ProductSizeDAO 인터페이스를 구현하며,  
 * 상품 등록 시 선택된 사이즈 정보를 DB에 저장하는 기능을 담당 
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisProductSizeDAO implements ProductSizeDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public void insert(ProductSize productSize) throws ProductSizeException {
        int result = sqlSessionTemplate.insert("ProductSize.insert", productSize);
        if (result < 1) {
            throw new ProductSizeException("상품 사이즈 등록 실패");
        }
    }
}
