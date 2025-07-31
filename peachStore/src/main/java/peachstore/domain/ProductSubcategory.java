package peachstore.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 제품 하위 카테고리
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Getter
@Setter
@NoArgsConstructor
public class ProductSubcategory {
    private int productSubcategoryId;
    private String productSubcategoryName;
    private Boolean isActive;
    private ProductTopcategory productTopcategory;
    
    public void deactivate() {
        this.isActive = false;
    }

}
