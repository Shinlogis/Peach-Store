package peachstore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.User;
import peachstore.repository.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	@Override
	public User selectById(String name) {
		return userDAO.selectByName(name);
	}

	@Override
	public void register(User user) {
		userDAO.insert(user);
	}

	@Override
	public User select(int user_id) {
		return userDAO.select(user_id);
	}
	
	//회원 로그인을 위한 메서드 두개
	@Override
	public List<User> selectAll() {
		return userDAO.selectAll();
	}
	
	@Override
	public User homepageLogin(User user) {
		User obj = userDAO.homepageLogin(user);
		return obj;
	}
	
}
