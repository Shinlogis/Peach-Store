package peachstore.repository.cart;

import peachstore.domain.Cart;

public interface CartDAO {
	public Cart selectById(int user_id);
	public void createCart(int user_id);
}
