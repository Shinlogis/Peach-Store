package peachstore.service.review;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.Review;
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
	
}
