package peachstore.repository.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * SizeDAO 인터페이스를 구현
 * @author 김지민
 * @since 2025-07-29
 */
@Repository
public class MybatisSizeDAO implements SizeDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public List selectAll() {
        return sqlSessionTemplate.selectList("Size.selectAll");
    }
}
