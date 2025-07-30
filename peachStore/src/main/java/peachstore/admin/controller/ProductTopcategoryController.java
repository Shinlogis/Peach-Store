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
import peachstore.domain.ProductTopcategory;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.util.Paging;

/**
 * 제품 상위 카테고리 컨트롤러
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Controller
@RequiredArgsConstructor
public class ProductTopcategoryController {

	// 생성자 주입
	private final ProductTopcategoryService productTopcategoryService;
	
	/**
	 * 제품 상위카테고리 목록 조회 및 검색
	 * @param model
	 * @param searchKey
	 * @param request
	 * @return
	 */
	@GetMapping("/product/topcategory/list")
	public String selectAll(
	        Model model,
	        @RequestParam(required=false) String searchKey,
	        HttpServletRequest request) {

	    // 검색 조건에 맞는 전체 리스트
	    List<ProductTopcategory> productTopcategories = productTopcategoryService.selectAll(searchKey);

	    // Paging 객체 초기화
	    Paging paging = new Paging();
	    paging.init(productTopcategories, request);

	    // 현재 페이지에 해당하는 부분 리스트 자르기
	    int start = paging.getCurPos();
	    int end = Math.min(start + paging.getPageSize(), productTopcategories.size());
	    List<ProductTopcategory> pagedList = productTopcategories.subList(start, end);

	    // 모델에 데이터 추가
	    model.addAttribute("productTopcategories", pagedList);
	    model.addAttribute("paging", paging);
	    model.addAttribute("searchKey", searchKey);

	    return "/product/topcategory/list";
	}
		
	/**
	 * 제품 상위카테고리 등록
	 * @param productTopcategoryName
	 * @return
	 */
	@PostMapping("/product/topcategory/regist")
	@ResponseBody
	public String register(String productTopcategoryName) {
		ProductTopcategory category = new ProductTopcategory();
		category.setProductTopcategoryName(productTopcategoryName);
	    productTopcategoryService.register(category);
	    return "success";
	}
	
	/**
	 * 제품 상위카테고리 업데이트
	 * @param categoryId
	 * @param productTopcategoryName
	 * @return
	 */
	@PostMapping("/product/topcategory/update")
	@ResponseBody
	public String changeName(int productTopcategoryId, String productTopcategoryName) {
        productTopcategoryService.changeName(productTopcategoryId, productTopcategoryName);
        return "success";
	}
	
	/**
	 * 제품 상위카테고리 비활성화
	 * @param categoryId
	 * @return
	 */
	@PostMapping("/product/topcategory/deactivate")
	@ResponseBody
	public String deactivate(int productTopcategoryId) {
		productTopcategoryService.deactivate(productTopcategoryId);
		return "success";
	}
    /**
     * 주로 상품 등록 화면에서 상위 카테고리 드롭다운을 동적으로 채우기 위해 사용
     * @return 전체 상위 카테고리 리스트 (JSON 배열로 반환됨)
     * @author 김지민
     * @since 2025-07-29
     */
	@GetMapping("/topcategory/list")
	@ResponseBody
	public List<ProductTopcategory> getTopcategoryList() {
	    return productTopcategoryService.selectAll();
	}
}
