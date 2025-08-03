package peachstore.service.topcategory;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductTopcategoryException;
import peachstore.repository.topcategory.ProductTopcategoryDAO;
import peachstore.service.image.ImageFileService;
import peachstore.util.FileCommonManager;

/**
 * 제품 상위 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ProductTopcategoryServiceImpl implements ProductTopcategoryService{

	private final ProductTopcategoryDAO productTopCategoryDAO;
	private final ImageFileService imageFileService;
	private final FileCommonManager fileManager;

	@Override
	public List<ProductTopcategory> selectAll(String searchKey) {
		return productTopCategoryDAO.selectAll(searchKey);
	}

	@Override
	public void register(ProductTopcategory productTopcategory, String savePath, MultipartFile photo) throws ProductTopcategoryException {
		productTopCategoryDAO.insert(productTopcategory); // 저장
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

        int resultCount = productTopCategoryDAO.update(productTopcategory); // filepath, filename update
        if (resultCount == 0) {
            fileManager.remove(fileDirName, savePath);
            throw new ProductTopcategoryException("상위 카테고리 등록 실패");
        }
	}
	
	@Override
	@Transactional
	public void change(int productTopCategoryId, String newName, String savePath, MultipartFile photo) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    // 기존 이미지 저장 폴더명
	    String originalFileDirName = "category_"+productTopCategoryId;
	    // 기존 이미지 이름
	    String originalFilename = productTopcategory.getFilename();
	    // 기존 이미지 폴더를 백업해둘 폴더명
	    String backupDirName = originalFileDirName + "_backup";
	    
	    // 이미지도 변경하는 경우
	    if (photo != null && !photo.isEmpty()) {
		    // 기존 이미지 폴더 백업
		    try {
				fileManager.move(originalFileDirName, backupDirName, savePath, false);
			} catch (IOException e) {
				throw new ProductTopcategoryException("기존 이미지 백업 중 오류 발생", e);
			}
	    
		    List<String> imgList;
			try {
				// 새로운 이미지 저장
			    Map<String, Object> imgMap = imageFileService.saveImage(photo, originalFileDirName, savePath);
				// 저장된 이미지들의 이름 꺼내기
				imgList = (List<String>) imgMap.get("savedFiles");
			} catch (Exception e) {
				// 백업본 이미지 복원
				fileManager.restoreBackupImage(backupDirName, originalFileDirName, savePath);
				throw new ProductTopcategoryException("새 이미지 저장 실패", e);
			}
	    
	    
		// 변경한 파일명, 새로 저장한 이미지를 도메인에 세팅
		String newFilename = imgList.get(0);
		productTopcategory.setFileDirName(originalFileDirName);
		productTopcategory.setFilename(newFilename);
	    }
	    productTopcategory.setProductTopcategoryName(newName);

		// DB 업데이트
		int result = productTopCategoryDAO.update(productTopcategory);
		if (result == 0) {
			// 이미지 수정 시 복원 시도
			if (photo != null && !photo.isEmpty()) {
				fileManager.restoreBackupImage(backupDirName, originalFileDirName, savePath);
				// 자바 객체도 복구 (혹시몰라서)
				productTopcategory.setFileDirName(originalFileDirName);
				productTopcategory.setFilename(originalFilename);
			}
			throw new ProductTopcategoryException("DB 업데이트 실패");
		}

		 // 성공 시 백업 이미지 폴더 삭제 (이미지 수정 시에만)
	    if (photo != null && !photo.isEmpty()) {
	        fileManager.remove(backupDirName, savePath);
	    }
	}
	
	@Override
	public void deactivate(int productTopCategoryId) throws ProductTopcategoryException {
	    ProductTopcategory productTopcategory = findById(productTopCategoryId);
	    productTopcategory.setActive(!productTopcategory.isActive());

	    int result = productTopCategoryDAO.update(productTopcategory); 
	    if (result == 0) {
	        throw new ProductTopcategoryException("카테고리 비활성화 실패");
	    }
	}

	@Override
	public ProductTopcategory findById(int productTopCategoryId) throws ProductTopcategoryException {
		ProductTopcategory productTopcategory = productTopCategoryDAO.selectById(productTopCategoryId);
		if (productTopcategory == null) {
	        throw new ProductTopcategoryException("카테고리 조회 실패. 존재하지 않음");
	    }
		
	    return productTopcategory;
	}

	@Override
	public List<ProductTopcategory> selectAll() {
	    return productTopCategoryDAO.selectAll();
	}
}
