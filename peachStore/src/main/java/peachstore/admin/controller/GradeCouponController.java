package peachstore.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import peachstore.domain.GradeCoupon;
import peachstore.service.GradeCouponService;

/**
 * 등급별 쿠폰 컨트롤러
 * 
 * @author 김예진
 * @since 2025-07-28
 */
@Controller
@RequiredArgsConstructor
public class GradeCouponController {
	
	private final GradeCouponService gradeCouponService;
	
	/**
	 * 모든 등급별 쿠폰 조회
	 * @param model
	 * @return
	 */
	@GetMapping("/coupon/list")
	public String selectAll(Model model) {
		List<GradeCoupon> coupons = gradeCouponService.selectAll();
		model.addAttribute(coupons);
		return "/coupon/list";
	}

}
