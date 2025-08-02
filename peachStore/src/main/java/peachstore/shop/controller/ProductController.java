package peachstore.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Product;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.service.product.ProductService;
import peachstore.service.subcategory.ProductSubcategoryService;
import peachstore.service.topcategory.ProductTopcategoryService;

/**
 * 제품컨트롤러 
 * 
 * @author 서예닮 
 * @since 2025-07-29 
 */
@Slf4j
@Controller
public class ProductController {
	@Autowired
	ProductSubcategoryService productSubcategoryService;
	@Autowired
	ProductTopcategoryService productTopcategoryService;
	@Autowired
	ProductService productService;
	
	@GetMapping("/product")
	public ModelAndView phone(int topid) {
		List<ProductSubcategory> subList=productSubcategoryService.findAllByTopcategoryId(topid);
		ProductTopcategory productTopcategory=productTopcategoryService.findById(topid);
		String topName=productTopcategory.getProductTopcategoryName();
		List<Product> list=productService.selectAll();
		
		ModelAndView mav = new ModelAndView("shop/product/"+productTopcategory.getProductTopcategoryName());
		mav.addObject("subList", subList);
		mav.addObject("topName", topName);
		mav.addObject("list", list);
		
		return mav;
	}

	@GetMapping("/product/list")
	@ResponseBody
	public List<Product> getList(int subId) {
		List productListbySub=productService.selectBySubId(subId);
		
		return productListbySub;
	}
	
	@GetMapping("/product/detail")
	public ModelAndView getProductDetails(int productId) {
		ModelAndView mav=new ModelAndView("shop/product/detail");
		
		Product product = productService.select(productId);
		
		mav.addObject("product",product);
		return mav;
	}
}
