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
	private InquiryImgDAO inquiryImgDAO;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Inquiry select(int inquiry_id) {
		// TODO Auto-generated method stub
		return null;
	}

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
	

}
