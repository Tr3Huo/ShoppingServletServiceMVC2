package vn.iotstar.controller.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/product", "/products", "/product/detail" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        String action = req.getParameter("action");

        // Xem chi tiết 01 sản phẩm: /product/detail?id=... hoặc /product?action=detail&id=...
        if (uri.contains("/product/detail") || "detail".equalsIgnoreCase(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    Product product = productService.findById(id);
                    if (product != null) {
                        req.setAttribute("product", product);

                        // Sản phẩm cùng danh mục (gợi ý)
                        if (product.getCategory() != null) {
                            List<Product> related = productService.findByCategoryId(product.getCategory().getCategoryId(), 0, 4);
                            req.setAttribute("relatedProducts", related);
                        }

                        req.getRequestDispatcher("/views/web/product/detail.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        // Hiển thị danh sách sản phẩm phân trang 6 sản phẩm/trang tại URL /product
        int page = 1;
        try {
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }
        } catch (Exception e) {
            page = 1;
        }
        if (page < 1) page = 1;

        int pageSize = 6; // Phân trang 6sp/trang
        String cateIdStr = req.getParameter("cateId");
        List<Product> list;
        int totalProducts;

        if (cateIdStr != null && !cateIdStr.trim().isEmpty()) {
            try {
                int cateId = Integer.parseInt(cateIdStr);
                list = productService.findByCategoryId(cateId, page - 1, pageSize);
                totalProducts = productService.countByCategoryId(cateId);
                req.setAttribute("selectedCateId", cateId);
            } catch (Exception e) {
                list = productService.findAll(page - 1, pageSize);
                totalProducts = productService.count();
            }
        } else {
            list = productService.findAll(page - 1, pageSize);
            totalProducts = productService.count();
        }

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;

        List<Category> listCategories = categoryService.findAll();

        req.setAttribute("productList", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("cateList", listCategories);

        req.getRequestDispatcher("/views/web/product/list.jsp").forward(req, resp);
    }
}