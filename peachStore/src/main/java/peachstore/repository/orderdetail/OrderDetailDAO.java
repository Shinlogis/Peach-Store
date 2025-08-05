package peachstore.repository.orderdetail;

import java.util.List;
import java.util.Map;

public interface OrderDetailDAO {

	public List selecByReceitId(int order_receipt_id);
	
	/**
	 * 등록
	 * @param param
	 * @return
	 */
	public int insert(Map<String, Object> param);
}
