package peachstore.admin.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Capacity;
import peachstore.domain.Color;
import peachstore.domain.Product;
import peachstore.domain.ProductCapacity;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductSize;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.Size;
import peachstore.repository.product.MybatisCapacityDAO;
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
 
    
	private Paging paging;
	
	@Autowired
	private MybatisCapacityDAO mybatisCapacityDAO; // DAO 직접 주입

	@RequestMapping(value="/product/registform")
	public String regsitForm() {
		
		return "/product/regist";
	}
	
	//상품 등록 요청 처리
	@PostMapping("/product/regist")
    @ResponseBody
    public ResponseEntity<String> registform(Product product, int[] color, int[] size, int[] capacity, String[] capacityName, HttpServletRequest request) {
    	List<ProductColor> colorList = new ArrayList<>();
		List<ProductSize> sizeList = new ArrayList<>();
		List<ProductCapacity> capacityList = new ArrayList<>();
		
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
		
		for(int cp : capacity) {
			Capacity capa = new Capacity();
			capa.setCapacity_id(cp);
			ProductCapacity productCapacity = new ProductCapacity();	
			productCapacity.setCapacity(capa);	
			capacityList.add(productCapacity);
		}
		
		for(String capName : capacityName) {
	        mybatisCapacityDAO.insertProductCapacity(product.getProductId(), capName);
	    }
		
		//매핑완료 후, Product 에 대입 
		product.setProductColors(colorList);
		product.setProductSizes(sizeList);
		product.setProductCapacities(capacityList);
    	
		String savePath = request.getServletContext().getRealPath("/data");
		
		
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
	    int totalRecord = productService.getTotalRecord(); 

	    Paging paging = new Paging();
	    paging.init(totalRecord, request);

	    int currentPage = paging.getCurrentPage(); 
	    int pageSize = paging.getPageSize();       

	    List<Product> productList = productService.selectAll(currentPage, pageSize); 
	    
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
	
	@GetMapping("/product/editform")
	public String editForm(int product_id, Model model) {
	    Product product = productService.select(product_id);
	    model.addAttribute("product", product);
	    return "/product/edit"; // JSP 파일 위치
	}
	
	@PostMapping("/product/edit")
	@ResponseBody
	public ResponseEntity<String> edit(
	    @RequestParam("productId") Integer productId,
	    @RequestParam("productCode") String productCode,
	    @RequestParam("productName") String productName,
	    @RequestParam("price") int price,
	    @RequestParam("introduce") String introduce,
	    @RequestParam("detail") String detail,
	    @RequestParam("productSubcategory_id") int productSubcategoryId,
	    @RequestParam("color") int[] color,
	    @RequestParam("size") int[] size,
	    @RequestParam("capacity") int[] capacity,
	    @RequestParam(value = "photo", required = false) MultipartFile[] photo,
	    @RequestParam(value = "deleteFiles", required = false) List<String> deleteFiles, // ✅ 
	    HttpServletRequest request
	) {

	    // 1. Product 조립
	    Product product = new Product();
	    product.setProductId(productId);
	    product.setProductCode(productCode);
	    product.setProductName(productName);
	    product.setPrice(price);
	    product.setIntroduce(introduce);
	    product.setDetail(detail);

	    // 2. 하위 카테고리
	    ProductSubcategory sub = new ProductSubcategory();
	    sub.setProductSubcategoryId(productSubcategoryId);
	    product.setProductSubcategory(sub);

	    // 3. 옵션들 조립
	    List<ProductColor> colorList = new ArrayList<>();
	    if (color != null) {
	        for (int c : color) {
	            Color cc = new Color();
	            cc.setColor_id(c);
	            ProductColor productColor = new ProductColor();
	            productColor.setColor(cc);
	            colorList.add(productColor);
	        }
	    }

	    List<ProductSize> sizeList = new ArrayList<>();
	    if (size != null) {
	        for (int s : size) {
	            Size ss = new Size();
	            ss.setSize_id(s);
	            ProductSize productSize = new ProductSize();
	            productSize.setSize(ss);
	            sizeList.add(productSize);
	        }
	    }

	    List<ProductCapacity> capacityList = new ArrayList<>();
	    if (capacity != null) {
	        for (int cp : capacity) {
	            Capacity cc = new Capacity();
	            cc.setCapacity_id(cp);
	            ProductCapacity productCapacity = new ProductCapacity();
	            productCapacity.setCapacity(cc);
	            capacityList.add(productCapacity);
	        }
	    }

	    product.setProductColors(colorList);
	    product.setProductSizes(sizeList);
	    product.setProductCapacities(capacityList);
	    product.setPhoto(photo);

	    // 4. 경로 처리
	    String savePath = request.getServletContext().getRealPath("/data");

	    try {
	    	productService.edit(product, photo, savePath, deleteFiles);
	        return ResponseEntity.ok("상품 수정 성공");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body("상품 수정 실패: " + e.getMessage());
	    }
	}
	
	 @PostMapping("/product/delete")
	    public String deleteProduct(@RequestParam("product_id") int productId) {
	        productService.softDelete(productId);
	        return "redirect:/admin/product/list";
	    }

	// 이미지 업로드를 위한 API 추가
	 @PostMapping("/product/uploadImage")
	 @ResponseBody
	 public String uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
	     try {
	         // 저장 폴더 생성 (ex. /data)
	         String uploadDir = request.getServletContext().getRealPath("/data/");
	         File dir = new File(uploadDir);
	         if (!dir.exists()) dir.mkdirs();

	         // 파일명 유니크 처리
	         String uuid = java.util.UUID.randomUUID().toString();
	         String originalName = file.getOriginalFilename();
	         String extension = originalName.substring(originalName.lastIndexOf("."));
	         String newFileName = uuid + extension;

	         // 저장
	         File savedFile = new File(uploadDir, newFileName);
	         file.transferTo(savedFile);

	         // 클라이언트에서 접근 가능한 URL 경로 반환
	         String url = request.getContextPath() + "/data/" + newFileName;
	         return url;
	     } catch (Exception e) {
	         e.printStackTrace();
	         return "";
	     }
	 }
}