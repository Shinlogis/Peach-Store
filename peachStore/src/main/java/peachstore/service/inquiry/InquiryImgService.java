package peachstore.service.inquiry;

import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;

/**
 * 문의사진 service
 * @author 성유진 
 * @since 2025-07-26
 */
public interface InquiryImgService {
	public void insert(InquiryImg inquiryImg);
	
	public void update(InquiryImg inquiryImg);
	
	public void delete(int inquiry_id);
	
	
}
