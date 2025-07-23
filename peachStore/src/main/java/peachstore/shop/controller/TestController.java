package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestController {
	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String connectTest() {
		log.debug("컨트롤러 테스트용 로그 입니다.");
		return "shop/gitTest";
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String Test() {
		log.debug("index.jsp 로그 입니다.");		
		return "shop/index";
	}
}
