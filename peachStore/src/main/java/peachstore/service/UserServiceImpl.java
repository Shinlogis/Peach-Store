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
	public User select(int user_id) {
		return userDAO.select(user_id);
	}
}
