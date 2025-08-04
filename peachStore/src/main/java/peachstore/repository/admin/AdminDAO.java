package peachstore.repository.admin;

import peachstore.domain.Admin;

/**
 * 관리자 dao 인터페이스입니다.
 *  @author 김예진
 * @since 2025-08-02
 */
public interface AdminDAO {
	/**
	 * pk로 조회
	 * @param adminId
	 * @return
	 */
	public Admin selectById(int adminId);
}
