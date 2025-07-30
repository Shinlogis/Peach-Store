package peachstore.repository.coupon;

import java.util.List;

import peachstore.domain.Coupon;

/**
 * 쿠폰 DAO 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-28
 */
public interface CouponDAO {
	/**
	 * 모든 쿠폰 목록 조회
	 * @return
	 */
	public List<Coupon> findAll();
}
