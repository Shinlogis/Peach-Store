package peachstore.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import peachstore.service.product.SizeService;

/**
 * 사이즈 관련 컨트롤러
 * 상품 등록 시 선택 가능한 사이즈 목록을 제공
 * @author 김지민
 * @since 2025-07-29
 */
@Controller
public class SizeController {
	
	@Autowired
	private SizeService sizeService;

	@GetMapping("/size/list")
	@ResponseBody
	public List selectAll() {
		return sizeService.selectAll();
	}
}
