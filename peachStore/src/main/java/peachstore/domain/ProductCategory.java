package peachstore.domain;

import lombok.Getter;

/**
 * 제품 카테고리
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Getter
public class ProductCategory {
    private int productCategoryId;
    private String productCategoryName;
    private boolean isActive;

    // setter
    public void setName(String name) { this.productCategoryName = name; }
    public void setActive(boolean active) { this.isActive = active; }
    
    public void deactivate() {
        this.isActive = false;
    }

}
