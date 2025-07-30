package peachstore.model.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * ColorDAO 인터페이스를 구현하며,
 * MyBatis의 SqlSessionTemplate을 사용해 색상 목록을 조회
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisColorDAO implements ColorDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 색상 전체 목록 조회
     * @return 색상 목록 리스트
     */
    @Override
    public List selectAll() {
        return sqlSessionTemplate.selectList("Color.selectAll");
    }
}
