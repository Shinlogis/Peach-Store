package peachstore.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import peachstore.service.product.ColorService;

/**
 * 색상 관련 컨트롤러
 * 상품 등록 시 선택할 수 있는 색상 목록을 제공
 * @author 김지민
 * @since 2025-07-29
 */
@Controller
public class ColorController {
	
	@Autowired
	private ColorService colorService;

	/**
	 * 색상 전체 목록 조회
	 * @return 색상 리스트(JSON 배열 형태)
	 */
	@GetMapping("/color/list")
	@ResponseBody
	public List selectAll() {
		return colorService.selectAll();
	}
}