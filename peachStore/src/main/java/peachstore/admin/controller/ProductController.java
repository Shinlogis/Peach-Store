package peachstore.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import peachstore.service.product.ProductService;
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
    public String registform() {
        // 상품 등록 페이지를 보게 되는 초기 요청 처리
        // 추후 productService.selectTopcategories() 등으로 상위 카테고리 전달 가능
        return "/product/regist";
    }

}