package peachstore.repository.Inquiry;

import java.util.List;
import java.util.Map;

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
	
	public void delete(Inquiry inquiry);

	/**
	 * 관리자용 전체조회
	 */
	public List<Inquiry> selectAllAtAdmin(Map<String, Object> searchMap);
	
	/**
	 * 문의 답변
	 * @param inquiry
	 * @return
	 */
	public int updateAnswer(Inquiry inquiry);
	
	/**
	 * pk를 통한 조회
	 * @param inquiry_id
	 * @return
	 */
	public Inquiry selectById(int inquiry_id);
	
	//페이징 총 레코드 수 조회
	public int count(Inquiry inquiry);
	
	//페이징 처리될 리스트 조회
	public List<Inquiry> paging(Map<String, Object> param);
	
	
	
}
