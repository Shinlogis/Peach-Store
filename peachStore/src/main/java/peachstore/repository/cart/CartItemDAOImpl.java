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
		System.out.println("dao 로드 완료");
		System.out.println("================================");
		System.out.println(sqlSessionTemplate.selectList("CartItem.selectCartItemByCartId", cart_id));
		System.out.println("================================");
//		CartItemMapper.xml과 연결
		return sqlSessionTemplate.selectList("CartItem.selectCartItemByCartId", cart_id);
	}

	@Override
	public void insertCartItem(CartItem cartItem) {
		sqlSessionTemplate.insert("CartItem.insertCartItem", cartItem);
	}

	@Override
	public void deleteCartItem(int cart_item_id) {
		sqlSessionTemplate.delete("CartItem.deleteCartItem", cart_item_id);
	}

	@Override
	public void deleteAllByUserId(int userId) {
		sqlSessionTemplate.delete("CartItem.deleteAllByUserId", userId);
	}
	
}
