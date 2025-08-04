package peachstore.repository.cart;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.Cart;

@Repository
public class CartDAOImpl implements CartDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public Cart selectById(int user_id) {
		return sqlSessionTemplate.selectOne("Cart.selectById", user_id);
	}

	@Override
	public void createCart(int user_id) {
		sqlSessionTemplate.insert("Cart.insert", user_id);
	}
}
