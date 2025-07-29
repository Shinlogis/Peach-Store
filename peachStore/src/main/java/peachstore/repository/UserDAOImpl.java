package peachstore.repository;

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
		int result = sqlSessionTemplate.insert("User.insert", user);
		if(result <1) {
			throw new UserException("회원 등록 실패");
		}

		
	}
	@Override
	public User select(int user_id) {
		return sqlSessionTemplate.selectOne("User.select", user_id);
	}
}
