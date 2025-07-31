package peachstore.repository.orderreceipt;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.OrderReceipt;

@Repository
public class OrderReceiptDAOImpl implements OrderReceiptDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectByUserId(OrderReceipt orderReceipt) {
		
		return sqlSessionTemplate.selectList("OrderReceipt.selectByUserId", orderReceipt);
	}

}
