package peachstore.repository.Inquiry;

import java.util.List;

import peachstore.domain.Inquiry;
/**
 * 문의하기 dao
 * @author 성유진 
 * @since 2025-07-26
 */
public interface InquiryDAO {
	
	public List selectAll(Inquiry inquiry);
	
	public Inquiry select(Inquiry inquiry);
	
	public void insert(Inquiry inquiry);
	
	public void update(Inquiry inquiry);

}
