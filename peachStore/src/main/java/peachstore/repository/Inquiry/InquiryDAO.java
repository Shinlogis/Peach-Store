package peachstore.repository.Inquiry;

import java.util.List;

import peachstore.domain.Inquiry;
/**
 * 문의하기 dao
 * @author 성유진 
 * @since 2025-07-26
 */
public interface InquiryDAO {
	
	public List selectAll();
	
	public Inquiry select(int inquiry_id);
	
	public void insert(Inquiry inquiry);

}
