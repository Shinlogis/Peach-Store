package peachstore.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.repository.product.SizeDAO;

/**
 * 상품 사이즈(Size) 관련 서비스 구현체  
 * @author 김지민
 * @since 2025-07-29
 */
@Service
public class SizeServiceImpl implements SizeService {

    @Autowired
    private SizeDAO sizeDAO;

    public List selectAll() {
        return sizeDAO.selectAll();
    }
}