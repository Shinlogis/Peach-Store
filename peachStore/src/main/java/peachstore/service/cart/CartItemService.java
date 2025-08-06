package peachstore.service.cart;

import java.util.List;

import peachstore.domain.CartItem;

public interface CartItemService {
	public List<CartItem> selectCartItemByCartId(int cart_id);
	public void insertCartItem(CartItem cartItem);
	public void deleteCartItem(int cart_item_id);
	
	/**
	 * 해당 유저 장바구니 상품 모두 삭제
	 * @param userId
	 */
	public void deleteAllByUserId(int userId);
}
