package peachstore.repository.subcategory;

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
	public List<ProductSubcategory> findAllWithTopcategory(String searchKey) {
		// 검색어 담을 파라미터 맵
		Map<String, Object> paramMap = new HashMap<>();

		String trimmedSearchKey = null;
		// searchKey가 있는 경우
		if (searchKey != null) {
			trimmedSearchKey = searchKey.trim(); // 공백 제거
			// searchKey가 비어있으면 null로 전달해서 매퍼에서 조건 무시
			if (trimmedSearchKey.isEmpty()) {
				trimmedSearchKey = null;
			}
		}
		paramMap.put("searchKey", trimmedSearchKey);

		List<ProductSubcategory> list = sqlSessionTemplate.selectList("peachstore.repository.subcategory.ProductSubcategoryDAO.selectAllWithTopcategory", paramMap);
		log.debug("selectAll - searchKey: {}, resultCount: {}", searchKey, list.size());
		return list;
	}

	@Override
	public int insert(ProductSubcategory productSubcategory) {
		int result = sqlSessionTemplate.insert("peachstore.repository.subcategory.ProductSubcategoryDAO.insert", productSubcategory);
		log.debug("insert - productSubcategory: {}", productSubcategory);
		return result;
	}

	@Override
	public int update(ProductSubcategory productSubcategory) {
		int result = sqlSessionTemplate.update("peachstore.repository.subcategory.ProductSubcategoryDAO.update", productSubcategory);
		log.debug("update - ProductSubcategory: {}", productSubcategory);
		return result;
	}

	@Override
	public ProductSubcategory findById(int subcategoryId) {
		ProductSubcategory result = sqlSessionTemplate.selectOne("peachstore.repository.subcategory.ProductSubcategoryDAO.selectById", subcategoryId);
		log.debug("selectById - result: {}", result);
		return result;
	}

	@Override
	public List<ProductSubcategory> findAllByTopcategoryId(int productTopcategoryId) {
		List<ProductSubcategory> list = sqlSessionTemplate.selectList("peachstore.repository.subcategory.ProductSubcategoryDAO.selectAllSubcategoryByTopcategoryId", productTopcategoryId);
		log.debug("selectAllSubcategoryByTopcategoryId - resultCount: {}", list.size());
		return list;
	}
}
	
