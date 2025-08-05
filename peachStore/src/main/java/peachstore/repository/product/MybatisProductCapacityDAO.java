package peachstore.repository.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import peachstore.domain.Product;
import peachstore.domain.ProductCapacity;


@Repository
public class MybatisProductCapacityDAO implements ProductCapacityDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void insert(ProductCapacity productCapacity) {
        sqlSessionTemplate.insert("ProductCapacity.insert", productCapacity);
    }

    @Override
    public void deleteByProductId(@Param("productId") int productId) {
        Product product = new Product();
        product.setProductId(productId);
        ProductCapacity pc = new ProductCapacity();
        pc.setProduct(product);
        sqlSessionTemplate.delete("ProductCapacity.deleteByProductId", pc);
    }

    @Override
    public List<ProductCapacity> selectByProductId(int productId) {
        Product product = new Product();
        product.setProductId(productId);
        ProductCapacity pc = new ProductCapacity();
        pc.setProduct(product);
        return sqlSessionTemplate.selectList("ProductCapacity.selectByProductId", pc);
    }

    @Override
    public ProductCapacity selectById(int product_capacity_id) {
        ProductCapacity pc = new ProductCapacity();
        pc.setProduct_capacity_id(product_capacity_id);
        return sqlSessionTemplate.selectOne("ProductCapacity.selectById", pc);
    }
}
