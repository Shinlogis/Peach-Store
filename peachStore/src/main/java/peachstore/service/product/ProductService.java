package peachstore.service.product;

import java.util.List;

import peachstore.domain.Product;

/**
 * 상품(Product) 관련 서비스 인터페이스   
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductService {

    /**
     * 상품 등록
     * @param product 등록할 상품 객체
     * @param savePath 이미지 저장 경로
     */
    public void regist(Product product, String savePath); 

    /**
     * 전체 상품 목록 조회
     * @return 상품 리스트
     */
    public List selectAll();

    /**
     * 특정 상품 상세 조회
     * @param product_id 상품 ID
     * @return 상품 객체
     */
    public Product select(int product_id);

    /**
     * 상품 정보 수정
     * @param product 수정할 상품 객체
     */
    public void update(Product product);

    /**
     * 상품 정보 삭제 (DB만)
     * @param product 삭제할 상품 객체
     */
    public void delete(Product product);

    /**
     * 상품 정보 및 관련 자원 삭제 (파일 포함)
     * @param product 삭제할 상품 객체
     * @param savePath 파일 경로
     */
    public void remove(Product product, String savePath);
    
    /**
     * 페이징된 상품 목록 조회
     * @param startIndex 시작 인덱스
     * @param pageSize 한 페이지에 표시할 개수
     * @return 상품 리스트
     */
    public List<Product> selectAll(int startIndex, int pageSize);

    /**
     * 전체 상품 수 조회 (페이징 계산용)
     * @return 전체 상품 수
     */
    public int getTotalRecord();
}
