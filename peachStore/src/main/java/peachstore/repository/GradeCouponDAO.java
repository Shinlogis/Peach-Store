package peachstore.repository;

import java.util.List;

import peachstore.domain.GradeCoupon;

/**
 * 등급 별 쿠폰 DAO 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-28
 */
public interface GradeCouponDAO {
	/**
	 * 모든 등급 별 쿠폰 목록 조회
	 * @return
	 */
	public List<GradeCoupon> selectAll();
	
	
}
