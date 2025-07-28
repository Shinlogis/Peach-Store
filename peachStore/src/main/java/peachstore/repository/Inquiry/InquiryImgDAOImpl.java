package peachstore.repository.Inquiry;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.InquiryImg;
import peachstore.exception.InquiryImgException;
import peachstore.exception.Uploadexception;
/**
 * 문의사진 dao
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Repository
public class InquiryImgDAOImpl implements InquiryImgDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(InquiryImg inquiryImg) throws InquiryImgException {
		int result = sqlSessionTemplate.insert("InquiryImg.insert", inquiryImg);
		log.debug("inquiry_img insert result: " + result); 

		if(result<1)throw new InquiryImgException("사진 등록 실페");
	}

}
