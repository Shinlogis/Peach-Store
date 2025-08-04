package peachstore.repository.review;

import java.util.List;

import peachstore.domain.ReviewImg;

public interface ReviewImgDAO {

	public void insert(ReviewImg reviewImg);
	
	public void delete(int reviewId);
	
	public List select(int review_id);
}
