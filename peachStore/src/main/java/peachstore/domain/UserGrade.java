package peachstore.domain;

<<<<<<< HEAD
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
=======
import java.math.BigDecimal;

import lombok.Data;

@Data
public class UserGrade {
	private int user_grade_id;
	private String user_grade_name;
	private BigDecimal discount_rate;
	private int criteria_amount;
	//tinyInt는 boolean으로 매핑하면 된다고 함.
	private boolean isActive;
	
>>>>>>> 4d436b5 (추적 제거 및 스테이지편집 후 커밋)
}
