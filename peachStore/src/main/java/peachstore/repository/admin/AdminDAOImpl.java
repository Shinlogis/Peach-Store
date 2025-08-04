package peachstore.repository.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.util.PasswordUtil;

/**
 * 관리자 dao 구현체입니다.
 * @author 김예진
 * @since 2025-08-02
 */
@Repository
@RequiredArgsConstructor
@Slf4j
public class AdminDAOImpl implements AdminDAO{

	private final SqlSessionTemplate sqlSessionTemplate;

	@Override
	public Admin selectById(int adminId) {
		Admin admin = sqlSessionTemplate.selectOne("Admin.selectById", adminId);
		log.debug("selectById result - {}", admin);
		return admin;
	}
	
	
	 @Override
	    public Admin selectByLogin(String id) {
	        Admin admin = sqlSessionTemplate.selectOne("Admin.selectByLogin", id);
	        log.debug("selectByLogin result - {}", admin);
	        return admin;
	    }

	    @Override
	    public Admin login(String id, String password) {
	        Admin admin = selectByLogin(id); // DAO 내 메서드 호출
	        if (admin != null) {
	            try {
	                String hashed = PasswordUtil.hashPassword(password, admin.getEmail()); // email을 salt로
	                if (hashed.equals(admin.getPassword())) {
	                    return admin;
	                } else {
	                    log.warn("비밀번호 불일치: 입력값={}, 기대값={}", hashed, admin.getPassword());
	                }
	            } catch (Exception e) {
	                log.error("비밀번호 암호화 실패", e);
	            }
	        }
	        return null;
	    }
	
	
}
