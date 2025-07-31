package peachstore.repository.Inquiry;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.exception.InquiryException;

/**
 * 문의하기 dao
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Repository
public class InquiryDAOImpl implements InquiryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll(Inquiry inquiry) {
		return sqlSessionTemplate.selectList("Inquiry.selectAll", inquiry);
	}

	@Override
	public Inquiry select(Inquiry inquiry) {
		return sqlSessionTemplate.selectOne("Inquiry.select", inquiry);
	}

	@Override
	public void insert(Inquiry inquiry) throws InquiryException {
		int result = sqlSessionTemplate.insert("Inquiry.insert", inquiry);
		 log.debug("Inserted inquiry_id: " + inquiry.getInquiry_id());
		
		if(result <1) {
			throw new InquiryException("문의 등록 실패");
		}
	}

	@Override
	public void update(Inquiry inquiry) throws InquiryException {
		int result = sqlSessionTemplate.update("Inquiry.update", inquiry);
		
		if(result<1) {
			throw new InquiryException("문의 수정 실패");
		}
	}

	@Override
	public void delete(Inquiry inquiry) throws InquiryException{
		int result = sqlSessionTemplate.delete("Inquiry.delete", inquiry);
		
		if(result<1) {
			throw new InquiryException("문의 삭제 실패");
		}
	}

}
