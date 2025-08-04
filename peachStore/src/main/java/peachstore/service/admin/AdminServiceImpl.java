package peachstore.service.admin;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.exception.AdminException;
import peachstore.repository.admin.AdminDAO;

/**
 * 관리자 서비스 구현체
 * @author 김예진
 * @since 2025-08-02
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService{
	
	private final AdminDAO adminDAO;
	
	@Override
	public Admin findById(int adminId) throws AdminException{
		Admin admin = adminDAO.selectById(adminId);
		log.debug("findById result - {}", admin);
		if (admin == null) {
			throw new AdminException("관리자가 존재하지 않음");
		}
		return admin;
	}

}
