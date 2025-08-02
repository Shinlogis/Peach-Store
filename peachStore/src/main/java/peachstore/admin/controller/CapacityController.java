package peachstore.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import peachstore.service.product.CapacityService;

/**
 * 용량 관련 컨트롤러
 * 상품 등록 시 선택할 수 있는 용량 목록을 제공
 * @author 김지민
 * @since 2025-08-01
 */
@Controller
public class CapacityController {
	
	@Autowired
	private CapacityService capacityService;

	@GetMapping("/capacity/list")
	@ResponseBody
	public List selectAll() {
		return capacityService.selectAll();
	}
}