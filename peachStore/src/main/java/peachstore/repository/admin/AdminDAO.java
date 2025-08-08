package peachstore.repository.admin;

import java.util.List;
import java.util.Map;

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
	public int insertAdmin(Admin admin);
	public Admin selectAdminByLogin(Map<String, Object> map); // email 기반
	public List<Admin> selectAll();
	public int updatePassword(Map<String, Object> map);
	public int updateIsActive(Map<String, Object> map);
	public int updateAdminInfo(Admin admin);
	public Admin selectAdminByEmail(String email);
}
