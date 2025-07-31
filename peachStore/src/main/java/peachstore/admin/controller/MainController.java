package peachstore.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import peachstore.domain.Color;
import peachstore.domain.Product;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductSize;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.Size;
import peachstore.service.product.ProductService;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.util.Paging;

/**

 * @author 김지민
 * @since 2025-07-29
 */
@Controller
public class MainController {
    

	@GetMapping("/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/index");
		return mav;
	}
	
	
    
	

}