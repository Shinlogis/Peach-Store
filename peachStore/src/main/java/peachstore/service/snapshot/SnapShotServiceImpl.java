package peachstore.service.snapshot;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.SnapShot;
import peachstore.repository.snapshot.SnapShotDAO;

@Service
public class SnapShotServiceImpl implements SnapShotService {
	
	@Autowired
	private SnapShotDAO snapShotDAO;

	@Override
	public SnapShot select(SnapShot snapShot) {
		return snapShotDAO.select(snapShot);
	}

}
