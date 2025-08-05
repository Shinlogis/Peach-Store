package peachstore.service.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import peachstore.domain.Product;
import peachstore.exception.Uploadexception;

/**
 * 상품(Product) 관련 서비스 인터페이스   
 * @author 김지민
 * @since 2025-07-29
 */
public interface ProductService {

    public void regist(Product product, String savePath); 
    public List selectAll();
    public Product select(int product_id);
    void edit(Product product, MultipartFile[] photo, String savePath, List<String> deleteFiles);
    public void softDelete(int product_id);
    public void remove(Product product, String savePath);
    public List<Product> selectAll(int startIndex, int pageSize);
    public int getTotalRecord();
    public List<Product> selectBySubId(int subId);
    public List<Product> selectByTopId(int topId);
    public List<Product> selectByTopId(int topId, int page, int pageSize);
    public int getTotalRecordByTopId(int topId);
}
