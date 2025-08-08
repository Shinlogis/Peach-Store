package peachstore.service.product;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Product;
import peachstore.domain.ProductCapacity;
import peachstore.domain.ProductColor;
import peachstore.domain.ProductImg;
import peachstore.domain.ProductSize;
import peachstore.exception.ProductColorException;
import peachstore.exception.ProductException;
import peachstore.exception.ProductSizeException;
import peachstore.exception.Uploadexception;
import peachstore.repository.product.ProductCapacityDAO;
import peachstore.repository.product.ProductColorDAO;
import peachstore.repository.product.ProductDAO;
import peachstore.repository.product.ProductImgDAO;
import peachstore.repository.product.ProductSizeDAO;
import peachstore.util.FileCommonManager;

/**
 * 상품 관련 서비스 로직 실행
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

    @Autowired
    private ProductCapacityDAO productCapacityDAO;

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
        
        // 4) 용량 목록 등록
        for (ProductCapacity productCapacity : product.getProductCapacities()) {
            productCapacity.setProduct(product); // product 객체 주입
            productCapacityDAO.insert(productCapacity); // insert 호출
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

    public List<Product> selectAll() {
        List<Product> list = productDAO.selectAll();
        log.error("selectAll() 호출됨, 결과 사이즈: " + list.size());

        return list;
    }

    @Override
    public Product select(int product_id) {
        return productDAO.select(product_id);
    }

    @Transactional
    public void edit(Product product, MultipartFile[] photos, String savePath, List<String> deleteFiles) throws Uploadexception {
        int productId = product.getProductId();
        
        // 1. 기본 상품 정보 수정
        productDAO.update(product);

        // 2. 기존 옵션 삭제
        productColorDAO.deleteByProductId(productId);
        productSizeDAO.deleteByProductId(productId);
        productCapacityDAO.deleteByProductId(productId);

        // 3. 옵션 재등록
        for (ProductColor c : product.getProductColors()) {
            c.setProduct(product);
            productColorDAO.insert(c);
        }
        for (ProductSize s : product.getProductSizes()) {
            s.setProduct(product);
            productSizeDAO.insert(s);
        }
        for (ProductCapacity cap : product.getProductCapacities()) {
            cap.setProduct(product);
            productCapacityDAO.insert(cap);
        }

        // ✅ 4. 삭제할 이미지 제거
        if (deleteFiles != null && !deleteFiles.isEmpty()) {
            String productDir = "product_" + productId;
            for (String filename : deleteFiles) {

                // DB에서 삭제
                productImgDAO.deleteByFilename(filename);

                // 파일 시스템에서 삭제
                fileCommonManager.deleteFile(savePath, productDir, filename);
            }
        }

        // ✅ 5. 새로운 사진 추가
        if (photos != null && photos.length > 0 && !photos[0].isEmpty()) {
            String productDir = "product_" + productId;
            List<String> filenames = fileCommonManager.saveFiles(photos, savePath, productDir);
            for (String filename : filenames) {
                ProductImg img = new ProductImg();
                img.setProduct(product);
                img.setFilename(filename);
                productImgDAO.insert(img);
            }
        }
    }


    @Override
    public void softDelete(int product_id) {
        productDAO.softDelete(product_id);
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

	@Override
	public List<Product> selectBySubId(int subId) {
		return productDAO.selectBySubId(subId);
	}

	@Override
	public List<Product> selectByTopId(int topId) {
		return productDAO.selectByTopId(topId);
	}
	
	@Override
	public List<Product> selectByTopId(int topId, int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return productDAO.selectByTopIdWithPaging(topId, offset, pageSize);
	}
	
	@Override
	public int getTotalRecordByTopId(int topId) {
		return productDAO.countByTopId(topId);
	}
}
