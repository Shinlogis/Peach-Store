package peachstore.repository.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.Product;
import peachstore.exception.ProductException;

/**
 * ProductDAO 인터페이스를 구현하며,
 * 상품 목록 조회, 상세 조회, 상품 등록 기능
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
    
    /**
     * 상품 서브카테고리로 조회 
     */
	@Override
	public List<Product> selectBySubId(int subId) {
		return sqlSessionTemplate.selectList("Product.selectBySubId",subId);
	}
	
    @Override
    public List<Product> selectAllWithPaging(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("startIndex", startIndex);
        paramMap.put("pageSize", pageSize);

        List<Product> result = sqlSessionTemplate.selectList("Product.selectAllWithPaging", paramMap);

        return result;
    }

	@Override
	public int count() {
		return sqlSessionTemplate.selectOne("Product.count");
	}
}
