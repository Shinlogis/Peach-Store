package peachstore.service.inquiry;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;
import peachstore.exception.InquiryException;
import peachstore.exception.InquiryImgException;
import peachstore.exception.Uploadexception;
import peachstore.repository.Inquiry.InquiryDAO;
import peachstore.repository.Inquiry.InquiryImgDAO;
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
	private InquiryImgDAO inquiryImgDAO;
	
	
	@Autowired
	private FileManager fileManager;
	


	@Override
	public List selectAll(Inquiry inquiry) {
		return inquiryDAO.selectAll(inquiry);
	}

	@Override
	public Inquiry select(Inquiry inquiry) {
		return inquiryDAO.select(inquiry);
	}

	@Transactional
	@Override
	public void regist(Inquiry inquiry, String savePath) throws InquiryException, InquiryImgException, Uploadexception{
		inquiryDAO.insert(inquiry);
		
		fileManager.save(inquiry, savePath);
		
		List<InquiryImg> imgList = inquiry.getImgList();
		for(InquiryImg inquiryImg : imgList) {
			inquiryImg.setInquiry(inquiry);
			inquiryImgDAO.insert(inquiryImg);
		}
	}

	@Transactional
	@Override
	public void update(Inquiry inquiry, String savePath) throws InquiryException {
		
		//기존 레코드 삭제
		inquiryImgDAO.delete(inquiry.getInquiry_id());
		
		//폴더 안의 기존 파일 삭제
		fileManager.remove(inquiry, savePath);
		
		inquiryDAO.update(inquiry);
		
		//새로 저장 
		fileManager.save(inquiry, savePath);
		
		List<InquiryImg> imgList = inquiry.getImgList();
		for(InquiryImg inquiryImg : imgList) {
			inquiryImg.setInquiry(inquiry);
			inquiryImgDAO.insert(inquiryImg);
		}
		
		
	}
	
	
	@Override
	public void remove(Inquiry inquiry, String savePath) throws InquiryImgException, InquiryException {
		inquiryImgDAO.delete(inquiry.getInquiry_id());
		fileManager.remove(inquiry, savePath);
		inquiryDAO.delete(inquiry);
	}

	@Override
	public List<Inquiry> selectAllAtAdmin() {
		return inquiryDAO.selectAllAtAdmin();
	}

	

}
