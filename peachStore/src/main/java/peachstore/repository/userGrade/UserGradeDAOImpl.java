package peachstore.repository.userGrade;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.UserGrade;

/**
 * 사용자 등급 마이바티스 DAO 구현체입니다
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Repository
@Slf4j
@RequiredArgsConstructor
public class UserGradeDAOImpl implements UserGradeDAO{

    private final SqlSessionTemplate sqlSessionTemplate;
	
    @Override
    public List<UserGrade> selectAll() {
        List<UserGrade> list = sqlSessionTemplate.selectList("UserGrade.selectAll");
        log.debug("findAll - listCount: {}", list.size());
        return list;
    }

	@Override
	public int insert(UserGrade userGrade) {
		int result = sqlSessionTemplate.insert("UserGrade.insert", userGrade);
		return result;
	}

	@Override
	public int update(UserGrade userGrade) {
		int result = sqlSessionTemplate.update("UserGrade.update", userGrade);
		return result;
	}

	@Override
	public UserGrade findById(int userGradeId) {
		UserGrade result = sqlSessionTemplate.selectOne("UserGrade.selectById", userGradeId);
		return result;
	}

	@Override
	public int delete(int userGradeId) {
		int result = sqlSessionTemplate.delete("UserGrade.delete", userGradeId);
		log.info("delete id={}", userGradeId);
		return result;
	}

	@Override
	public List<UserGrade> gradeSelectByAmount() {
		List<UserGrade> list = sqlSessionTemplate.selectList("UserGrade.gradeSelectByAmount");
        log.debug("gradeSelectByAmount - listCount: {}", list.size());
        return list;
	}

	@Override
	public Long selectTotalAmountByUserId(int userId) {
		 log.debug("selectTotalAmountByUser 진입");
		Long result = sqlSessionTemplate.selectOne("UserGrade.selectTotalAmountByUser", userId);
        log.debug("selectTotalAmountByUser - result: {}", result);
        return result;
	}
	

}
