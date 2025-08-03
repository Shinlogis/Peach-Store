package peachstore.service.review;

import java.util.List;

import peachstore.domain.Review;
import peachstore.domain.User;

/**
 * 리뷰 서비스 인터페이스
 * @author 김예진
 * @since 2025-07-31
 */
public interface ReviewService {
	
	/**
	 * 전체 리뷰 조회
	 * @return
	 */
	public List<Review> selectAll();
	
	/**
	 * 리뷰 숨김 처리
	 * @param reviewId 대상 리뷰 id
	 * @param status 변경할 상태
	 */
	public void deactivate(int reviewId);
	
	/**
	 * pk로 리뷰 찾기
	 * @param reveiwId 대상 리뷰 id
	 * @return
	 */
	public Review findById(int reveiwId);
	
	/**
	 * 리뷰 삭제
	 * @param reviewId
	 * @return
	 */
	public void delete(int reviewId);
	public void regist(Review review, String savePath);
	
	public void remove(Review review, String savePath);
	
	public List selectByUserId(User user);
	
	public List selectByProductId(int productId);
}
