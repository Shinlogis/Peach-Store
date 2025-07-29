package peachstore.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 등급 별 쿠폰 엔티티
 * 
 * @author 김예진 
 * @since 2025-07-28
 */
@Getter
@Setter
@NoArgsConstructor
public class GradeCoupon {

    private int gradeCouponId;

    private UserGrade userGrade;

    private Coupon coupon;

    private String issueRule;
    
	private boolean isActive;
}
