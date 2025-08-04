package peachstore.repository.user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.User;
import peachstore.domain.UserGrade;
import peachstore.exception.UserException;

@Slf4j
@Repository
public class UserDAOImpl implements UserDAO{

    private final PlatformTransactionManager platformTransactionManager;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

    UserDAOImpl(PlatformTransactionManager platformTransactionManager) {
        this.platformTransactionManager = platformTransactionManager;
    }
	
	@Override
	public User selectById(String id) {
		
		return sqlSessionTemplate.selectOne("User.selectById", id);
	}
	
	@Override
	public void insert(User user) throws UserException {
		int result = sqlSessionTemplate.insert("User.snsInsert", user);
		if(result <1) {
			throw new UserException("회원 등록 실패");
		}

	}
	
	//회원 로그인을 위한 메서드 2개
	@Override
	public List<User> selectAll() {
		return sqlSessionTemplate.selectList("User.selectAll");
	}
	
	@Override
	public User homepageLogin(User user) throws UserException{
		User obj = sqlSessionTemplate.selectOne("User.homepageLogin", user);
		if (obj==null) {
			throw new UserException("로그인 정보가 올바르지 않습니다.");
		}
		return obj;
	}
	
	//회원가입을 위한 메서드
	@Override
	public void userJoin(User user) {
		int result = sqlSessionTemplate.insert("User.userJoin", user);
		if(result<1) {
			throw new UserException("회원가입 정보가 올바르지 않습니다.");
		}

	}
	
	@Override
	public List<User> selectAllJoin() {
		return sqlSessionTemplate.selectList("User.selectAllJoin");
	}

	@Override
	public User selectByUserId(int userId) {
		log.debug("selectByUserId - userId: {}", userId);
		return sqlSessionTemplate.selectOne("User.selectByUserId", userId);
	}

	@Override
	public int update(User user) {
		return sqlSessionTemplate.update("User.update", user);
	}
}
