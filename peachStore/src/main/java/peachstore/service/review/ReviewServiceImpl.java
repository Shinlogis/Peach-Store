package peachstore.service.review;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Review;
import peachstore.domain.ReviewImg;
import peachstore.domain.User;
import peachstore.exception.ReviewException;
import peachstore.exception.ReviewImgException;
import peachstore.repository.review.ReviewDAO;
import peachstore.repository.review.ReviewImgDAO;
import peachstore.util.FileCommonManager;

/**
 * 리뷰 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-31
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	private final ReviewDAO reviewDAO;
	private final ReviewImgDAO reviewImgDAO;
	private final FileCommonManager fileCommonManager;

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
	public Review findById(int reveiwId) throws ReviewException {
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

	// 리뷰 등록
	@Transactional
	@Override
	public void regist(Review review, String savePath) throws ReviewException {
		reviewDAO.insert(review);

		// 디렉토리 생성
		String subDir = "r_" + review.getReviewId();

		// 이미지 저장
		List<String> savedFilenames = fileCommonManager.saveFiles(review.getPhoto(), savePath, subDir);

		List<ReviewImg> imgList = new ArrayList<>();
		for (String filename : savedFilenames) {
			ReviewImg reviewImg = new ReviewImg();

			reviewImg.setReview(review);
			reviewImg.setFilename(filename);
			reviewImgDAO.insert(reviewImg);

			imgList.add(reviewImg);
		}

		review.setImgList(imgList);
	}

	// 삭제(사진까지 같이 삭제)
	public void remove(Review review, String savePath) throws ReviewImgException {
		String subDir = "r_" + review.getReviewId();

		log.debug("리뷰 삭제할 아이디 " + review.getReviewId());
		reviewImgDAO.delete(review.getReviewId());
		fileCommonManager.remove(subDir, savePath);
		
		review = findById(review.getReviewId());
		// 상태를 수정
		review.setStatus((review.getStatus().equals("활성")) ? "숨김" : "활성");

		
		// 리뷰 업데이트
		reviewDAO.update(review);
	}

	// 회원별 리뷰 조회
	@Override
	public List selectByUserId(User user) {
		log.debug("매개변수 유저 - {}", user.getUser_id());
		List<Review> list = reviewDAO.selectByUserId(user);

		return list;
	}
	
	
	//리뷰 수정
	@Transactional
	@Override
	public void updateReview(Review review, String savePath) {

		// 기존 이미지 레코드 삭제
		reviewImgDAO.delete(review.getReviewId());

		// 폴더 안의 기존 파일 삭제
		String subDir = "r_" + review.getReviewId();
		fileCommonManager.remove(subDir, savePath);

		// 리뷰 내용 수정
		reviewDAO.updateReview(review);

		// 새로 저장
		List<String> savedFilenames = fileCommonManager.saveFiles(review.getPhoto(), savePath, subDir);

		List<ReviewImg> imgList = new ArrayList<>();
		for (String filename : savedFilenames) {
			ReviewImg reviewImg = new ReviewImg();

			reviewImg.setReview(review);
			reviewImg.setFilename(filename);
			reviewImgDAO.insert(reviewImg);

			imgList.add(reviewImg);
		}

		review.setImgList(imgList);
	}

}
