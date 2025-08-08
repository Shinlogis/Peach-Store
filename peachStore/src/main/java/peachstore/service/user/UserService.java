package peachstore.service.user;

import java.util.List;

import peachstore.domain.User;
import peachstore.domain.UserGrade;

public interface UserService {
	public User selectById(String user);
	public void register(User user);
	//회원로그인을 위한 메서드 2개
	public List<User> selectAll();
	public User homepageLogin(User user);
	//회원가입 메서드
	public void userJoin(User user);
	public List<User> selectAllJoin();
	
	/**
	 * pk로 유저 조회
	 * @param userId
	 * @return
	 */
	public User selectByUserId(int userId);
	
	/**
	 * 사용자 업데이트
	 * @param user
	 * @return
	 */
	public void update(User user);
	
	public void updateIsActive(int userId, boolean isActive);
	
	public List<User> getAllUsersJoinV2();
}
