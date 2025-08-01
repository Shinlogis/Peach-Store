package peachstore.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.service.inquiry.InquiryService;
import peachstore.util.Paging;

@Controller
@Slf4j
@RequiredArgsConstructor
public class InquiryController {
	
	private final InquiryService inquiryService;
	
	/**
	 * 전체 문의 내역 조회
	 * @param model
	 * @return
	 */
	@GetMapping("/inquiry/list")
	public String listAll(HttpServletRequest request, Model model) {
		List<Inquiry> inquiries = inquiryService.selectAllAtAdmin();
		Paging paging = new Paging();
		paging.init(inquiries, request);
		
		model.addAttribute("inquiries", inquiries);
		model.addAttribute("paging", paging);
		return "/inquiry/list";
	}
	
}
