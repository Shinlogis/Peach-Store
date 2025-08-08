package peachstore.repository.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import peachstore.domain.ProductImg;
import peachstore.exception.ProductImgException;

/**
 * ProductImgDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-07-29
 */

@Repository
public class MybatisProductImgDAO implements ProductImgDAO{

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	public void insert(ProductImg productImg) throws ProductImgException{
		int result = sqlSessionTemplate.insert("ProductImg.insert", productImg);
		
		if(result < 1) {
			throw new ProductImgException("상품 이미지 등록 실패");
		}
	}


	@Override
	public List<ProductImg> selectByProductId(int productId) {
	    return sqlSessionTemplate.selectList("ProductImg.selectByProductId", productId);
	}


	@Override
	public void deleteByFilename(String filename) {
		sqlSessionTemplate.delete("ProductImg.deleteByFilename", filename);
	}

}
