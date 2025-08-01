package peachstore.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.exception.Uploadexception;

/**
 * 공용 파일 매니저
 * @author 김예진
 * @since 2025-07-31
 */
@Slf4j
@Component
public class FileCommonManager {

	/**
	 * 이미지 파일들을 저장하는 메서드
	 * @param files MultipartFile 배열
	 * @param savePath 저장 경로
	 * @param subDir 저장 폴더 접두사명
	 * @return 
	 * @throws Uploadexception
	 */
    public List<String> saveFiles(MultipartFile[] files, String savePath, String subDir) throws Uploadexception {
        List<String> filenameList = new ArrayList<>();

        // 디렉토리 경로 생성
        File directory = new File(savePath, subDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        
        log.info("파일 저장 디렉토리: {}", directory.getAbsolutePath()); // 경로 확인용 로그

        try {
            for (MultipartFile file : files) {
                String originalName = file.getOriginalFilename();
                if (originalName == null || originalName.isEmpty()) continue;

                String ext = originalName.substring(originalName.lastIndexOf('.') + 1);
                long time = System.currentTimeMillis();
                String filename = time + "." + ext;

                File saveFile = new File(directory, filename);
                file.transferTo(saveFile);

                filenameList.add(filename);

                log.debug("파일 저장 경로: {}", saveFile.getAbsolutePath());

                // 저장 간 간격
                Thread.sleep(5);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Uploadexception("파일 저장 실패", e);
        }

        return filenameList;
    }
    
    /**
     * 이미지 파일 지우기
     * @param subDir 저장폴더명
     * @param savePath 저장 경로
     * @throws UploadException
     */
	public void remove(String subDir, String savePath) throws Uploadexception  {
		File directory = new File(savePath, subDir);
		log.debug("삭제 시도 경로: {}", directory.getAbsolutePath());

		// 폴더 내 파일이 존재할 경우
		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles();
			
			if(files != null) {
				// 파일 삭제
				for (File file: files) {
					boolean deleted = file.delete();
					log.debug(file.getName()+"삭제 결과 "+deleted);
				}
			}
			
			// 디렉토리 삭제
			boolean result = directory.delete();
			if(result == false) {
				log.warn(directory.getAbsolutePath()+"디렉토리 삭제 실패");
			}
		}
	}
}
