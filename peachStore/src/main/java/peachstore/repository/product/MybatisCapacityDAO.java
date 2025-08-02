package peachstore.repository.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * CapacityDAO 인터페이스를 구현하며,  
 * 상품 등록 시 선택된 용량 정보를 DB에 저장하는 기능을 담당 
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

}
