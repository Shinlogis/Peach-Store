package peachstore.repository.snapshot;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.SnapShot;

@Repository
@Slf4j
public class SnapShotDAOImpl implements SnapShotDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public SnapShot select(SnapShot snapShot) {
		return sqlSessionTemplate.selectOne("SnapShot.select", snapShot);
	}

	@Override
	public void insertSnapshots(List<SnapShot> snapshotList) {
        sqlSessionTemplate.insert("SnapShot.insertSnapshots", snapshotList);
	}
	
	@Override
	public List<SnapShot> selectSnapshotsByIds(List<Integer> ids) {
		log.debug("들어온 값 : {}", ids );
		return sqlSessionTemplate.selectList("SnapShot.selectSnapshotsByIds", ids);
	}
	
}
