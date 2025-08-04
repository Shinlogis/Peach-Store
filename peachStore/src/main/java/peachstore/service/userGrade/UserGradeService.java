package peachstore.service.userGrade;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import peachstore.domain.UserGrade;

/**
 * 사용자 등급 서비스 인터페이스
 * @author 김예진
 * @since 2025-07-30
 */
public interface UserGradeService {

	/**
	 * 등급 전체 조회
	 * 
	 * @return
	 */
	public List<UserGrade> findAll();
	
	/**
	 * 등급 등록
	 * @param userGradeName 등급명
	 * @param discountRate 할인율
	 * @param criteriaAmount 누적구매기준
	 */
	public void register(String userGradeName, BigDecimal discountRate, int criteriaAmount); 
	
	/**
	 * 등급 수정
	 * @param userGradeName
	 * @param criteriaAmount
	 * @param discountRate
	 * @param userGradeId
	 */
	public void update(String userGradeName, int criteriaAmount, BigDecimal discountRate, int userGradeId);
	
	/**
	 * 등급 상태 변경
	 * @param userGradeId
	 */
	public void toggleActivation(int userGradeId);
	
	/**
	 * 등급 삭제
	 * @param subcategoryId
	 */
	public void delete(int userGradeId);
	
	/**
	 * 해당 사용자의 등급 갱신 여부 계산
	 * @param userId
	 */
	public void calUserGrade(int userId);
}
