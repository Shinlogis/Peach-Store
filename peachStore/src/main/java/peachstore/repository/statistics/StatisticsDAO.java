package peachstore.repository.statistics;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * 통계모음 dao
 * @author 김예진
 * @since 2025-08-05
 */
@Mapper
public interface StatisticsDAO {
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
	 * 답변 필요 문의 수
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