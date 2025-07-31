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
 * 제품 등록 컨트롤러
 * 상품 등록 페이지 초기 진입 시 상위 카테고리를 포함한 정보 제공을 담당.
 * @author 김지민
 * @since 2025-07-29
 */
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
    public String registform(Product product, int[] color, int[] size, HttpServletRequest request) {
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
		
		try {
			productService.regist(product, savePath);
		} catch (Exception e) {
			productService.remove(product, savePath);
			e.printStackTrace();
		}
		
        return "ok";
    }
    
	@GetMapping("/product/list")
	public ModelAndView getList(HttpServletRequest request) {
		List productList = productService.selectAll();
		
		paging.init(productList, request);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("productList", productList); 
		mav.addObject("paging", paging); 

		mav.setViewName("/product/list");
		
		return mav;
	}
	

}