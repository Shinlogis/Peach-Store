package peachstore.domain;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 제품 상위 카테고리
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Getter
@Setter
@NoArgsConstructor
public class ProductTopcategory {
    private int productTopcategoryId;
    private String productTopcategoryName;
    private boolean isActive;
    private List<ProductSubcategory> productSubcategory;
    
    public void deactivate() {
        this.isActive = false;
    }

}
