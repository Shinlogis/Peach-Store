package peachstore.model.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 상품 사이즈(Size) 관련 서비스 구현체  
 * DB에서 사이즈 목록을 조회
 * @author 김지민
 * @since 2025-07-29
 */
@Service
public class SizeServiceImpl implements SizeService {

    // 사이즈 관련 DAO 의존성 주입
    @Autowired
    private SizeDAO sizeDAO;

    /**
     * 전체 사이즈 목록 조회
     * @return 사이즈 객체 리스트
     */
    @Override
    public List selectAll() {
        return sizeDAO.selectAll();
    }
}