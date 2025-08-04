package peachstore.service.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.CartItem;
import peachstore.repository.cart.CartItemDAO;

@Service
public class CartItemServiceImpl implements CartItemService{
	@Autowired
	private CartItemDAO cartItemDAO;
	
	@Override
	public List<CartItem> selectCartItemByCartId(int cart_id) {
		
		return cartItemDAO.selectCartItemByCartId(cart_id);
	}
	
}
