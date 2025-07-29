package peachstore.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductSubcategory;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ProductSubcategoryDAOImpl implements ProductSubcategoryDAO {

	private final SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<ProductSubcategory> selectAllWithTopcategory() {
		List<ProductSubcategory> list = sqlSessionTemplate.selectList("peachstore.repository.ProductSubcategoryDAO.selectAllWithTopcategory");
        log.debug("selectAll - resultCount: {}", list.size());
        return list;
	}

	@Override
	public void register(ProductSubcategory productSubcategory) {
		sqlSessionTemplate.insert("peachstore.repository.ProductSubcategoryDAO.insert", productSubcategory);
		log.debug("register - productSubcategory: {}", productSubcategory);
	}

}
