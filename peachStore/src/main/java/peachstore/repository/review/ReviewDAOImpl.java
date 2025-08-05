package peachstore.repository.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Review;
import peachstore.domain.User;
import peachstore.exception.ReviewException;

/**
 * 리뷰 DAO 구현체
 * @author 김예진
 * @since 2025-07-31
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class ReviewDAOImpl implements ReviewDAO{

	private final SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<Review> select() {
		List<Review> list = sqlSessionTemplate.selectList("Review.selectAll");
		log.debug("select - count: {}", list.size());
		return list;
	}

	@Override
	public int update(Review review) {
		int result = sqlSessionTemplate.update("Review.update", review);
		log.debug("update - count: {}", result);
		return result;
	}

	@Override
	public Review selectById(int reveiwId) {
		Review result = sqlSessionTemplate.selectOne("Review.selectById", reveiwId);
		log.debug("result: {}", result);
		return result;
	}

	@Override
	public int delete(int reviewId) {
		int result = sqlSessionTemplate.delete("Review.delete", reviewId);
		log.debug("result: {}", result);
		return result;
	}
<<<<<<< HEAD
=======
		
>>>>>>> 4d419da10bb80d1411b1bfa703ec5c897ba9e227
	public void insert(Review review) throws ReviewException{
		int result = sqlSessionTemplate.insert("Review.insert", review);
		
		if(result<1) {
			throw new ReviewException("리뷰 등록 실패");
		}
	}

	//회원별 리뷰 조회
	@Override
	public List selectByUserId(User user) {
		return sqlSessionTemplate.selectList("Review.selectByUser",user);
	}

	@Override
	public List selectByProductId(int productId) {
		return  sqlSessionTemplate.selectList("Review.selectByProductId",productId);
	}

	//리뷰 수정
	@Override
	public void updateReview(Review review)throws ReviewException {
		int result = sqlSessionTemplate.update("Review.updateReview", review);
		if(result <1) {
			throw new ReviewException("리뷰 수정 실패");
		}
	}
<<<<<<< HEAD
=======

	//리뷰 갯수 조회
	@Override
	public int countByUserId(int userId) {
		return sqlSessionTemplate.selectOne("Review.countByUserId", userId);
	}
	
	
	


		
	
	

	
	
	
>>>>>>> 4d419da10bb80d1411b1bfa703ec5c897ba9e227
}
