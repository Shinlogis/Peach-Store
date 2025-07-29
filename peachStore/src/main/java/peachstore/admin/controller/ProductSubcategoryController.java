package peachstore.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.service.ProductSubcategoryService;
import peachstore.service.ProductTopcategoryService;

/**
 * 제품 하위 카테고리 컨트롤러
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Controller
@RequiredArgsConstructor
public class ProductSubcategoryController {

	private final ProductSubcategoryService productSubcategoryService;
	private final ProductTopcategoryService productTopcategoryService;
	
	/**
	 * 제품 전체 카테고리 목록 조회 및 검색
	 * @param model
	 * @param searchKey
	 * @return
	 */
	@GetMapping("/product/category/list")
	public String listAll(
	        Model model,
	        @RequestParam(required=false) String searchKey) {

	    // 전체 리스트
	    List<ProductSubcategory> productSubcategories = productSubcategoryService.findAllWithTopcategory(searchKey);
	    List<ProductTopcategory> productTopcategories = productTopcategoryService.selectAll(searchKey);

	    // 모델에 데이터 추가
	    model.addAttribute("productSubcategories", productSubcategories);
	    model.addAttribute("productTopcategories", productTopcategories);
	    model.addAttribute("searchKey", searchKey);

	    return "/product/category/list";
	}
	
	/**
	 * 제품 하위카테고리 등록
	 * @param productSubcategoryName
	 * @param productTopcategoryId
	 * @return
	 */
	@PostMapping("/product/subcategory/regist")
	@ResponseBody
	public String register(String productSubcategoryName, int productTopcategoryId) {
		productSubcategoryService.register(productSubcategoryName, productTopcategoryId);
	    return "success";
	}
	
	/**
	 * 하위카테고리 이름 수정
	 * @param name
	 * @param subcategoryId
	 */
	@PostMapping("/product/subcategory/update")
	@ResponseBody
	public String updateName(String productSubcategoryName, int productSubcategoryId) {
		productSubcategoryService.updateName(productSubcategoryName, productSubcategoryId);
		return "success";
	}
	
	/**
	 * 하위카테고리 비활성화
	 * @param subcategoryId
	 */
	@PostMapping("/product/subcategory/deactive")
	@ResponseBody
	public String deactivate(int productSubcategoryId) {
		productSubcategoryService.deactivate(productSubcategoryId);
		return "success";
	}
	
	/**
	 * 해당 id의 상위 카테고리의 모든 하위 카테고리 조회
	 * @param productTopcategoryId
	 * @return
	 */
	@GetMapping("/product/subcategory/byTopcategoryId")
	@ResponseBody
	public List<ProductSubcategory> findAllByTopcategoryId(int productTopcategoryId, Model model){
		 return productSubcategoryService.findAllByTopcategoryId(productTopcategoryId);
	}
	
	/**
	 * 해당 id의 상위 카테고리의 모든 하위 카테고리 조회
	 * [상품 등록]
	 * @param productTopcategoryId
	 * @return
	 */
	@GetMapping("/subcategory/list")
	@ResponseBody  
	public List<ProductSubcategory> getList(int topcategory_id) { 
		return productSubcategoryService.findAllByTopcategoryId(topcategory_id);
	}
	
}
