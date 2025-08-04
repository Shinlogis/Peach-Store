package peachstore.repository.user;

import java.util.List;

import peachstore.domain.User;

public interface UserDAO {

	public User selectById(String id);
	public void insert(User user);
	public List<User> selectAll();
	public User homepageLogin(User user);
	//회원가입을 위한 메서드
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
	public int update(User user);
}
