package peachstore.repository.orderreceipt;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.OrderReceipt;
import peachstore.exception.OrderException;

@Slf4j
@Repository
public class OrderReceiptDAOImpl implements OrderReceiptDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectByUserId(OrderReceipt orderReceipt) {
		
		List list = sqlSessionTemplate.selectList("OrderReceipt.selectByUserId", orderReceipt);
		log.debug("상품 정보 리스트는 " + list);
		return list;
				
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
	
	@Override
	public List completedList(OrderReceipt orderReceipt) {
		return sqlSessionTemplate.selectList("OrderReceipt.completedList", orderReceipt);
	}

	@Override
	public OrderReceipt selectById(int orderReceiptId) {
		return sqlSessionTemplate.selectOne("OrderReceipt.select", orderReceiptId);
	}

	//총 페이징 갯수
	@Override
	public int countByUserId(OrderReceipt orderReceipt) {
		return sqlSessionTemplate.selectOne("OrderReceipt.countByUserId",orderReceipt );
	}

	//전체 페이징
	@Override
	public List<OrderReceipt> selectByUserIdPaging(Map<String, Object> param) {
		return sqlSessionTemplate.selectList("OrderReceipt.selectByUserIdPaging", param);
	}
	
	//취소내역 페이징
	@Override
	public List<OrderReceipt> cancleListPaging(Map<String, Object> param) {
		return sqlSessionTemplate.selectList("OrderReceipt.cancleListPaging", param);
	}

	//발송완료내역 페이징
	@Override
	public List<OrderReceipt> completedListPaging(Map<String, Object> param) {
		return sqlSessionTemplate.selectList("OrderReceipt.completedListPaging", param);
	}

}
