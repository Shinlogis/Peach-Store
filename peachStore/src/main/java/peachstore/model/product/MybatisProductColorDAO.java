package peachstore.model.product;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ProductColor;
import peachstore.exception.ProductColorException;

@Repository
public class MybatisProductColorDAO implements ProductColorDAO{

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public void insert(ProductColor productColor) throws ProductColorException{
		int result = sqlSessionTemplate.insert("ProductColor.insert", productColor);
		if(result < 1) {
			throw new ProductColorException("상품 색상 등록 실패");
		}
	}

}
