package peachstore.repository.cart;

import java.util.List;

import peachstore.domain.CartItem;

public interface CartItemDAO {
	public List<CartItem> selectCartItemByCartId(int cart_id);
	public void insertCartItem(CartItem cartItem);
	public void deleteCartItem(int cart_item_id);
}
