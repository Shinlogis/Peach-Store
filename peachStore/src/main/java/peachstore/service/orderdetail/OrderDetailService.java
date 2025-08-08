package peachstore.service.orderdetail;

import java.util.List;

public interface OrderDetailService {

	public List selecByReceitId(int order_receipt_id);
	
	/**
	 * 등록 서비스
	 * @param orderReceiptId
	 * @param snapshotId
	 */
	public int insert(int orderReceiptId, int snapshotId);
	
}
