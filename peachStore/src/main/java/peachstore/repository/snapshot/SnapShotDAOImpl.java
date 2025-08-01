package peachstore.repository.snapshot;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.SnapShot;

@Repository
public class SnapShotDAOImpl implements SnapShotDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public SnapShot select(SnapShot snapShot) {
		
		return sqlSessionTemplate.selectOne("SnapShot.select", snapShot);
	}

}
