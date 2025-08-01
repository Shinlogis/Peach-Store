package peachstore.service.topcategory;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductTopcategoryException;
import peachstore.repository.topcategory.ProductTopcategoryDAO;
import peachstore.service.image.ImageFileService;
import peachstore.util.FileCommonManager;

/**
 * 제품 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ProductTopcategoryServiceImpl implements ProductTopcategoryService{

	private final ProductTopcategoryDAO productCategoryDAO;
	private final ImageFileService imageFileService;
	private final FileCommonManager fileManager;
	
	@Override
	public List<ProductTopcategory> selectAll(String searchKey) {
		return productCategoryDAO.selectAll(searchKey);
	}

	@Override
	public void register(ProductTopcategory productTopcategory, String savePath, MultipartFile photo) throws ProductTopcategoryException {
		productCategoryDAO.insert(productTopcategory); // 저장
		int id = productTopcategory.getProductTopcategoryId(); // pk값 추출
		
		// 이미지 저장
		String fileDirName = "category_"+id;
		Map<String, Object> result = imageFileService.saveImage(photo, fileDirName, savePath);

		// 저장된 이미지들의 이름 배열
		List<String> imgList = (List<String>) result.get("savedFiles");
		String filename = imgList.get(0); // 상위 카테고리는 이미지가 하나만 있어서 첫 번째 이미지명만 꺼냄
		
		// 도메인에 데이터 세팅
		productTopcategory.setFileDirName(fileDirName);
		productTopcategory.setFilename(filename);
		log.debug("이미지 저장 디렉토리: {}, 파일명: {}", fileDirName, filename);

        int resultCount = productCategoryDAO.update(productTopcategory); // filepath, filename update
        if (resultCount == 0) {
            fileManager.remove(fileDirName, savePath);
            throw new ProductTopcategoryException("상위 카테고리 등록 실패");
        }
	}
	
	@Override
	public void changeName(int productTopCategoryId, String newName) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.setProductTopcategoryName(newName);
	    
	    int result = productCategoryDAO.update(productTopcategory);
	    if (result == 0) {
	        throw new ProductTopcategoryException("이름 변경 실패");
	    }
	}

	@Override
	public void deactivate(int productTopCategoryId) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.deactivate(); 

	    int result = productCategoryDAO.update(productTopcategory); 
	    if (result == 0) {
	        throw new ProductTopcategoryException("카테고리 비활성화 실패");
	    }
	}

	@Override
	public ProductTopcategory findById(int productTopCategoryId) throws ProductTopcategoryException {
		ProductTopcategory productTopcategory = productCategoryDAO.selectById(productTopCategoryId);
		if (productTopcategory == null || !productTopcategory.getIsActive()) {
	        throw new ProductTopcategoryException("카테고리 조회 실패. 존재하지 않거나 비활성화");
	    }
		
	    return productTopcategory;
	}

	@Override
	public List<ProductTopcategory> selectAll() {
	    return productCategoryDAO.selectAll();
	}
}
