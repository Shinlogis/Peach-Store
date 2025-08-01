package peachstore.service.review;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Review;
import peachstore.exception.ReviewException;
import peachstore.repository.review.ReviewDAO;

/**
 * 리뷰 인터페이스
 * @author 김예진
 * @since 2025-07-31
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService{

	private final ReviewDAO reviewDAO;
	
	@Override
	public List<Review> selectAll() {
		return reviewDAO.select();
	}

	@Override
	public void deactivate(int reviewId) {
		System.out.println("deactive접근 " + reviewId);
		// 대상 리뷰 찾기
		Review review = new Review();
		review = findById(reviewId);
		// 상태를 수정
		review.setStatus((review.getStatus().equals("활성")) ? "숨김" : "활성");
		// 리뷰 업데이트
		reviewDAO.update(review);
	}

	@Override
	public Review findById(int reveiwId) throws ReviewException{
		Review review = reviewDAO.selectById(reveiwId);
		if (review == null) {
			throw new ReviewException("조회 실패. 존재하지 않음");
		}
		return review;
	}

	@Override
	public void delete(int reviewId) {
		int result = reviewDAO.delete(reviewId);
		if (result == 0) {
			throw new ReviewException("삭제 실패");
		}
	}
	
}
