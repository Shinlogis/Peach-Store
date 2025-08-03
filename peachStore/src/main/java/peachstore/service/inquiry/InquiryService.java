package peachstore.service.inquiry;

import java.util.List;
import java.util.Map;

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
	
	/**
	 * 관리자용 전체 조회
	 * @return
	 */
	public List<Inquiry> selectAllAtAdmin(Map<String, Object> searchMap);
	
	/**
	 * 문의 답변 등록
	 * @param inquiry_id 답변 달 문의 id
	 * @param admin_id 답변 단 관리자 id
	 * @param answer_text 답변 내용
	 */
	public void answerInquiry(int inquiry_id, int admin_id, String answer_text);
	
	/**
	 * pk를 통한 조회
	 * @param inquiry_id
	 * @return
	 */
	public Inquiry findById(int inquiry_id);
	
}
