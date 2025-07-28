package peachstore.domain;

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
	
}
