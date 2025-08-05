package peachstore.service.snapshot;

import java.util.List;
import java.util.stream.Collectors;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.SnapShot;
import peachstore.repository.snapshot.SnapShotDAO;
@Slf4j
@Service
public class SnapShotServiceImpl implements SnapShotService {

	@Autowired
	private SnapShotDAO snapShotDAO;

	@Override
	public SnapShot select(SnapShot snapShot) {
		return snapShotDAO.select(snapShot);
	}

	@Override
	public void insertSnapshots(List<SnapShot> snapshotList) {
		snapShotDAO.insertSnapshots(snapshotList);

	}

	@Override
	public List<SnapShot> getInsertedSnapshots(List<SnapShot> snapshotList) {
        List<Integer> ids = snapshotList.stream()
                .map(SnapShot::getSnapshot_id)
                .collect(Collectors.toList());
        	log.debug("서비스 들어온값 : {}", ids);
            return snapShotDAO.selectSnapshotsByIds(ids);
	}

}
