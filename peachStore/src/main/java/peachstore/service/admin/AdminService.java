package peachstore.service.admin;

import peachstore.domain.Admin;

/**
 * 관리자 서비스 인터페이스
 * @author 김예진
 * @since 2025-08-02
 */
public interface AdminService {
	
	/**
	 * pk를 통한 조회
	 * @param adminId
	 * @return
	 */
	public Admin findById(int adminId);
}
