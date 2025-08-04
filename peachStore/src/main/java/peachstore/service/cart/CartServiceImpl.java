package peachstore.service.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.Cart;
import peachstore.domain.User;
import peachstore.repository.cart.CartDAO;

/**
 * 카트 서비스 구현체입니다.
 * 
 * @author 이세형
 * @since 2025-08-02
 */
@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDAO cartDAO;
	
	@Override
	public Cart selectById(int user_id) {
		return cartDAO.selectById(user_id);
	}

	@Override
	public void createCart(int user_id) {
		cartDAO.createCart(user_id);
	}
}
