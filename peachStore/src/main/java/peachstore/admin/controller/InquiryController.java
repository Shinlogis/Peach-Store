package peachstore.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.domain.Inquiry;
import peachstore.domain.User;
import peachstore.service.inquiry.InquiryService;
import peachstore.util.Paging;

@Controller
@Slf4j
@RequiredArgsConstructor
public class InquiryController {

	private final InquiryService inquiryService;

	/**
	 * 전체 문의 내역 조회
	 * 
	 * @param request
	 * @param model
	 * @param searchCondition 검색조건
	 * @param searchKey       검색어
	 * @param filterNoAnswer  답변대기만 보기 체크 여부
	 * @return
	 */
	@GetMapping("/inquiry/list")
	public String listAll(HttpServletRequest request, Model model, 
			@RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate, 
			@RequestParam(required = false) String searchCondition,
			@RequestParam(required = false) String searchKey,
			@RequestParam(required = false, defaultValue = "false") boolean filterNoAnswer) {
		log.debug("searchCondition - {}, searchKey - {}", searchCondition, searchKey);

		// 검색 조건을 담을 searchMap
		Map<String, Object> searchMap = new HashMap<>();
		// 넘어온 검색조건이 있다면 searchMap에 추가
		if (filterNoAnswer) {
			searchMap.put("filterNoAnswer", true);
		}
		if (searchCondition != null && searchKey != null && !searchKey.trim().isEmpty()) { // 검색 조건이 선택돼있는 경우
			if (searchCondition.equals("userId")) { // 검색 조건이 사용자 ID인 경우
				// 검색 조건에 userId, 검색어에 searchKey 추가
				searchMap.put("searchCondition", "userId");
				searchMap.put("searchKey", searchKey);
			}
			if (searchCondition.equals("inquiryText")) { // 검색 조건이 문의내용인 경우
				searchMap.put("searchCondition", "inquiryText");
				searchMap.put("searchKey", searchKey);
				log.debug("serchKey - {}, condition - {}", searchKey, "innertext");
			}
		}
		if (startDate != null && !startDate.trim().isEmpty()) {
			searchMap.put("startDate", startDate);
		}
		if (endDate != null && !endDate.trim().isEmpty()) {
			searchMap.put("endDate", endDate);
		}

		List<Inquiry> inquiries = inquiryService.selectAllAtAdmin(searchMap);

		Paging paging = new Paging();
		paging.init(inquiries, request);

		model.addAttribute("inquiries", inquiries);
		model.addAttribute("paging", paging);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("filterNoAnswer", filterNoAnswer);

		return "/inquiry/list";
	}

	/**
	 * 문의 답변 등록
	 * 
	 * @param inquiry_id
	 * @param admin_id
	 * @param answer_text
	 * @param request
	 * @return
	 */
	@PostMapping("/inquiry/answer")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> answerInquiry(int inquiry_id, String answer_text, HttpServletRequest request, HttpSession httpSession) {
		Admin admin = (Admin) httpSession.getAttribute("admin"); // 세션에서 꺼내오기
		Map<String, Object> response = new HashMap<>();

		try {
			inquiryService.answerInquiry(inquiry_id, admin.getAdminId(), answer_text);
			response.put("success", true);
			response.put("message", "답변이 등록되었습니다.");
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} catch (Exception e) {
			log.error("답변 등록 중 예외 발생", e);
			response.put("success", false);
			response.put("message", "답변이 등록되지 않았습니다. 다시 시도해주세요.");
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
