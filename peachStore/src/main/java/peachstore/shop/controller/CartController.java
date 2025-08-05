package peachstore.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Cart;
import peachstore.domain.CartItem;
import peachstore.domain.CustomOption;
import peachstore.domain.Product;
import peachstore.domain.ProductCapacity;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductSize;
import peachstore.domain.User;
import peachstore.service.cart.CartItemService;
import peachstore.service.cart.CartService;
import peachstore.service.customOption.CustomOptionService;

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
	
	@Autowired
	private CustomOptionService customOptionService;
	
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
	public ModelAndView getCartItem(int cart_id , HttpSession httpSession, HttpServletRequest request) throws JsonProcessingException {
		ModelAndView mav = new ModelAndView();
		User user = (User) httpSession.getAttribute("user");
		List<CartItem> cartItemList = cartItemService.selectCartItemByCartId(user.getUser_id()); // 장바구니 목록 가져오기
		
		String successUrl = "http://localhost:8888/shop/payment/success-handler";
		String failUrl = "http://localhost:8888/shop/payment/fail";
		String orderId = String.valueOf(System.currentTimeMillis());

		ObjectMapper objectMapper = new ObjectMapper();

		log.debug("paymentPage orderId - {}", orderId);
		
		mav.addObject("orderId", orderId);
		mav.addObject("successUrl", successUrl);
		mav.addObject("failUrl", failUrl);
		mav.addObject("orderName", "주문번호 " + orderId + " 결제");
		mav.addObject("cartItemList", cartItemList);
		mav.addObject("user", user);
		
		mav.setViewName("shop/user/cartItem");
		return mav;
	}
	
	@PostMapping("/cart/insert")
	public String addToCart(int product_id,int product_color_id,int product_size_id,int product_capacity_id,HttpSession httpSession) {
		User user1 = (User) httpSession.getAttribute("user");
		Cart cart = cartService.selectById(user1.getUser_id());
		int cart_id=cart.getCart_id();
		
		//customoption insert
		CustomOption option = new CustomOption();
		ProductColor color = new ProductColor();
		ProductSize size = new ProductSize();
		ProductCapacity capacity=new ProductCapacity();
		
		color.setProduct_color_id(product_color_id);
		size.setProduct_size_id(product_size_id);
		capacity.setProduct_capacity_id(product_capacity_id);
		
		option.setProduct_color(color);
		option.setProduct_size(size);
		option.setProduct_capacity(capacity);

		customOptionService.regist(option); //selectkey에 의해 pk가 채워짐 
		
		//cartItem insert
		Product product = new Product();
		CartItem cartItem=new CartItem();
		
		product.setProductId(product_id);
		
		cartItem.setCart(cart);
		cartItem.setProduct(product);
		cartItem.setCustom_option(option);
		cartItemService.insertCartItem(cartItem);

		return "redirect:/shop/user/cart";
	}
	
	@PostMapping("/cart/delete")
	public String deleteCartItem(@RequestParam("cartItemId")int cart_item_id) {
		cartItemService.deleteCartItem(cart_item_id);
		return "redirect:/shop/user/cart";
	}
	
}
