package peachstore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.repository.UserDAO;

@Service
@Slf4j
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
	
	//회원가입을 위한 메서드
	@Override
	public void userJoin(User user) {
		log.debug("넘어온 회원가입 id는 : "+ user.getUser_id());
		log.debug("넘어온 회원가입 비밀번호는 : " + user.getPassword());
		userDAO.userJoin(user);
		//insert query
	}
}
