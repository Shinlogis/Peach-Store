package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {
	
	@GetMapping("/product/phone")
	public String phone() {
		return "shop/product/phone";
	}
	
	@GetMapping("/product/mac")
	public String mac() {
		return "shop/product/mac";
	}
	
	@GetMapping("/product/macbook")
	public String macbook() {
		return "shop/product/macbook";
	}
	
	@GetMapping("/product/accessory")
	public String accessory() {
		return "shop/product/accessory";
	}
}
