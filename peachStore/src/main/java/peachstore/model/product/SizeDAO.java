package peachstore.model.product;

import java.util.List;

/**
 * 상품 사이즈(Size) 관련 DAO 인터페이스  
 * DB에 저장된 전체 사이즈 목록을 조회하는 기능을 정의
 * @author 김지민
 * @since 2025-07-29
 */
public interface SizeDAO {

    /**
     * 모든 사이즈 목록 조회
     * @return 사이즈 객체 리스트
     */
    public List selectAll();
}
