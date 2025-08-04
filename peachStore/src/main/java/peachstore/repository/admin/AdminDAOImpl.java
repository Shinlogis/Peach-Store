package peachstore.repository.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;

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
	
}
