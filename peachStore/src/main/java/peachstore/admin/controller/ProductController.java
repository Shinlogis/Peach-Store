package peachstore.admin.controller;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Color;
import peachstore.domain.Product;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductSize;
import peachstore.domain.Size;
import peachstore.service.product.ProductService;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.util.Paging;

/**
 * 제품 등록 컨트롤러
 * 상품 등록 페이지 초기 진입 시 상위 카테고리를 포함한 정보 제공을 담당.
 * @author 김지민
 * @since 2025-07-29
 */
@Slf4j
@Controller
public class ProductController {
    
    // 제품 관련 서비스 의존성 주입
    @Autowired
    private ProductService productService;
    
    @Autowired	
	private ProductTopcategoryService ProductTopCategoryService;
    
	//페이징 처리 객체를 보유 
	@Autowired
	private Paging paging;

    /**
     * 상품 등록 페이지 진입
     * 상품 등록 화면에 진입할 때,
     * 상위 카테고리 등의 데이터를 초기 로딩하기 위한 페이지로 이동.
     * @return 상품 등록 JSP 경로
     */
	@RequestMapping(value="/product/registform")
	public String regsitForm() {
		
		return "/product/regist";
	}
	
	//상품 등록 요청 처리
	@PostMapping("/product/regist")
    @ResponseBody
    public ResponseEntity<String> registform(Product product, int[] color, int[] size, HttpServletRequest request) {
    	List<ProductColor> colorList = new ArrayList<>();
		List<ProductSize> sizeList = new ArrayList<>();
		
		for(int c : color) {
			Color cc = new Color();
			cc.setColor_id(c);
			ProductColor productColor = new ProductColor();
			productColor.setColor(cc);
			colorList.add(productColor);
		}
		
		for(int s : size) {
			Size ss = new Size();
			ss.setSize_id(s);
			ProductSize productSize = new ProductSize();
			productSize.setSize(ss);	
			sizeList.add(productSize);
		}
		
		//매핑완료 후, Product 에 대입 
		product.setProductColors(colorList);
		product.setProductSizes(sizeList);
    	
		String savePath = request.getServletContext().getRealPath("/data");
		log.debug("에닮예닮예닮 "+savePath);
		
		
		  try {
		        productService.regist(product, savePath);
		        return ResponseEntity.ok("상품 등록 성공");
		    } catch (Exception e) {
		        productService.remove(product, savePath);
		        e.printStackTrace();
		        return ResponseEntity.status(500).body("상품 등록 실패: " + e.getMessage());
		    }
    }
    
	@GetMapping("/product/list")
	public ModelAndView getList(HttpServletRequest request) {
	    int totalRecord = productService.getTotalRecord(); // 1. 전체 상품 수 가져오기
	    paging.init(totalRecord, request);                 // 2. 먼저 paging 계산
	    log.error("📦 [Controller] paging.pageSize after init = {}", paging.getPageSize());
	    
	    int startIndex = paging.getStartIndex();           // 3. 이제 값이 정확함
	    int pageSize = paging.getPageSize();
	    
	    List<Product> productList = productService.selectAll(startIndex, pageSize); // 4. 데이터 조회

	    ModelAndView mav = new ModelAndView();
	    mav.addObject("productList", productList);
	    mav.addObject("paging", paging);
	    mav.setViewName("/product/list");

	    return mav;
	}
	//상세요청에 대한 처리
	@GetMapping("/product/detail")
		public String getDetail(int product_id, Model model) {
			//3단계: 상세 내용 가져오기
			Product product = productService.select(product_id);
			
			//4단계: 저장하기
			model.addAttribute("product", product);
			return "/product/detail";
		}

}