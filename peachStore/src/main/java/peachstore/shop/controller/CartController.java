package peachstore.shop.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Cart;
import peachstore.domain.User;
import peachstore.service.cart.CartItemService;
import peachstore.service.cart.CartService;

/* 
 * 장바구니용 컨트롤러 입니다.
 * @author 이세형
 * @since 2025-08-02
 * */
@Slf4j
@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	@Autowired
	private CartItemService cartItemService;
	
	@GetMapping("/user/cart")
	public String getCart(HttpSession session) {
		User user = (User)session.getAttribute("user");
		Cart cart = cartService.selectById(user.getUser_id());
		if(cart==null) {
			log.debug("카트를 못받아오는중");
		}
		log.debug("장바구니 요청에서 받아온 유저는"+user);
		cart.setUser(user);
		log.debug("Cart: " + cart);
		return "redirect:/shop/user/cartitem?cart_id="+cart.getCart_id();
	}
	
	@GetMapping("/user/cartitem")
	public ModelAndView getCartItem(int cart_id) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject(cartItemService.selectCartItemByCartId(cart_id));
		mav.setViewName("shop/user/cartItem");
		return mav;
	}
}
