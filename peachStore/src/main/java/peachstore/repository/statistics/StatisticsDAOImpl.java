package peachstore.repository.statistics;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

/**
 * 통계모음 dao 구현체
 * @author 김예진
 * @since 2025-08-05
 */
@Repository
@RequiredArgsConstructor
public class StatisticsDAOImpl implements StatisticsDAO {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int todayAmount() {
		return sqlSessionTemplate.selectOne("Statistics.todayAmount");
	}

	@Override
	public int todayReceiptCount() {
		return sqlSessionTemplate.selectOne("Statistics.todayReceiptCount");
	}

	@Override
	public int todayNewUserCount() {
		return sqlSessionTemplate.selectOne("Statistics.todayNewUserCount");
	}

	@Override
	public int noAnsweredInquiryCount() {
		return sqlSessionTemplate.selectOne("Statistics.noAnsweredInquiry");
	}

	@Override
	public List<Map<String, Object>> findDailySalesSince(int daysAgo) {
		return sqlSessionTemplate.selectOne("Statistics.findDailySalesSince", daysAgo);
	}

}
