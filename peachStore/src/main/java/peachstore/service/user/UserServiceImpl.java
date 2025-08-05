package peachstore.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.domain.UserGrade;
import peachstore.exception.UserException;
import peachstore.repository.user.UserDAO;
import peachstore.util.PasswordUtil;

@Service
@Slf4j
public class UserServiceImpl implements UserService {

	@Autowired
	private PasswordUtil passwordUtil;
	
	@Autowired
	private UserDAO userDAO;

	@Override
	public User selectById(String user) {
		return userDAO.selectById(user);
	}

	@Override
	public void register(User user) {
		userDAO.insert(user);
	}

	// 회원 로그인을 위한 메서드 두개
	@Override
	public List<User> selectAll() {
		return userDAO.selectAll();
	}

	@Override
	public User homepageLogin(User user) throws UserException{
		User obj = userDAO.selectById(user.getId());
		
		String dbHash = passwordUtil.hashPassword(user.getHashedpassword(), obj.getSalt());
		if(dbHash.equals(obj.getHashedpassword())==false) {
			throw new UserException("로그인 정보가 올바르지 않습니다");
		}
		return obj;
	}

	// 회원가입을 위한 메서드
	@Override
	public void userJoin(User user) {
		log.debug("넘어온 회원가입 id는 : " + user.getUser_id());
		//홈페이지 회원인 경우
		if(user.getSns_provider()==null) {
			String salt = passwordUtil.generateSalt();
			String hashedPassword = passwordUtil.hashPassword(user.getHashedpassword(), salt);
			user.setSalt(salt);
			user.setHashedpassword(hashedPassword);
		}
		
		userDAO.userJoin(user);
		// insert query
	}

	// 회원가입을 위한 메서드
	@Override
	public List<User> selectAllJoin() {
		return userDAO.selectAllJoin();
	}

	/**
	 * pk로 유저 조회
	 */
	@Override
	public User selectByUserId(int userId) {
		return userDAO.selectByUserId(userId);
	}

	@Override
	public void update(User user) throws UserException{
		 int result = userDAO.update(user);
		 if (result == 0) {
			 throw new UserException("업데이트 실패");
		 }
	}
	
	public void updateIsActive(int userId, boolean isActive) {
        userDAO.updateIsActive(userId, isActive);
    }
	
	@Override
	public List<User> getAllUsersJoinV2() {
		return userDAO.selectAllJoinV2();
	}

}
