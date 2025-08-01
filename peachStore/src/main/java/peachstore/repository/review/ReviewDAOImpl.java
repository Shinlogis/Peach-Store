package peachstore.repository.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Review;

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
		Review result = sqlSessionTemplate.selectOne("Review.selectByid", reveiwId);
		log.debug("select - result: {}", result);
		return result;
	}

}
