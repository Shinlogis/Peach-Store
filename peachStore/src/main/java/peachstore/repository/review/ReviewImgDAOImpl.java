package peachstore.repository.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.ReviewImg;
import peachstore.exception.ReviewImgException;
import peachstore.exception.Uploadexception;

@Repository
public class ReviewImgDAOImpl implements ReviewImgDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(ReviewImg reviewImg) throws Uploadexception {
		int result =sqlSessionTemplate.insert("ReviewImg.insert", reviewImg);
		
		if(result<1) {
			throw new Uploadexception("사진 등록 실패");
		}
	}

	@Override
	public void delete(int reviewId) throws ReviewImgException{
		int result = sqlSessionTemplate.delete("ReviewImg.delete", reviewId);
		
		if(result<1) {
			throw new ReviewImgException("사진 삭제 실패");
		}
	}

	@Override
	public List select(int review_id) {
		return sqlSessionTemplate.selectList("ReviewImg.selectByReviewId", review_id);
	}

}
