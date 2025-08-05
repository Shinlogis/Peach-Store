package peachstore.service.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import peachstore.domain.CartItem;
import peachstore.repository.cart.CartItemDAO;

@Service
public class CartItemServiceImpl implements CartItemService{
	@Autowired
	private CartItemDAO cartItemDAO;
	
	@Override
	public List<CartItem> selectCartItemByCartId(int cart_id) {
		System.out.println("서비스 임플 로딩 완료");
		System.out.println(cartItemDAO.selectCartItemByCartId(cart_id));
		return cartItemDAO.selectCartItemByCartId(cart_id);
	}

	@Transactional
	@Override
	public void insertCartItem(CartItem cartItem) {
		cartItemDAO.insertCartItem(cartItem);
	}
	
	@Transactional
	@Override
	public void deleteCartItem(int cart_item_id) {
		cartItemDAO.deleteCartItem(cart_item_id);
	}
}
