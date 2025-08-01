package peachstore.repository.review;

import java.util.List;

import peachstore.domain.Review;

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
}
