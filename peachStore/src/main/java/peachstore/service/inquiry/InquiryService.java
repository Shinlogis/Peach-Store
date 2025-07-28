package peachstore.service.inquiry;

import java.util.List;

import peachstore.domain.Inquiry;

/**
 * 문의하기 service
 * 
 * @author 성유진
 * @since 2025-07-26
 */
public interface InquiryService {
	
	public List selectAll();
	
	public Inquiry select(int inquiry_id);
	
	public void regist(Inquiry inquiry, String savePath);

}
