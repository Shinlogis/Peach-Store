package peachstore.model.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 색상(Color) 관련 서비스 구현체
 * 색상 목록 조회 시 ColorDAO를 통해 DB에 접근
 * @author 김지민
 * @since 2025-07-29
 */
@Service
public class ColorServiceImpl implements ColorService {

    @Autowired
    private ColorDAO colorDAO;

    /**
     * 색상 전체 목록 조회
     * @return 색상 목록 리스트
     */
    @Override
    public List selectAll() {
        return colorDAO.selectAll();
    }
}
