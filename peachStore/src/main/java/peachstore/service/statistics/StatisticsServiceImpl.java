package peachstore.service.statistics;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.repository.statistics.StatisticsDAO;

@Service
@RequiredArgsConstructor
public class StatisticsServiceImpl implements StatisticsService{
	
	private final StatisticsDAO statisticsDAO;

	@Override
	public int todayAmount() {
		return statisticsDAO.todayAmount();
	}

	@Override
	public int todayReceiptCount() {
		return statisticsDAO.todayReceiptCount();
	}

	@Override
	public int todayNewUserCount() {
		return statisticsDAO.todayNewUserCount();
	}

	@Override
	public int noAnsweredInquiryCount() {
		return statisticsDAO.noAnsweredInquiryCount();
	}

	@Override
	public List<Map<String, Object>> findDailySalesSince(int daysAgo) {
		return statisticsDAO.findDailySalesSince(daysAgo);
	}

}
