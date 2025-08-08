package peachstore.repository.topcategory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductTopcategory;

/**
 * 제품 상위카테고리 마이바티스 DAO 구현체입니다
 * 
 * @author 김예진
 * @since 2025-07-24
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class ProductTopcategoryDAOImpl implements ProductTopcategoryDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<ProductTopcategory> selectAll(String searchKey) {
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

        List<ProductTopcategory> list = sqlSessionTemplate.selectList("peachstore.repository.topcategory.ProductTopcategoryDAO.selectAll", paramMap);
        log.debug("selectAll - searchKey: {}, resultCount: {}", searchKey, list.size());
        
        return list;
    }

    @Override
    public int insert(ProductTopcategory productTopCategory) {
        int result = sqlSessionTemplate.insert("peachstore.repository.topcategory.ProductTopcategoryDAO.insert", productTopCategory);
        log.debug("save - productCategory: {}", productTopCategory);
        return result;
    }

    @Override
    public int update(ProductTopcategory productTopCategory) {
        int result = sqlSessionTemplate.update("peachstore.repository.topcategory.ProductTopcategoryDAO.update", productTopCategory);
        log.debug("update - productCategory: {}, result: {}", productTopCategory, result);
        return result;
    }

    @Override
    public ProductTopcategory selectById(int productTopCategoryId) {
    	ProductTopcategory productTopCategory = sqlSessionTemplate.selectOne("peachstore.repository.topcategory.ProductTopcategoryDAO.findById", productTopCategoryId);
    	log.debug("findById - productCategoryId: {}, result: {}", productTopCategoryId, productTopCategory);
        return productTopCategory;
    }

	@Override
	public List<ProductTopcategory> selectAll() {
		return sqlSessionTemplate.selectList("peachstore.repository.topcategory.ProductTopcategoryDAO.selectAll", null);
	}

}
