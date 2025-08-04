package peachstore.repository.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import peachstore.domain.Product;
/**
 * 상품 DAO
 * @author 김지민
 * @since 2025-07-28
 */
public interface ProductDAO {
	
	List<Product> selectAll();
    public Product select(int product_id);
    public void insert(Product product);
    public void update(Product product);
    public void softDelete(int product_id);
    public List<Product> selectBySubId(int subId);   
    public List<Product> selectAllWithPaging(@Param("startIndex") int startIndex, @Param("pageSize") int pageSize);   
    public int count();
}