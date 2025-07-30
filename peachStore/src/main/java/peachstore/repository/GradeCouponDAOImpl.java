package peachstore.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.GradeCoupon;

/**
 * 등급 별 쿠폰 DAO 구현체
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class GradeCouponDAOImpl implements GradeCouponDAO {

	private final SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<GradeCoupon> selectAll() {
		List<GradeCoupon> list = sqlSessionTemplate.selectList("peachstore.repository.GradeCouponDAO.selectAll");
		log.debug("selectAll - result: {}", list);

		return list;
	}

}
