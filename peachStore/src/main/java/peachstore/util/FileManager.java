package peachstore.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;
import peachstore.exception.Uploadexception;
/**
 * 문의하기 filemanager
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Component
public class FileManager {
	
	public void save(Inquiry inquiry, String savePath) throws Uploadexception {
		List imgList = new ArrayList();
		
		//디렉토리 생성
		File directory = new File(savePath, "p_"+inquiry.getInquiry_id());
		
		
		MultipartFile[] photo =  inquiry.getPhoto();
		log.debug("업로드 한 파일의 수는 " + photo.length);
		
		try {
			for(int i=0; i<photo.length; i++) {
				log.debug("원본 파일명은 " +photo[i].getOriginalFilename());
				String ori = photo[i].getOriginalFilename();
				String ext =ori.substring(ori.lastIndexOf(".")+1, ori.length());
			
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
		}catch (Exception e) {
			e.printStackTrace();
			throw new Uploadexception("파일 업로드 실패",e);
		}
	}
	
	
	
}
