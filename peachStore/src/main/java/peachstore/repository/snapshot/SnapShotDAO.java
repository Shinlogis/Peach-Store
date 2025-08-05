package peachstore.repository.snapshot;

import java.util.List;

import peachstore.domain.SnapShot;

public interface SnapShotDAO {
	public SnapShot select(SnapShot snapShot);
	public void insertSnapshots(List<SnapShot> snapshotList);
	public List<SnapShot> selectSnapshotsByIds(List<Integer> snapshot_ids);
}
