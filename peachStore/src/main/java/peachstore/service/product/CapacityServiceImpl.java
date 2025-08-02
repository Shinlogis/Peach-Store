package peachstore.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.product.CapacityDAO;

/**
 * 색상(Color) 관련 서비스 구현체
 * 색상 목록 조회 시 ColorDAO를 통해 DB에 접근
 * @author 김지민
 * @since 2025-08-01
 */
@Service
public class CapacityServiceImpl implements CapacityService {

    @Autowired
    private CapacityDAO capacityDAO;

    @Override
    public List selectAll() {
        return capacityDAO.selectAll();
    }
}
