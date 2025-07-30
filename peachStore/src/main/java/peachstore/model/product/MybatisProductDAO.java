package peachstore.model.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.Product;
import peachstore.exception.ProductException;

/**
 * 상품(Product) 관련 MyBatis DAO 구현체
 * ProductDAO 인터페이스를 구현하며,
 * 상품 목록 조회, 상세 조회, 상품 등록 기능을 MyBatis 기반으로 수행한다.
 * 
 * SqlSessionTemplate을 사용해 Mapper XML의 쿼리를 실행한다.
 * 등록 실패 시 ProductException을 발생시킨다.
 * 
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisProductDAO implements ProductDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 전체 상품 목록 조회
     * @return 상품 리스트
     */
    @Override
    public List<Product> selectAll() {
        return sqlSessionTemplate.selectList("Product.selectAll");
    }

    /**
     * 특정 상품 상세 조회
     * @param product_id 상품 ID
     * @return 조회된 상품 객체
     */
    @Override
    public Product select(int product_id) {
        return sqlSessionTemplate.selectOne("Product.select", product_id);
    }

    /**
     * 상품 등록
     * @param product 등록할 상품 객체
     * @throws ProductException 등록 실패 시 예외 발생
     */
    @Override
    public void insert(Product product) throws ProductException {
        int result = sqlSessionTemplate.insert("Product.insert", product);
        if (result < 1) {
            throw new ProductException("등록 실패");
        }
    }

    /**
     * 상품 수정 (미구현)
     * @param product 수정할 상품 객체
     */
    @Override
    public void update(Product product) {
        // TODO: 상품 수정 구현 예정
    }

    /**
     * 상품 삭제 (미구현)
     * @param product 삭제할 상품 객체
     */
    @Override
    public void delete(Product product) {
        // TODO: 상품 삭제 구현 예정
    }
}
