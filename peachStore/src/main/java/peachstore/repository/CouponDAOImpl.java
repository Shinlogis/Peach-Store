package peachstore.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Coupon;

/**
 * 쿠폰 DAO 구현체
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class CouponDAOImpl implements CouponDAO {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<Coupon> findAll() {
		List<Coupon> list = sqlSessionTemplate.selectList("peachstore.repository.CouponDAO.selectAll");
	    log.debug("selectAll - result: {}, resultCount: {}", list, list.size());
	    return list;
	}

}
