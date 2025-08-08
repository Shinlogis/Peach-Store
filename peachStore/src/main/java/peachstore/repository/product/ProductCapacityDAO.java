package peachstore.repository.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import peachstore.domain.ProductCapacity;
/**
 * 상품 용량 DAO
 * @author 김지민
 * @since 2025-08-01
 */
public interface ProductCapacityDAO {

    void insert(ProductCapacity productCapacity);
    void deleteByProductId(@Param("productId") int productId);
    List<ProductCapacity> selectByProductId(int productId);
    ProductCapacity selectById(int product_capacity_id);
}