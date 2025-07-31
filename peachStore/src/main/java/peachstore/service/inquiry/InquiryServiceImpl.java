package peachstore.service.inquiry;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;
import peachstore.exception.InquiryException;
import peachstore.exception.InquiryImgException;
import peachstore.exception.Uploadexception;
import peachstore.repository.Inquiry.InquiryDAO;
import peachstore.util.FileManager;

/**
 * 문의하기 service
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Service
public class InquiryServiceImpl implements InquiryService{

	
	@Autowired
	private InquiryDAO inquiryDAO;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private InquiryImgService inquiryImgService;


	@Override
	public List selectAll(Inquiry inquiry) {
		return inquiryDAO.selectAll(inquiry);
	}

	@Override
	public Inquiry select(Inquiry inquiry) {
		return inquiryDAO.select(inquiry);
	}

	@Override
	public void regist(Inquiry inquiry, String savePath) throws InquiryException, InquiryImgException, Uploadexception{
		inquiryDAO.insert(inquiry);
		
		fileManager.save(inquiry, savePath);
		
		List<InquiryImg> imgList = inquiry.getImgList();
		for(InquiryImg inquiryImg : imgList) {
			inquiryImg.setInquiry(inquiry);
			inquiryImgService.insert(inquiryImg);
		}
	}

	@Transactional
	@Override
	public void update(Inquiry inquiry, String savePath) throws InquiryException {
		
		MultipartFile[] newList=inquiry.getPhoto(); //새로운업로드된 파일 명단 
		
		//기존 파일이 목록 얻기 
		Inquiry obj = inquiryDAO.select(inquiry);
		List<InquiryImg> oldList=obj.getImgList();
		
		/*-------------------------------------------------
		교체 : 기존 파일 리스트와 새로운 파일 리스트가 갯수는 같으나, 내용을 틀림 
		 1) 새로운 목록 안의 파일이, 기존 목록 안에 없다면 추가에 해당 
		 2) 새로운 목록 안의 파일과 일치하는 게 없는  기존 파이른 삭제 대상 		 
		-------------------------------------------------*/
		
		List<MultipartFile> addList=new ArrayList();
		
		//새롭게 추가될 대상이 누구인지 조사
		for(int i=0;i<newList.length;i++) { //새로 업로된 리스트 
			int stayCount=0;
			
			for(int a=0;a<oldList.size();a++) {
				boolean stay = (newList[i].getOriginalFilename().equals(oldList.get(a).getFilename()));
				
				if(stay) { //두개를 비교해서, 같은것을 발견한 경우 유지대상 
					stayCount++;	
				}
			}
			if(stayCount<1)addList.add(newList[i]); //유지 대상이 없을때는 addList에 추가
		}	
		
		
		List<InquiryImg> removeList=new ArrayList();
		for(int i=0;i<oldList.size();i++) { //기존 리스트 
			int stayCount=0;
			
			for(int a=0;a<newList.length;a++) {
				boolean stay = (newList[a].getOriginalFilename().equals(oldList.get(i).getFilename()));
				
				if(stay) { //두개를 비교해서, 같은것을 발견한 경우 유지대상 
					stayCount++;	
				}
			}
			if(stayCount<1)removeList.add(oldList.get(i)); //유지 대상이 removeList에 추가
		}	
		
		//최종 판단 : 추가될 이미지 -> addList,삭제될 이미지 -> removeList
		for(int i=0; i<addList.size(); i++) {
			log.debug("새로 추가될 이미지 " + addList.get(i).getOriginalFilename());
		}
		for(int i=0; i<removeList.size(); i++) {
			log.debug("삭제될 이미지 " + removeList.get(i).getFilename());
		}
		
		//분석결과륾 inquiry안에 반영하기
		inquiry.setPhoto(addList.toArray(new MultipartFile[0]));
		log.debug("대체된 배열의 길이는 "+inquiry.getPhoto().length);
		if(!addList.isEmpty()) {
			inquiryDAO.update(inquiry);
			fileManager.save(inquiry, savePath);
			
			for(InquiryImg img : inquiry.getImgList()) {
				inquiryImgService.update(img);
			}
		}
		
		//삭제 대상대입
		inquiry.setImgList(removeList);
		if(!removeList.isEmpty()) {
			inquiryDAO.update(inquiry);
			fileManager.deleteImg(inquiry, savePath);
			
			for(InquiryImg img : inquiry.getImgList()) {
				inquiryImgService.update(img);
			}
		}
		
		
		
	}
	
	
	@Override
	public void remove(Inquiry inquiry, String savePath) {
		inquiryImgService.delete(inquiry.getInquiry_id());
		fileManager.remove(inquiry, savePath);
		inquiryDAO.delete(inquiry);
	}

	

}
