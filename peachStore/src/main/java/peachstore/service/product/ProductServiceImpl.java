package peachstore.service.product;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Product;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductImg;
import peachstore.domain.ProductSize;
import peachstore.exception.ProductColorException;
import peachstore.exception.ProductException;
import peachstore.exception.ProductSizeException;
import peachstore.repository.product.ProductColorDAO;
import peachstore.repository.product.ProductDAO;
import peachstore.repository.product.ProductImgDAO;
import peachstore.repository.product.ProductSizeDAO;
import peachstore.util.FileCommonManager;

/**
 * 상품 등록 및 관련 색상/사이즈 정보 저장을 포함한  
 * 전체 상품 비즈니스 로직을 수행
 * @author 김지민
 * @since 2025-07-29
 */
@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private ProductColorDAO productColorDAO;

    @Autowired
    private ProductSizeDAO productSizeDAO;

    @Autowired
    private FileCommonManager fileCommonManager;
    
    @Autowired
	private ProductImgDAO productImgDAO;

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
        int productId = product.getProductId();

     // 2. 디렉토리 생성용 서브 경로
        String subDir = "product_" + productId;
        
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
        
        // 4) 이미지 저장
        List<String> savedFilenames = fileCommonManager.saveFiles(product.getPhoto(), savePath, subDir);

        // 5) DB에 이미지 정보 저장
        List<ProductImg> imgList = new ArrayList<>();
        for (String filename : savedFilenames) {
            ProductImg img = new ProductImg();
            img.setProduct(product);  
            img.setFilename(filename); 
            productImgDAO.insert(img);
            imgList.add(img);
        }
        product.setProductImgs(imgList); // 이후 사용을 위해 연결
    }

    /** 전체 상품 조회 */
    public List<Product> selectAll() {
        List<Product> list = productDAO.selectAll();
        log.error("selectAll() 호출됨, 결과 사이즈: " + list.size());

        return list;
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
    	fileCommonManager.remove("product", savePath); 
    }

    public List<Product> selectAll(int page, int pageSize) {
        int total = productDAO.count();
        if (total == 0) {
            return new ArrayList<>();
        }

        int safePage = Math.max(1, page);
        int offset = (safePage - 1) * pageSize;

        return productDAO.selectAllWithPaging(offset, pageSize);
    }

	@Override
	public int getTotalRecord() {
		return productDAO.count(); 
	}
}
