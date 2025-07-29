package peachstore.model.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ProductSize;
import peachstore.exception.ProductColorException;

@Repository
public class MybatisProductSizeDAO implements ProductSizeDAO{

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public void insert(ProductSize productSize) throws ProductColorException{
		int result = sqlSessionTemplate.insert("ProductSize.insert", productSize);
		if(result < 1) {
			throw new ProductColorException("상품 색상 등록 실패");
		}
	}

}
