package peachstore.service.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	@Override
	public void remove(Inquiry inquiry, String savePath) {
		fileManager.remove(inquiry, savePath);
	}
	

}
