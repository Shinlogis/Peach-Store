package peachstore.shop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
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
	


}
