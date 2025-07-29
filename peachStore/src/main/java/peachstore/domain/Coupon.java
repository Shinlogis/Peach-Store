package peachstore.domain;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 쿠폰 엔티티
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Getter
@Setter
@NoArgsConstructor
public class Coupon {
	private int couponId;

	private String couponName;

	private int discountAmount;

	private int validDays;

	private String useCondition;
	
	private boolean isActive;

	private List<GradeCoupon> gradeCoupons;
}
