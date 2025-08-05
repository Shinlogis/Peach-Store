package peachstore.service.product;

import java.util.List;

import peachstore.domain.ProductCapacity;

public interface ProductCapacityService {
	   void addProductCapacity(ProductCapacity productCapacity);
	    void removeProductCapacitiesByProductId(int productId);
	    List<ProductCapacity> getProductCapacitiesByProductId(int productId);
	    ProductCapacity getProductCapacityById(int productCapacityId);
}