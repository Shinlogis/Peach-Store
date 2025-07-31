package peachstore.service.image;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import peachstore.exception.Uploadexception;

/**
 * 공통 이미지 저장 서비스
 * @author 김예진
 * @since 2025-07-31
 */
public interface ImageFileService {
	/**
	 * 
	 * @param file 저장할 이미지 파일들
	 * @param subDirPrefix 폴더명 앞에 붙일 단어 (ex, category)
	 * @param savePath 저장 경로
	 * @return
	 * @throws Uploadexception
	 */
	Map<String, Object> saveImage(MultipartFile file, String subDirPrefix, String savePath) throws Uploadexception;

	/**
	 * 이미지 삭제
	 * @param subDir
	 * @throws Uploadexception
	 */
	void removeImage(String subDir, String subDirPrefix)  throws Uploadexception;
}
