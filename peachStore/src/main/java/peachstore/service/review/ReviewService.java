package peachstore.service.review;

import java.util.List;

import peachstore.domain.Review;

/**
 * 리뷰 인터페이스
 * @author 김예진
 * @since 2025-07-31
 */
public interface ReviewService {
	
	/**
	 * 전체 리뷰 조회
	 * @return
	 */
	public List<Review> selectAll();
}
