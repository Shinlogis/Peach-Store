package peachstore.repository.userGrade;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.ProductTopcategory;
import peachstore.domain.UserGrade;
import peachstore.repository.gradeCoupon.UserGradeDAO;

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
	public List<UserGrade> findAll() {
		List<ProductTopcategory> list = sqlSessionTemplate.selectList("", log);
		return null;
		
	}

	@Override
	public void save(UserGrade userGrade) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deactivate(UserGrade userGrade) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public UserGrade findById(int userGradeId) {
		// TODO Auto-generated method stub
		return null;
	}

}
