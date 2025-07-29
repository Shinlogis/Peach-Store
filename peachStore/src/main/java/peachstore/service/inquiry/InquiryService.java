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
	
	public List selectAll(Inquiry inquiry);
	
	public Inquiry select(Inquiry inquiry);
	
	public void regist(Inquiry inquiry, String savePath);
	
	public void update(Inquiry inquiry, String savePath);
	
	public void remove(Inquiry inquiry, String savePath);

}
