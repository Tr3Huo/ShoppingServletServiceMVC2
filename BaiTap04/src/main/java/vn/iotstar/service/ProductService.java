package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface ProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int productId) throws Exception;
    Product findById(int productId);
    List<Product> findAll();
    List<Product> findAll(int page, int pagesize);
    List<Product> findTop10Newest();
    List<Product> findByCategoryId(int cateId);
    List<Product> findByCategoryId(int cateId, int page, int pagesize);
    List<Product> searchByName(String keyword);
    int count();
    int countByCategoryId(int cateId);
}
