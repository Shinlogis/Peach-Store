package peachstore.service.snapshot;

import java.util.List;

import peachstore.domain.SnapShot;

public interface SnapShotService {
	public SnapShot select(SnapShot snapShot);
	public void insertSnapshots(List<SnapShot> snapshotList);
	public List<SnapShot> getInsertedSnapshots(List<SnapShot> snapshotList);

}
