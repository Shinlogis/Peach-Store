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
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.service.subcategory.ProductSubcategoryService;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.util.FileCommonManager;

/**
 * 제품 하위 카테고리 컨트롤러
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Slf4j
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
	public ResponseEntity<Map<String, Object>> register(
			String productSubcategoryName, 
			int productTopcategoryId,
			@RequestParam("photo") MultipartFile photo, 
			HttpServletRequest request) {
		// 파일 저장 경로
		String savePath = request.getServletContext().getRealPath("/data");
		
		productSubcategoryService.register(productSubcategoryName, productTopcategoryId, savePath, photo);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "하위 카테고리가 성공적으로 등록되었습니다.");
		
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}
	
	/**
	 * 제품 하위카테고리 업데이트
	 * @param categoryId
	 * @param productTopcategoryName
	 * @return
	 */
	@PostMapping("/product/subcategory/update")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> change(
			int productSubcategoryId, 
		 	String productSubcategoryName,
			MultipartFile photo,
			HttpServletRequest request) {
		// 파일 저장 경로
		String savePath = request.getServletContext().getRealPath("/data");
		Map<String, Object> response = new HashMap<>();
		log.debug("change param: {}, {}", productSubcategoryId, productSubcategoryName);
		
        try {
        	productSubcategoryService.change(productSubcategoryId, productSubcategoryName, savePath, photo);
			response.put("success", true);
			response.put("message", "하위 카테고리가 성공적으로 업데이트되었습니다.");
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	/**
	 * 하위카테고리 비활성화
	 * @param subcategoryId
	 */
	@PostMapping("/product/subcategory/deactive")
	@ResponseBody
	public String deactivate(int productSubcategoryId) {
		productSubcategoryService.toggleActivation(productSubcategoryId);
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
