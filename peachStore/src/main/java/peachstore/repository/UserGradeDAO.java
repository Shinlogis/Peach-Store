package peachstore.repository;

import java.util.List;

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
	public List<UserGrade> findAll();
	
	/**
	 * 등급 등록 또는 수정
	 */
	public void save(UserGrade userGrade);
	
	/**
	 * 등급 비활성화
	 */
	public void deactivate(UserGrade userGrade);
	
	/**
	 * 등급 id로 등급 조회
	 * @param userId
	 * @return
	 */
	public UserGrade findById(int userGradeId);
}
