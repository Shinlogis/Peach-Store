package peachstore.service.gradeCoupon;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import peachstore.domain.GradeCoupon;
import peachstore.repository.gradeCoupon.GradeCouponDAO;

/**
 * 제품 카테고리 서비스 구현체
 * 
 * @author 김예진
 * @since 2025-07-25
 */
@Service
@RequiredArgsConstructor
public class GradeCouponServiceImpl implements GradeCouponService{
	
	private final GradeCouponDAO gradeCouponDAO;
	
	@Override
	public List<GradeCoupon> selectAll() {
		return gradeCouponDAO.selectAll();
	}

}
