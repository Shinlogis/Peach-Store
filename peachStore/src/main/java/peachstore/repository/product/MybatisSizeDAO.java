package peachstore.repository.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * SizeDAO 인터페이스를 구현하며,  
 * 상품 등록 시 선택 가능한 사이즈 목록을 DB에서 조회
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisSizeDAO implements SizeDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    /**
     * 사이즈 전체 목록 조회
     * @return 사이즈 목록 리스트
     */
    public List selectAll() {
        return sqlSessionTemplate.selectList("Size.selectAll");
    }
}
