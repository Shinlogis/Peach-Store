package peachstore.service.statistics;

import java.util.List;
import java.util.Map;

/**
 * 통계모음 서비스
 * @author 김예진
 * @since 2025-08-05
 */
public interface StatisticsService {
	
	/**
	 * 오늘 매출
	 * @return
	 */
	public int todayAmount();
	
	/**
	 * 오늘 주문 건 수
	 * @return
	 */
	public int todayReceiptCount();
	
	/**
	 * 오늘 신규 회원
	 * @return
	 */
	public int todayNewUserCount();
	
	/**
	 * 미답변 문의 수
	 * @return
	 */
	public int noAnsweredInquiryCount();
	
	/**
	 * 기간 동안의 매출
	 * @param daysAgo
	 * @return
	 */
	List<Map<String, Object>> findDailySalesSince(int daysAgo);
}
