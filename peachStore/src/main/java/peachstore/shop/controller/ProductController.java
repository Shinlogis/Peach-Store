package peachstore.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
		
		ModelAndView mav = new ModelAndView("shop/product/"+productTopcategory.getProductTopcategoryName());
		mav.addObject("subList", subList);
		mav.addObject("topName", topName);
		
		return mav;
	}
	
	@GetMapping("/product/list")
	@ResponseBody
	public List<Product> getList() {
		//3단계: 목록 가져오기 
		List productList=productService.selectAll();
		
//		paging.init(productList, request);
		
		//4단계: 결과 저장
//		mav.addObject("paging", paging); //페이징 처리 객체도 담기
		return productList;
	}
	
//	@GetMapping("/product/detail")
//	public ModelAndView getProductDetail(int product_id) {
//		ModelAndView mav=new ModelAndView("shop/detail");
//		
//		Product product = productService.select(product_id);
//		
//		mav.addObject("product",product);
//		return mav;
//	}
	
	@GetMapping("/product/detail")
	public ModelAndView getProductDetails() {
		ModelAndView mav=new ModelAndView("shop/product/detail");
		
		//Product product = productService.select(product_id);
		
		//mav.addObject("product",product);
		return mav;
	}
		
	
	
	
	

}
