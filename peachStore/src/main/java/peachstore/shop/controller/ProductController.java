package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {
	
	@GetMapping("/product/pPhone")
	public String phone() {
		return "shop/product/pPhone";
	}
	
	@GetMapping("/product/pPad")
	public String macbook() {
		return "shop/product/pPad";
	}
	
	@GetMapping("/product/pMac")
	public String mac() {
		return "shop/product/pMac";
	}
	
	@GetMapping("/product/accessory")
	public String accessory() {
		return "shop/product/accessory";
	}
}
