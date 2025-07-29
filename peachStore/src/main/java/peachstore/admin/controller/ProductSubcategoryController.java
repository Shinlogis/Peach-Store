package peachstore.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.service.ProductSubcategoryService;
import peachstore.service.ProductTopcategoryService;
import peachstore.util.Paging;

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
	 * 제품 하위카테고리 목록 조회 및 검색
	 * @param model
	 * @param searchKey
	 * @param request
	 * @return
	 */
	@GetMapping("/product/subcategory/list")
	public String selectAll(
	        Model model,
	        @RequestParam(required=false) String searchKey,
	        HttpServletRequest request) {

	    // 전체 리스트
	    List<ProductSubcategory> productSubcategories = productSubcategoryService.selectAllWithTopcategory();
	    List<ProductTopcategory> productTopcategories = productTopcategoryService.selectAll(null);

	    // Paging 객체 초기화
	    Paging paging = new Paging();
	    paging.init(productSubcategories, request);

	    // 현재 페이지에 해당하는 부분 리스트 자르기
	    int start = paging.getCurPos();
	    int end = Math.min(start + paging.getPageSize(), productSubcategories.size());
	    List<ProductSubcategory> pagedList = productSubcategories.subList(start, end);

	    // 모델에 데이터 추가
	    model.addAttribute("productSubcategories", pagedList);
	    model.addAttribute("productTopcategories", productTopcategories);
	    model.addAttribute("paging", paging);
	    model.addAttribute("searchKey", searchKey);

	    return "/product/subcategory/list";
	}
}
