package peachstore.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;

/**
 * 상품
 * @author 김지민
 * @since 2025-07-28
 */
@Data
public class Product {
    private Integer productId;
    private String productCode;
    private String productName;
    private Integer price;
    private String introduce;
    private String detail;

    // 연관 정보
    private ProductTopcategory productTopcategory; // 탑 카테고리 정보
    private ProductSubcategory productSubcategory; // 서브 카테고리 정보
    @ToString.Exclude
    private List<ProductImg> productImgs;          // 이미지 리스트
    @ToString.Exclude
    private List<ProductSize> productSizes;   // StackOverflowError 방지

    @ToString.Exclude
    private List<ProductColor> productColors; // StackOverflowError 방지

    @ToString.Exclude
    private List<ProductCapacity> productCapacities; // StackOverflowError 방지
    
    //하나의 상품은 여러가지 이미지 보유 가능
	private MultipartFile[] photo;
}

