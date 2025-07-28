package peachstore.shop.controller.inquiry;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Inquiry;
import peachstore.domain.User;
import peachstore.service.inquiry.InquiryService;
/**
 * 문의하기 컨트롤러
 * @author 성유진 
 * @since 2025-07-26
 */
@Slf4j
@Controller
public class InquiryController {
	
	@Autowired 
	private InquiryService inquiryService;

	@GetMapping("/inquiry/registForm")
	public String registForm() {
		return "/shop/inquiry/regist";
	}
	
	
	//등록
	@PostMapping("/inquiry/regist")
	@ResponseBody
	public String regist(Inquiry inquiry, HttpServletRequest request, HttpSession session) {
		
		String savePath = request.getServletContext().getRealPath("/data");
		String responseData = "fail";
		log.debug("제목은 : " + request.getParameter("title"));
		log.debug("내용은 : " + request.getParameter("inquiry_text"));
		
		
		try {
			inquiryService.regist(inquiry, savePath);
			log.debug("문의 아이디는 : " + inquiry.getInquiry_id());
			responseData = "success";
		} catch (Exception e) {
			inquiryService.remove(inquiry, savePath);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	
	//전체 조회
	@GetMapping("/inquiry/list")
	public ModelAndView getList(Inquiry inquiry, HttpSession session) {
		User user = (User) session.getAttribute("user");
		inquiry.setUser(user); 

		List inquiryList = inquiryService.selectAll(inquiry);
	    
		ModelAndView mav = new ModelAndView();
		mav.addObject("inquiryList", inquiryList);
		mav.setViewName("shop/inquiry/list");
		
		
		
		return mav;
	}
	
	//단건 조회
	@GetMapping("/inquiry/detail")
	public String getDetail(Inquiry inq, Model model, HttpSession session) {
		
		User user = (User)session.getAttribute("user");
		inq.setUser(user);
		
		Inquiry inquiry = inquiryService.select(inq);
		model.addAttribute("inquiry", inquiry);
		
		return "shop/inquiry/detail";
	}
	
}
