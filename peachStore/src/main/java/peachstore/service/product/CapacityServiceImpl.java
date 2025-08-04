package peachstore.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.product.CapacityDAO;

/**
 * 색상(Color) 관련 서비스 구현체
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
