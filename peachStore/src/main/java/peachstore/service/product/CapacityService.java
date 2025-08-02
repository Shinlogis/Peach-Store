package peachstore.service.product;

import java.util.List;

import org.springframework.stereotype.Service;

/**
 * 용량(Capacity) 관련 서비스 인터페이스
 * 용량 목록 조회 등의 비즈니스 로직을 정의
 * @author 김지민
 * @since 2025-08-01
 */
public interface CapacityService {
	    public List selectAll();
}
