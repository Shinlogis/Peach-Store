package peachstore.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.User;
import peachstore.exception.UserException;

@Repository
public class UserDAOImpl implements UserDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public User selectByName(String name) {
		User user = (User)sqlSessionTemplate.selectOne("User.selectByName", name);
		
		return user;
	}
	
	@Override
	public void insert(User user) throws UserException {
		int result = sqlSessionTemplate.insert("User.snsInsert", user);
		if(result <1) {
			throw new UserException("회원 등록 실패");
		}

	}
	@Override
	public User select(int user_id) {
		return sqlSessionTemplate.selectOne("User.select", user_id);
	}
	
	//회원 로그인을 위한 메서드 2개
	@Override
	public List<User> selectAll() {
		return sqlSessionTemplate.selectList("User.selectAll");
	}
	@Override
	public User homepageLogin(User user) {
		return sqlSessionTemplate.selectOne("User.homepageLogin", user);
	}
	//회원가입을 위한 메서드
	@Override
	public void userJoin(User user) {
		int result = sqlSessionTemplate.insert("User.userJoin", user);
		if(result<1) {
			throw new UserException("회원가입 정보가 올바르지 않습니다.");
		}

	}
}
