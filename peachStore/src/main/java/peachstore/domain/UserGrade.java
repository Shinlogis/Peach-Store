package peachstore.domain;

//tinyInt는 boolean으로 매핑하면 된다고 함.
	
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 회원 등급 엔티티
 * @author 김예진 
 * @since 2025-07-28
 */
@Getter
@Setter
@NoArgsConstructor
public class UserGrade {
	private int userGradeId;

	private String userGradeName;
	
	private int criteriaAmount;

	private double discountRate;
	
	private boolean isActive;

	private List<GradeCoupon> gradeCoupons;
}
