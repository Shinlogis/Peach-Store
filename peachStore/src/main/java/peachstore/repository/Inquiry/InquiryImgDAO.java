package peachstore.repository.Inquiry;

import java.util.List;

import peachstore.domain.InquiryImg;

/**
 * 문의사진 dao
 * @author 성유진 
 * @since 2025-07-26
 */
public interface InquiryImgDAO {
	
	public void insert(InquiryImg inquiryImg);
	
	public void update(InquiryImg inquiryImg);
	
	public void delete(int inquiry_id);
	
	public void deleteByFilename(InquiryImg inquiryImg);

	public List select(int inquiry_id);
}
