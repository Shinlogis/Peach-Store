package peachstore.repository.review;

import java.util.List;

import peachstore.domain.Review;
import peachstore.domain.User;

/**
 * 리뷰 DAO입니다.
 * @author 김예진
 * @since 2025-07-31
 */
public interface ReviewDAO {
	/**
	 * 리뷰 조회
	 * @return
	 */
	public List<Review> select();
	
	/**
	 * 리뷰 수정
	 */
	public int update(Review review); 
	
	/**
	 * pk로 리뷰 조회
	 * @param reveiwId
	 * @return
	 */
	public Review selectById(int reveiwId);
	
	/**
	 * 리뷰 삭제
	 * @param reviewId
	 * @return
	 */
	public int delete(int reviewId);
	
	//리뷰 등록
	public void insert(Review reivew);
	
	//회원별 리뷰 조회
	public List selectByUserId(User user);
	
	//리뷰 내용 수정
	public void updateReview(Review review);
	
	//리뷰 갯수 조회
	public int countByUserId(int userId);

}
