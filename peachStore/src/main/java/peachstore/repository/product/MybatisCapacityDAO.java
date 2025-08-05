package peachstore.repository.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * CapacityDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-08-01
 */
@Repository
public class MybatisCapacityDAO implements CapacityDAO{

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Capacity.selectAll");
	}


	public int insertProductCapacity(int productId, String capacityName) {
	    // 1. 용량 이름으로 id 먼저 조회
	    Integer capacityId = sqlSessionTemplate.selectOne("Capacity.getCapacityIdByName", capacityName);
	    if (capacityId == null) {
	        throw new IllegalArgumentException("존재하지 않는 용량: " + capacityName);
	    }

	    // 2. 추가금액 결정
	    int additionalPrice = 0;
	    if ("256GB".equals(capacityName)) additionalPrice = 10000;
	    else if ("512GB".equals(capacityName) || "516GB".equals(capacityName)) additionalPrice = 20000;
	    else if ("1TB".equals(capacityName)) additionalPrice = 30000;

	    // 3. 파라미터 map에 담기
	    Map<String, Object> param = new HashMap<>();
	    param.put("productId", productId);
	    param.put("capacityId", capacityId);
	    param.put("additionalPrice", additionalPrice);

	    // 4. insert 실행 (ProductCapacity 매퍼의 insert 수정 필요)
	    return sqlSessionTemplate.insert("ProductCapacity.insert", param);
	}


}
