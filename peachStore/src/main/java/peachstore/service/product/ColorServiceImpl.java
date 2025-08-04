package peachstore.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.product.ColorDAO;

/**
 * 색상(Color) 관련 서비스 구현체
 * @author 김지민
 * @since 2025-07-29
 */
@Service
public class ColorServiceImpl implements ColorService {

    @Autowired
    private ColorDAO colorDAO;

    @Override
    public List selectAll() {
        return colorDAO.selectAll();
    }
}
