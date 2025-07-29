package peachstore.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * 메인 페이지 컨트롤러 
 * 
 * @author 서예닮 
 * @since 2025-07-25
 */
@Slf4j
@Controller
public class MainController {
	
		@GetMapping("/main")                                          
		public String main() {                                       	
		return "shop/index";                                         
		}
	
}
