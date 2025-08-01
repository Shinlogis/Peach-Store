package peachstore.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	        @RequestParam("photo") MultipartFile photo,
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
	 * @param photo
	 * @param request
	 * @return
	 */
	@PostMapping("/product/topcategory/regist")
	@ResponseBody
	public String register(
			String productTopcategoryName, 
			@RequestParam("photo") MultipartFile photo, 
			HttpServletRequest request) {
		// 파일 저장 경로
		String savePath = request.getServletContext().getRealPath("/data");
		
		ProductTopcategory category = new ProductTopcategory();
		category.setProductTopcategoryName(productTopcategoryName);
	    productTopcategoryService.register(category, savePath, photo);
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
	public ResponseEntity<Map<String, Object>> change(
			@RequestParam("productTopcategoryId") int productTopcategoryId, 
		 	@RequestParam("productTopcategoryName") String productTopcategoryName,
			@RequestParam("photo") MultipartFile photo,
			HttpServletRequest request) {
		// 파일 저장 경로
		String savePath = request.getServletContext().getRealPath("/data");
		Map<String, Object> response = new HashMap<>();
				
        try {
			productTopcategoryService.change(productTopcategoryId, productTopcategoryName, savePath, photo);
			response.put("success", true);
			response.put("message", "상위 카테고리가 성공적으로 업데이트되었습니다.");
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
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
