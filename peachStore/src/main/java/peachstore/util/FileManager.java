package peachstore.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;
import peachstore.exception.InquiryImgException;
import peachstore.exception.Uploadexception;

/**
 * 문의하기 filemanager
 * 
 * @author 성유진
 * @since 2025-07-26
 */
@Slf4j
@Component
public class FileManager {
	//상품 이미지 저장
	public void save(Inquiry inquiry, String savePath) throws Uploadexception {
		List imgList = new ArrayList();

		// 디렉토리 생성
		File directory = new File(savePath, "p_" + inquiry.getInquiry_id());

		MultipartFile[] photo = inquiry.getPhoto();
		log.debug("업로드 한 파일의 수는 " + photo.length);

		try {
			for (int i = 0; i < photo.length; i++) {
				log.debug("원본 파일명은 " + photo[i].getOriginalFilename());
				String ori = photo[i].getOriginalFilename();
				String ext = ori.substring(ori.lastIndexOf(".") + 1, ori.length());

				try {
					Thread.sleep(10);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

				long time = System.currentTimeMillis();
				String filename = time + "." + ext;

				InquiryImg inquiryImg = new InquiryImg();
				inquiryImg.setFilename(filename);
				imgList.add(inquiryImg);
				inquiry.setImgList(imgList);

				File file = new File(directory.getAbsolutePath() + File.separator + filename);
				log.debug("업로드된 이미지가 생성된 경로는 " + savePath);

				photo[i].transferTo(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Uploadexception("파일 업로드 실패", e);
		}
	}

	
	
	//상품 이미지 삭제
	public void remove(Inquiry inquiry, String savePath) {
		
		File directory = new File(savePath, "p_" + inquiry.getInquiry_id());
		
		if(directory.exists()&&directory.isDirectory()) {
			File[] files = directory.listFiles();
			
			if(files!= null) {
				for(File file : files) {
					boolean deleted = file.delete();
					log.debug(file.getName() + "를 삭제한 결과" + deleted);
				}
			}
			
			boolean result = directory.delete();
			
			if(result == false) {
				log.warn("디렉토리 삭제 실패" + directory.getAbsolutePath());
			}
		}
	}
	
	//삭제 대상 파일 처리
	public void deleteImg(Inquiry inquiry, String savePath) throws InquiryImgException{
		for(int i=0; i<inquiry.getImgList().size(); i++) {
			File file = new File(savePath, "p_" + inquiry.getInquiry_id()+ "/" + inquiry.getImgList().get(i).getFilename());
			boolean deleted = file.delete();
			
			if(deleted == false) {
				throw new InquiryImgException("사진 삭제 실패");
			}
		}
	}
	
	
	
	
}
