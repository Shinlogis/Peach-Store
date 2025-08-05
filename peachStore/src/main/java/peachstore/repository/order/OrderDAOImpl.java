package peachstore.repository.order;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * 주문 관련 DAO 구현
 * @author 김지민
 * @since 2025-08-05
 */
@Repository
public class OrderDAOImpl implements OrderDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<Map<String, Object>> getAllOrders() {
        return sqlSessionTemplate.selectList("peachstore.mybatis.OrderMapper.getAllOrders");
    }

    @Override
    public int updateOrderStatus(Map<String, Object> param) {
        return sqlSessionTemplate.update("peachstore.mybatis.OrderMapper.updateOrderStatus", param);
    }
}
