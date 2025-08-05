package peachstore.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import peachstore.service.inquiry.InquiryService;
import peachstore.service.statistics.StatisticsService;

/**

 * @author 김지민
 * @since 2025-07-29
 */
@Controller
@RequiredArgsConstructor
public class MainController {
    
	private final StatisticsService statisticsService;

	@GetMapping("/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		
		int todayAmount = statisticsService.todayAmount();
		int todayReceiptCount = statisticsService.todayReceiptCount();
		int todayNewUserCount = statisticsService.todayNewUserCount();
		int noAnsweredInquiryCount = statisticsService.noAnsweredInquiryCount();
		List<Map<String, Object>> findDailySalesSince = statisticsService.findDailySalesSince(7);
		
	    // 날짜, 금액을 담을 리스트
	    List<String> salesDates = new ArrayList<>();
	    List<Long> totalAmounts = new ArrayList<>();
	    
		for (Map<String, Object> sales : findDailySalesSince) {
			// 날짜 꺼내기
		    Object dateObj = sales.get("salesDate");
		    String salesDateStr = dateObj.toString();
		    salesDates.add(salesDateStr);
		    
		    // 금액 꺼내기
		    Object amountObj = sales.get("totalAmount");
		    Long totalAmount = null;
		    if (amountObj instanceof Number) {
		        totalAmount = ((Number) amountObj).longValue();
		    }
		    totalAmounts.add(totalAmount);
		}
			
		mav.setViewName("/index");
		mav.addObject("todayAmount", todayAmount);
		mav.addObject("todayReceiptCount", todayReceiptCount);
		mav.addObject("todayNewUserCount", todayNewUserCount);
		mav.addObject("noAnsweredInquiryCount", noAnsweredInquiryCount);
		mav.addObject("salesDates", salesDates);
		mav.addObject("totalAmount", totalAmounts);
		
		return mav;
	}
	
	

}