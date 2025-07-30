package peachstore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.User;
import peachstore.repository.UserDAO;

@Repository
public class UserServiceImpl implements UserService{

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
	@Override
	public User login(User user) {
		return userDAO.login(user);
	}
	
}
