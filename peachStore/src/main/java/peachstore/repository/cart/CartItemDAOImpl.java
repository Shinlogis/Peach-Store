package peachstore.repository.cart;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.CartItem;

@Repository
public class CartItemDAOImpl implements CartItemDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<CartItem> selectCartItemByCartId(int cart_id) {
//		CartItemMapper.xml과 연결
		return sqlSessionTemplate.selectList("selectCartItemByCartId", cart_id);
	}
}
