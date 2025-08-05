package peachstore.repository.order;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Map<String, Object>> getAllOrders() {
        return sqlSessionTemplate.selectList("peachstore.mybatis.OrderMapper.getAllOrders");
    }
}
