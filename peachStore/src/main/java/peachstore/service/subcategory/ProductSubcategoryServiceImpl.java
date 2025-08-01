package peachstore.service.subcategory;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductSubcategory;
import peachstore.domain.ProductTopcategory;
import peachstore.exception.ProductSubcategoryException;
import peachstore.exception.ProductTopcategoryException;
import peachstore.repository.subcategory.ProductSubcategoryDAO;
import peachstore.service.image.ImageFileService;
import peachstore.service.topcategory.ProductTopcategoryService;
import peachstore.util.FileCommonManager;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductSubcategoryServiceImpl implements ProductSubcategoryService {

	private final ProductSubcategoryDAO productSubcategoryDAO;
	private final ProductTopcategoryService productTopcategoryService;
	private final ImageFileService imageFileService;
	private final FileCommonManager fileManager;

	@Override
	public List<ProductSubcategory> findAllWithTopcategory(String searchKey) {
		return productSubcategoryDAO.findAllWithTopcategory(searchKey);
	}

	@Override
	public void register(String name, int topcategoryId) throws ProductSubcategoryException{
		// 상위 카테고리 조회
		ProductTopcategory productTopcategory = productTopcategoryService.findById(topcategoryId);

		// 하위 카테고리 생성
		ProductSubcategory productSubcategory = new ProductSubcategory();
		productSubcategory.setProductTopcategory(productTopcategory);
		productSubcategory.setProductSubcategoryName(name);
		
		int result = productSubcategoryDAO.insert(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 등록 실패");
		}
	}
	

	@Override
	public void register(String productSubCategoryName, int productTopcategoryId, String savePath, MultipartFile photo) {
		// 상위 카테고리 조회
		ProductTopcategory productTopcategory = productTopcategoryService.findById(productTopcategoryId);

		// 하위 카테고리 생성
		ProductSubcategory productSubcategory = new ProductSubcategory();
		productSubcategory.setProductTopcategory(productTopcategory);
		productSubcategory.setProductSubcategoryName(productSubCategoryName);
		
		productSubcategoryDAO.insert(productSubcategory); // 저장
		int id = productSubcategory.getProductSubcategoryId(); // pk값 추출
		
		// 이미지 저장
		String fileDirName = "subcategory_"+id;
		Map<String, Object> result = imageFileService.saveImage(photo, fileDirName, savePath);

		// 저장된 이미지들의 이름 배열
		List<String> imgList = (List<String>) result.get("savedFiles");
		String filename = imgList.get(0); // 카테고리는 이미지가 하나만 있어서 첫 번째 이미지명만 꺼냄
		
		// 도메인에 데이터 세팅
		productSubcategory.setFileDirName(fileDirName);
		productSubcategory.setFilename(filename);
		log.debug("이미지 저장 디렉토리: {}, 파일명: {}", fileDirName, filename);

        int resultCount = productSubcategoryDAO.update(productSubcategory); // filepath, filename update
        if (resultCount == 0) {
            fileManager.remove(fileDirName, savePath);
            throw new ProductTopcategoryException("하위 카테고리 등록 실패");
        }
	}

	@Override
	public void updateName(String name, int subcategoryId) throws ProductSubcategoryException{
		// 해당 서브 카테고리 조회
		ProductSubcategory productSubcategory = findById(subcategoryId);
		productSubcategory.setProductSubcategoryName(name);
		
		int result = productSubcategoryDAO.update(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 이름 수정 실패");
		}
	}

	// TODO 수정필요 deactivate
	@Override
	public void deactivate(int subcategoryId) throws ProductSubcategoryException {
		// 해당 서브 카테고리 조회
		ProductSubcategory productSubcategory = findById(subcategoryId);
		productSubcategory.deactivate();
		
		int result = productSubcategoryDAO.update(productSubcategory);
		if (result == 0) {
			throw new ProductSubcategoryException("서브 카테고리 비활성화 실패");
		}
	}

	@Override
	public ProductSubcategory findById(int subcategoryId) throws ProductSubcategoryException{
		ProductSubcategory productSubcategory = productSubcategoryDAO.findById(subcategoryId);
		if (productSubcategory == null || !productSubcategory.getIsActive()) {
			throw new ProductSubcategoryException("서브 카테고리 조회 실패. 존재하지 않거나 비활성화");
		}
		return productSubcategory;
	}

	@Override
	public List<ProductSubcategory> findAllByTopcategoryId(int productTopcategoryId) {
		return productSubcategoryDAO.findAllByTopcategoryId(productTopcategoryId);
	}
}
