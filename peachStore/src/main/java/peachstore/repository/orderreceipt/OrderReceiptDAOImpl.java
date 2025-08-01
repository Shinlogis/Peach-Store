package peachstore.repository.orderreceipt;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.OrderReceipt;
import peachstore.exception.OrderException;

@Repository
public class OrderReceiptDAOImpl implements OrderReceiptDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectByUserId(OrderReceipt orderReceipt) {
		
		return sqlSessionTemplate.selectList("OrderReceipt.selectByUserId", orderReceipt);
	}

	@Override
	public List cancleList(OrderReceipt orderReceipt) {
		return sqlSessionTemplate.selectList("OrderReceipt.cancleList", orderReceipt);
	}

	@Override
	public void cancle(OrderReceipt orderReceipt) throws OrderException{
		int result = sqlSessionTemplate.update("OrderReceipt.cancle", orderReceipt);
		
		if(result <1) {
			throw new OrderException("주문 취소 실패");
		}
	}

}
