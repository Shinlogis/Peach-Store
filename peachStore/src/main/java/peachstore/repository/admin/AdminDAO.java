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
	
	  /**
     * ID로 관리자 정보 조회 (로그인용)
     * @param id
     * @return
     */
    public Admin selectByLogin(String id);

    /**
     * 로그인 시 해시 검증 포함 처리
     * @param id
     * @param password
     * @return
     */
    public Admin login(String id, String password); 
}
