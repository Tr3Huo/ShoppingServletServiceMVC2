package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.service.ProductService;

public class ProductServiceImpl implements ProductService {

    private ProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int productId) throws Exception {
        productDao.delete(productId);
    }

    @Override
    public Product findById(int productId) {
        return productDao.findById(productId);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findAll(int page, int pagesize) {
        return productDao.findAll(page, pagesize);
    }

    @Override
    public List<Product> findTop10Newest() {
        return productDao.findTop10Newest();
    }

    @Override
    public List<Product> findByCategoryId(int cateId) {
        return productDao.findByCategoryId(cateId);
    }

    @Override
    public List<Product> findByCategoryId(int cateId, int page, int pagesize) {
        return productDao.findByCategoryId(cateId, page, pagesize);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public int countByCategoryId(int cateId) {
        return productDao.countByCategoryId(cateId);
    }
}
