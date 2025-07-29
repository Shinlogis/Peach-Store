package peachstore.model.product;

import java.util.List;

import peachstore.domain.Product;
/**
 * 상품 DAO
 * @author 김지민
 * @since 2025-07-28
 */
public interface ProductDAO {

    /**
     * 상품 전체 목록 조회
     * @return 전체 상품 목록 (List<Product>)
     */
    public List<Product> selectAll();

    /**
     * 특정 상품 상세 조회
     * @param product_id 조회할 상품의 ID
     * @return 해당 ID에 해당하는 Product 객체
     */
    public Product select(int product_id);

    /**
     * 신규 상품 등록
     * @param product 등록할 상품 객체
     */
    public void insert(Product product);

    /**
     * 상품 정보 수정
     * @param product 수정할 상품 객체
     */
    public void update(Product product);

    /**
     * 상품 삭제
     * @param product 삭제할 상품 객체
     */
    public void delete(Product product);
}