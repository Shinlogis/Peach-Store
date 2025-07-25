package peachstore.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import peachstore.domain.ProductCategory;
import peachstore.service.ProductCategoryService;
import peachstore.util.Paging;

/**
 * 제품 카테고리 컨트롤러
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Controller
public class ProductCategoryController {

    private final Paging paging;
	
	private final ProductCategoryService productCategoryService;
	
	public ProductCategoryController(ProductCategoryService productCategoryService, Paging paging) {
		this.productCategoryService = productCategoryService;
		this.paging = paging;
	}
	
	/**
	 * 제품 카테고리 전체 조회
	 * @return
	 */
	@GetMapping("/product/category/list")
	public String selectAll(Model model, HttpServletRequest request){
		
		// 목록 가져오기
		List<ProductCategory> productCategories = productCategoryService.selectAll();
		paging.init(productCategories, request);
		
		// 결과 저장
		model.addAttribute("productCategories", productCategories);
		model.addAttribute("paging", paging);
		
		return "/product/category/list";
	}
	
	/**
	 * 제품 카테고리 등록
	 * @param categoryName
	 * @return
	 */
	@PostMapping("/product/category/regist")
	@ResponseBody
	public String save(String categoryName) {
		try {
			ProductCategory category = new ProductCategory();
			category.setProductCategoryName(categoryName);
			productCategoryService.save(category);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

}
