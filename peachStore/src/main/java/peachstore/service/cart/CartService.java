package peachstore.service.cart;

import peachstore.domain.Cart;

public interface CartService {
	public Cart selectById(int user_id);
}
