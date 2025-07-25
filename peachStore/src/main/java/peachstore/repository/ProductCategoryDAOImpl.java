package peachstore.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductCategory;


/**
 * 제품 카테고리 하이버네이트 구현체 DAO입니다
 * 
 * @author 김예진
 * @since 2025-07-24
 */
@Slf4j
@Repository
public class ProductCategoryDAOImpl implements ProductCategoryDAO{
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public ProductCategoryDAOImpl(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	@Override
	public List<ProductCategory> selectAll() {
		return sqlSessionTemplate.selectList("peachstore.repository.ProductCategoryDAO.selectAll");
	}

	@Override
	public void save(ProductCategory productCategory) {
		sqlSessionTemplate.insert("peachstore.repository.ProductCategoryDAO.insert", productCategory);
	}

}
