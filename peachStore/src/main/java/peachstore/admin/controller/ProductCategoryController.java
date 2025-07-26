package peachstore.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
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
@RequiredArgsConstructor
public class ProductCategoryController {

	// 생성자 주입
	private final ProductCategoryService productCategoryService;
	
	/**
	 * 제품 카테고리 목록 조회 및 검색
	 * @param model
	 * @param searchKey
	 * @param request
	 * @return
	 */
	@GetMapping("/product/category/list")
	public String selectAll(
	        Model model,
	        @RequestParam(required=false) String searchKey,
	        HttpServletRequest request) {

	    // 검색 조건에 맞는 전체 리스트
	    List<ProductCategory> productCategories = productCategoryService.selectAll(searchKey);

	    // Paging 객체 초기화
	    Paging paging = new Paging();
	    paging.init(productCategories, request);

	    // 현재 페이지에 해당하는 부분 리스트 자르기
	    int start = paging.getCurPos();
	    int end = Math.min(start + paging.getPageSize(), productCategories.size());
	    List<ProductCategory> pagedList = productCategories.subList(start, end);

	    // 모델에 데이터 추가
	    model.addAttribute("productCategories", pagedList);
	    model.addAttribute("paging", paging);
	    model.addAttribute("searchKey", searchKey);

	    return "/product/category/list";
	}
		
	/**
	 * 제품 카테고리 등록
	 * @param categoryName
	 * @return
	 */
	@PostMapping("/product/category/regist")
	@ResponseBody
	public String register(String categoryName) {
		ProductCategory category = new ProductCategory();
		category.setName(categoryName);
	    productCategoryService.register(category);
	    return "success";
	}
	
	/**
	 * 제품 카테고리 업데이트
	 * @param categoryId
	 * @param productCategoryName
	 * @return
	 */
	@PostMapping("/product/category/update")
	@ResponseBody
	public String changeName(int productCategoryId, String productCategoryName) {
        productCategoryService.changeName(productCategoryId, productCategoryName);
        return "success";
	}
	
	/**
	 * 제품 카테고리 비활성화
	 * @param categoryId
	 * @return
	 */
	@PostMapping("/product/category/deactivate")
	@ResponseBody
	public String deactivate(int productCategoryId) {
		productCategoryService.deactivate(productCategoryId);
		return "success";
	}
}
