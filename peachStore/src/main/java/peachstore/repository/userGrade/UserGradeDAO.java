package peachstore.repository.userGrade;


import java.util.List;
import java.util.Map;

import peachstore.domain.UserGrade;

/**
 * 사용자 등급 DAO 인터페이스
 * 
 * @author 김예진
 * @since 2025-07-28
 */
public interface UserGradeDAO {
	/**
	 * 모든 사용자 등급 목록 조회
	 * @return
	 */
	public List<UserGrade> selectAll();
	
	/**
	 * 등급 등록
	 */
	public int insert(UserGrade userGrade);
	
	/**
	 * 등급 수정
	 */
	public int update(UserGrade userGrade);
	
	/**
	 * 등급 id로 등급 조회
	 * @param userGradeId
	 * @return
	 */
	public UserGrade findById(int userGradeId);
	
	/**
	 * 등급 삭제
	 * @param userGradeId
	 * @return
	 */
	public int delete(int userGradeId);
	
	/**
	 * 금액 조건이 높은 등급 순으로 불러오기
	 * @return
	 */
	public List<UserGrade> gradeSelectByAmount();

	/**
	 * userId 사용자의 총 구매 금액
	 * @return
	 */
	public Long selectTotalAmountByUserId(int userId);
}
