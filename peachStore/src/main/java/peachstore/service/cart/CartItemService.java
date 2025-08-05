package peachstore.service.cart;

import java.util.List;

import peachstore.domain.CartItem;

public interface CartItemService {
	public List<CartItem> selectCartItemByCartId(int cart_id);
	public void insertCartItem(CartItem cartItem);
	public void deleteCartItem(int cart_item_id);
}
