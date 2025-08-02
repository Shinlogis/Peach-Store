package peachstore.service.product;

import java.util.List;

/**
 * 색상(Color) 관련 서비스 인터페이스
 * 색상 목록 조회 등의 비즈니스 로직을 정의
 * @author 김지민
 * @since 2025-07-29
 */
public interface ColorService {
    public List selectAll();
}