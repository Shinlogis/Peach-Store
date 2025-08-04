package peachstore.repository.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.Capacity;
import peachstore.domain.Product;
import peachstore.domain.ProductCapacity;
import peachstore.exception.ProductCapacityException;
import peachstore.exception.ProductSizeException;

/**
 * ProductCapacityDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-08-01
 */
@Repository
public class MybatisProductCapacityDAO implements ProductCapacityDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(ProductCapacity productCapacity) throws ProductCapacityException{
		int result = sqlSessionTemplate.insert("ProductCapacity.insert", productCapacity);
        if (result < 1) {
            throw new ProductCapacityException("상품 용량 등록 실패");
        }
		
	}

	@Override
	public void deleteByProductId(int productId) {
		sqlSessionTemplate.delete("ProductCapacity.deleteByProductId", productId);
	}
}
