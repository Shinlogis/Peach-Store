package peachstore.domain;

import java.util.List;

import lombok.Data;

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
    private ProductTopcategory productTopCategory; // 탑 카테고리 정보
    private ProductSubcategory productSubCategory; // 서브 카테고리 정보
    private List<ProductImg> productImgs;          // 이미지 리스트
    private List<ProductSize> productSizes;        // 사이즈 옵션
    private List<ProductColor> productColors;      // 색상 옵션
    private List<ProductCapacity> productCapacities; // 용량 옵션
}

