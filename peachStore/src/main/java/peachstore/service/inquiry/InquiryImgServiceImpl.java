package peachstore.service.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.InquiryImg;
import peachstore.exception.Uploadexception;
import peachstore.repository.Inquiry.InquiryImgDAO;
/**
 * 문의사진 service
 * @author 성유진 
 * @since 2025-07-26
 */

@Service
public class InquiryImgServiceImpl implements InquiryImgService{

	@Autowired
	private InquiryImgDAO inquiryImgDAO;
	
	@Override
	public void insert(InquiryImg inquiryImg) throws Uploadexception{
		inquiryImgDAO.insert(inquiryImg);
		
	}

	
}
