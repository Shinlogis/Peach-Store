package peachstore.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.exception.Uploadexception;

/**
 * 공용 파일 매니저
 * 
 * @author 김예진
 * @since 2025-07-31
 */
@Slf4j
@Component
public class FileCommonManager {

	/**
	 * 이미지 파일들을 저장하는 메서드
	 * 
	 * @param files    MultipartFile 배열
	 * @param savePath 저장 경로
	 * @param subDir   저장 폴더 접두사명
	 * @return
	 * @throws Uploadexception
	 */
	public List<String> saveFiles(MultipartFile[] files, String savePath, String subDir) throws Uploadexception {
		List<String> filenameList = new ArrayList<>();
        
		 if (files == null || files.length == 0) {
		        // 사진 파일이 없으면 빈 리스트 반환 (예외 없이 그냥 넘어감)
		        return filenameList;
		    }
		
		// 디렉토리 경로 생성
        File directory = new File(savePath, subDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        
        log.info("파일 저장 디렉토리: {}", directory.getAbsolutePath()); // 경로 확인용 로그

		try {
			for (MultipartFile file : files) {
				String originalName = file.getOriginalFilename();
				if (originalName == null || originalName.isEmpty())
					continue;

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
	 * 
	 * @param subDir   저장폴더명
	 * @param savePath 저장 경로
	 * @throws UploadException
	 */
	public void remove(String subDir, String savePath) throws Uploadexception {
		File directory = new File(savePath, subDir);
		log.debug("삭제 시도 경로: {}", directory.getAbsolutePath());

		// 폴더 내 파일이 존재할 경우
		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles();

			if (files != null) {
				// 파일 삭제
				for (File file : files) {
					boolean deleted = file.delete();
					log.debug(file.getName() + "삭제 결과 " + deleted);
				}
			}

			// 디렉토리 삭제
			boolean result = directory.delete();
			if (result == false) {
				log.warn(directory.getAbsolutePath() + "디렉토리 삭제 실패");
			}
		}
	}

	/**
	 * 폴더 이름을 바꾸는 메서드
	 * 
	 * @param sourceDirName
	 * @param targetDirName
	 * @param basePath
	 * @param delete        기존 폴더 삭제를 원하는지
	 * @throws IOException
	 */
	public void move(String sourceDirName, String targetDirName, String basePath, boolean delete) throws IOException {
		Path sourceDir = Paths.get(basePath, sourceDirName);
		Path targetDir = Paths.get(basePath, targetDirName);

		if (!Files.exists(sourceDir)) {
			log.debug("원본폴더 {}가 존재하지 않음", sourceDir.toString());
			// 원본 폴더가 없으면 이동할 게 없으니 그냥 리턴
			return;
		}

		// 타겟 폴더가 이미 존재하는 경우
		if (Files.exists(targetDir)) {
			// 삭제를 원하는 경우
			if (delete) {
				try {
					log.debug("삭제대상 {}/{}", basePath, targetDirName);
					remove(targetDirName, basePath);
				} catch (Uploadexception e) {
					e.printStackTrace();
					throw new IOException("폴더 삭제 실패");
				}
			} else {
				throw new IOException("이미 존재하는 폴더");
			}
		}

		// 폴더 이름 변경
		Files.move(sourceDir, targetDir, StandardCopyOption.REPLACE_EXISTING);
	}

	/**
	 * 기존 이미지로 백업 복구
	 */
	public void restoreBackupImage(String backupDirName, String originalFileDirName, String savePath) {
		try {
			// 실패한 새 이미지 삭제
			remove(originalFileDirName, savePath);
		} catch (Uploadexception e) {
			log.warn("롤백 중 새 이미지 삭제 실패", e);
		}

		try {
			// 백업해둔 이미지를 복구
			move(backupDirName, originalFileDirName, savePath, true);
		} catch (IOException e) {
			log.error("백업 이미지 복원 실패", e);
		}
	}
}
