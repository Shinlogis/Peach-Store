package peachstore.service.gradeCoupon;

import java.util.List;

import peachstore.domain.GradeCoupon;

/**
 * 등급 별 쿠폰 서비스 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-28
 */
public interface GradeCouponService {
	/**
	 * 모든 등급 별 쿠폰 목록 조회
	 * @return
	 */
	public List<GradeCoupon> selectAll();
	
}
