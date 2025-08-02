package peachstore.shop.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import peachstore.domain.Cart;
import peachstore.domain.User;
import peachstore.service.cart.CartItemService;
import peachstore.service.cart.CartService;

/* 
 * 장바구니용 컨트롤러 입니다.
 * @author 이세형
 * @since 2025-08-02
 * */
@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	@Autowired
	private CartItemService cartItemService;
	
	@GetMapping("/user/cart")
	public String getCart(Cart cart, HttpSession session) {
		User user = (User)session.getAttribute("user");
		cart.setUser(user);
		return "redirect:/shop/user/cartitem?cart_id="+cart.getCart_id();
	}
	
	@GetMapping("/user/cartitem")
	public ModelAndView getCartPage(int cart_id) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject(cartItemService.selectCartItemByCartId(cart_id));
		mav.setViewName("shop/user/cartItem");
		return mav;
	}
}
