package peachstore.service;

import java.util.List;

import peachstore.domain.User;

public interface UserService {
	public User selectById(String name);
	public void register(User user);
	public User select(int user_id);
	//회원로그인을 위한 메서드 2개
	public List<User> selectAll();
	public User homepageLogin(User user);
	//회원가입 메서드
	public void userJoin(User user);
}
