package peachstore.repository.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ProductColor;
import peachstore.exception.ProductColorException;

/**
 * ProductColorDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisProductColorDAO implements ProductColorDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public void insert(ProductColor productColor) throws ProductColorException {
        int result = sqlSessionTemplate.insert("ProductColor.insert", productColor);
        if (result < 1) {
            throw new ProductColorException("상품 색상 등록 실패");
        }
    }

	@Override
	public void deleteByProductId(int productId) {
		sqlSessionTemplate.delete("ProductColor.deleteByProductId", productId);
	}
}
