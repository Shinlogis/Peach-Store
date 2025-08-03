package peachstore.service.inquiry;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.domain.Inquiry;
import peachstore.domain.InquiryImg;
import peachstore.exception.InquiryException;
import peachstore.exception.InquiryImgException;
import peachstore.exception.Uploadexception;
import peachstore.repository.Inquiry.InquiryDAO;
import peachstore.repository.Inquiry.InquiryImgDAO;
import peachstore.service.admin.AdminService;
import peachstore.util.FileManager;

/**
 * 문의하기 service
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Service
public class InquiryServiceImpl implements InquiryService{

	@Autowired
	private InquiryDAO inquiryDAO;
	@Autowired
	private InquiryImgDAO inquiryImgDAO;
	@Autowired
	private FileManager fileManager;
	
//	@Autowired
//	private InquiryImgService inquiryImgService;
	@Autowired
	private AdminService adminService;


	@Override
	public List selectAll(Inquiry inquiry) {
		return inquiryDAO.selectAll(inquiry);
	}

	@Override
	public Inquiry select(Inquiry inquiry) {
		return inquiryDAO.select(inquiry);
	}

	@Override
	public void regist(Inquiry inquiry, String savePath) throws InquiryException, InquiryImgException, Uploadexception{
		inquiryDAO.insert(inquiry);
		
			boolean flag = fileManager.save(inquiry, savePath);
			log.debug("filemanager.save result: {}", flag);
			if (flag) {
				log.debug("if문 진입");
				List<InquiryImg> imgList = inquiry.getImgList();
				for(InquiryImg inquiryImg : imgList) {
					inquiryImg.setInquiry(inquiry);
					inquiryImgDAO.insert(inquiryImg);
				}
			}
	}

	@Transactional
	@Override
	public void update(Inquiry inquiry, String savePath) throws InquiryException {
		
		//기존 레코드 삭제
		inquiryImgDAO.delete(inquiry.getInquiry_id());
		
		//폴더 안의 기존 파일 삭제
		fileManager.remove(inquiry, savePath);
		
		inquiryDAO.update(inquiry);
		
		//새로 저장 
		fileManager.save(inquiry, savePath);
		
		List<InquiryImg> imgList = inquiry.getImgList();
		for(InquiryImg inquiryImg : imgList) {
			inquiryImg.setInquiry(inquiry);
			inquiryImgDAO.insert(inquiryImg);
		}
	}
	
	@Override
	public void remove(Inquiry inquiry, String savePath) throws InquiryImgException, InquiryException {
		inquiryImgDAO.delete(inquiry.getInquiry_id());
		fileManager.remove(inquiry, savePath);
		inquiryDAO.delete(inquiry);
	}

	@Override
	public List<Inquiry> selectAllAtAdmin(Map<String, Object> searchMap) {
		return inquiryDAO.selectAllAtAdmin(searchMap);
	}

	/**
	 * 문의에 답변 달기
	 */
	@Override
	public void answerInquiry(int inquiry_id, int admin_id, String answer_text) throws InquiryException{
		// 해당 문의 조회
		Inquiry inquiry = inquiryDAO.selectById(inquiry_id);

		// 답변자 조회
		Admin admin = adminService.findById(admin_id);
		log.debug("admin 객체: {}", admin);
		log.debug("inquiry.setAdmin 전 상태: {}", inquiry);
		
		// 답변 정보 추가
		inquiry.setAdmin(admin);
		inquiry.setAnswer_text(answer_text);
		inquiry.setAnswered_at(LocalDateTime.now());
		log.debug("anwerInquiry data - {}, {}, {}", inquiry.getAdmin().getAdminId(), inquiry.getAnswer_text(), inquiry.getAnswered_at());
		
		// 데이터베이스 업데이트
		int result = inquiryDAO.updateAnswer(inquiry);
		if (result == 0) {
			throw new InquiryException("답변이 등록되지 않음");
		}
	}

	/**
	 * pk로 문의 조회
	 */
	@Override
	public Inquiry findById(int inquiry_id) throws InquiryException{
		Inquiry inquiry = inquiryDAO.selectById(inquiry_id);
		if (inquiry == null) {
			throw new InquiryException("문의가 존재하지 않습니다.");
		}
		return inquiry;
	}

	

}
