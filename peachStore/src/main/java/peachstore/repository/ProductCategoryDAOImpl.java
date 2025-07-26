package peachstore.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductCategory;

/**
 * 제품 카테고리 마이바티스 DAO 구현체입니다
 * 
 * @author 김예진
 * @since 2025-07-24
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class ProductCategoryDAOImpl implements ProductCategoryDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<ProductCategory> selectAll(String searchKey) {
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

        List<ProductCategory> list = sqlSessionTemplate.selectList("peachstore.repository.ProductCategoryDAO.selectAll", paramMap);
        log.debug("selectAll - searchKey: {}, resultCount: {}", searchKey, list.size());
        
        return list;
    }

    @Override
    public void register(ProductCategory productCategory) {
        sqlSessionTemplate.insert("peachstore.repository.ProductCategoryDAO.insert", productCategory);
        log.debug("save - productCategory: {}", productCategory);
    }

    @Override
    public int update(ProductCategory productCategory) {
        int result = sqlSessionTemplate.update("peachstore.repository.ProductCategoryDAO.update", productCategory);
        log.debug("update - productCategory: {}, result: {}", productCategory, result);
        return result;
    }

    @Override
    public ProductCategory findById(int productCategoryId) {
    	ProductCategory productCategory = sqlSessionTemplate.selectOne("peachstore.repository.ProductCategoryDAO.findById", productCategoryId);
    	log.debug("findById - productCategoryId: {}, result: {}", productCategoryId, productCategory);
        return productCategory;
    }

}
