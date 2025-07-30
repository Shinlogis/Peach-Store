package peachstore.service.product;

import java.util.List;

/**
 * 상품 사이즈(Size) 관련 서비스 인터페이스  
 * 컨트롤러에서 사이즈 목록을 요청할 때 호출
 * @author 김지민
 * @since 2025-07-29
 */
public interface SizeService {

    /**
     * 전체 사이즈 목록 조회
     * @return 사이즈 객체 리스트
     */
    public List selectAll();
}
