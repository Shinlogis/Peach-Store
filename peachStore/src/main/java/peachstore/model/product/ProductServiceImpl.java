package peachstore.model.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import peachstore.domain.Product;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductImg;
import peachstore.domain.ProductSize;
import peachstore.exception.ProductColorException;
import peachstore.exception.ProductException;
import peachstore.exception.ProductSizeException;
import peachstore.util.FileManager;

/**
 * 상품 서비스 구현체  
 * 상품 등록 및 관련 색상/사이즈 정보 저장을 포함한  
 * 전체 상품 비즈니스 로직을 수행한다.
 * 
 * @author 김지민
 * @since 2025-07-29
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private ProductColorDAO productColorDAO;

    @Autowired
    private ProductSizeDAO productSizeDAO;

    @Autowired
    private FileManager fileManager;

    /**
     * 상품 등록 처리  
     * 1) 상품 등록  
     * 2) 선택된 색상 등록  
     * 3) 선택된 사이즈 등록  
     * 
     * 트랜잭션 보장: 중간에 실패하면 전체 롤백
     * 
     * @param product 등록할 상품
     * @param savePath 파일 저장 경로
     * @throws ProductException
     * @throws ProductColorException
     * @throws ProductSizeException
     */
    @Transactional
    public void regist(Product product, String savePath) throws ProductException, ProductColorException, ProductSizeException {
        // 1) 상품 DB에 등록
        productDAO.insert(product);

        // 2) 색상 목록 등록
        for (ProductColor productColor : product.getProductColors()) {
            productColor.setProduct(product); // PK 포함된 Product 객체 주입
            productColorDAO.insert(productColor);
        }

        // 3) 사이즈 목록 등록
        for (ProductSize productSize : product.getProductSizes()) {
            productSize.setProduct(product);
            productSizeDAO.insert(productSize);
        }
    }

    /** 전체 상품 조회 */
    @Override
    public List selectAll() {
        return productDAO.selectAll();
    }

    /** 단일 상품 조회 */
    @Override
    public Product select(int product_id) {
        return productDAO.select(product_id);
    }

    /** 상품 정보 수정 - 구현 예정 */
    @Override
    public void update(Product product) {
        // TODO: 상품 정보 수정 로직 구현 예정
    }

    /** 상품 정보 삭제(DB만) - 구현 예정 */
    @Override
    public void delete(Product product) {
        // TODO: 상품 DB 삭제 로직 구현 예정
    }

    /** 상품 및 관련 자원 삭제(DB + 이미지) - 구현 예정 */
    @Override
    public void remove(Product product, String savePath) {
        // TODO: 상품 + 파일 리소스 삭제 로직 구현 예정
    }
}
