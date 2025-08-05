package peachstore.repository.orderdetail;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderDetail;
@Slf4j
@Repository
public class OrderDetailDAOImpl implements OrderDetailDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selecByReceitId(int order_receipt_id) {
		List<OrderDetail> list = sqlSessionTemplate.selectList("OrderDetail.selectByOrderReceiptId", order_receipt_id);
		log.debug("DAO detail {}",list);
		return list;
	}

	@Override
	public int insert(Map<String, Object> param) {
		return sqlSessionTemplate.insert("OrderDetail.insert", param);
	}

}
