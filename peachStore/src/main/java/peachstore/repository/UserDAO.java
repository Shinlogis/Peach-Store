package peachstore.repository;

import java.util.List;

import peachstore.domain.User;

public interface UserDAO {

	public User selectByName(String name);
	public void insert(User user);
	
	//임시입니다 나중에 구현되면 지울거에요
	public User select(int user_id);
	
	public List<User> selectAll();
	public User homepageLogin(User user);
}
