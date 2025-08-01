package peachstore.service.review;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.Review;
import peachstore.exception.ReviewException;
import peachstore.repository.review.ReviewDAO;

/**
 * 리뷰 인터페이스
 * @author 김예진
 * @since 2025-07-31
 */
@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService{

	private final ReviewDAO reviewDAO;
	
	@Override
	public List<Review> selectAll() {
		return reviewDAO.select();
	}

	@Override
	public void deactivate(int reviewId, String status) {
		// 대상 리뷰 찾기
		Review review = new Review();
		review = findById(reviewId);
		// 상태를 숨김으로 수정
		review.setStatus("숨김");
		// 리뷰 업데이트
		reviewDAO.update(review);
	}

	@Override
	public Review findById(int reveiwId) throws ReviewException{
		Review review = reviewDAO.selectById(reveiwId);
		if (review == null) {
			throw new ReviewException("서브 카테고리 조회 실패. 존재하지 않음");
		}
		return review;
	}
	
}
