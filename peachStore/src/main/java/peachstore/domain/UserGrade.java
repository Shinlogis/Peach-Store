package peachstore.domain;

<<<<<<< HEAD
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
=======
import java.util.List;
>>>>>>> 2362fca (상위 카테고리에 해당하는 하위 카테고리 조회 기능 구현)

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
	
<<<<<<< HEAD
>>>>>>> 4d436b5 (추적 제거 및 스테이지편집 후 커밋)
=======
	private int criteriaAmount;

	private double discountRate;
	
	private boolean isActive;

	private List<GradeCoupon> gradeCoupons;
>>>>>>> 2362fca (상위 카테고리에 해당하는 하위 카테고리 조회 기능 구현)
}
