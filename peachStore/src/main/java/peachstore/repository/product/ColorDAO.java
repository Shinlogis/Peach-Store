package peachstore.repository.product;

import java.util.List;

/**
 * 색상(Color) 관련 DAO 인터페이스
 * DB에서 색상 목록을 조회하는 기능
 * @author 김지민
 * @since 2025-07-29
 */
public interface ColorDAO {

    public List selectAll();
}