package peachstore.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import peachstore.domain.ProductCapacity;
import peachstore.repository.product.ProductCapacityDAO;

@Service
public class ProductCapacityServiceImpl implements ProductCapacityService {

    @Autowired
    private ProductCapacityDAO productCapacityDAO;

    @Override
    public void addProductCapacity(ProductCapacity productCapacity) {
        productCapacityDAO.insert(productCapacity);
    }

    @Override
    public void removeProductCapacitiesByProductId(int productId) {
        productCapacityDAO.deleteByProductId(productId);
    }

    @Override
    public List<ProductCapacity> getProductCapacitiesByProductId(int productId) {
        return productCapacityDAO.selectByProductId(productId);
    }

    @Override
    public ProductCapacity getProductCapacityById(int productCapacityId) {
        return productCapacityDAO.selectById(productCapacityId);
    }
}
