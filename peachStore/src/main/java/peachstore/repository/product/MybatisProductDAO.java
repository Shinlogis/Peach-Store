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
 * ProductDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisProductDAO implements ProductDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<Product> selectAll() {
        return sqlSessionTemplate.selectList("Product.selectAll");
    }

    @Override
    public Product select(int product_id) {
        return sqlSessionTemplate.selectOne("Product.select", product_id);
    }

    @Override
    public void insert(Product product) throws ProductException {
        int result = sqlSessionTemplate.insert("Product.insert", product);
        if (result < 1) {
            throw new ProductException("등록 실패");
        }
    }


    @Override
    public void update(Product product) throws ProductException {
        int result = sqlSessionTemplate.update("Product.update", product);
        if (result < 1) {
            throw new ProductException("상품 수정 실패");
        }
    }

	@Override
	public void softDelete(int product_id) throws ProductException{
		int result = sqlSessionTemplate.update("Product.softDelete", product_id);
		    if (result < 1) {
		        throw new ProductException("상품 삭제 실패");
		    }
	}
    
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
