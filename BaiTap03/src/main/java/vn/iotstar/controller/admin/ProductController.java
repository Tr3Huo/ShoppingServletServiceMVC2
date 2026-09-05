package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/list", "/admin/product/add", "/admin/product/edit", "/admin/product/delete" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product/add.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product/edit.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                Product product = productService.findById(id);
                if (product != null && product.getImages() != null && !product.getImages().isEmpty()) {
                    deleteFile(Constant.DIR + File.separator + product.getImages());
                }
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else {
            
            List<Product> list = productService.findAll();
            req.setAttribute("productList", list);
            req.getRequestDispatcher("/views/admin/product/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if (uri.contains("/admin/product/add")) {
            String productName = req.getParameter("productName");
            double price = 0;
            int quantity = 0;
            int categoryId = 0;
            int status = 1;

            try {
                price = Double.parseDouble(req.getParameter("price"));
            } catch (Exception ignored) {}

            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (Exception ignored) {}

            try {
                categoryId = Integer.parseInt(req.getParameter("categoryId"));
            } catch (Exception ignored) {}

            if (req.getParameter("status") != null) {
                try {
                    status = Integer.parseInt(req.getParameter("status"));
                } catch (Exception ignored) {}
            }

            String description = req.getParameter("description");

            Product product = new Product();
            product.setProductName(productName);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDescription(description);
            product.setStatus(status);
            product.setCreatedDate(new Date());

            if (categoryId > 0) {
                Category category = categoryService.findById(categoryId);
                product.setCategory(category);
            }

            
            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index >= 0 ? filename.substring(index + 1) : "png";
                    String fname = "prod_" + System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else {
                    
                    product.setImages(null);
                }
            } catch (Exception e) {
                e.printStackTrace();
                product.setImages(null);
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        if (uri.contains("/admin/product/edit")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            Product product = productService.findById(productId);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            String productName = req.getParameter("productName");
            double price = 0;
            int quantity = 0;
            int categoryId = 0;
            int status = 1;

            try {
                price = Double.parseDouble(req.getParameter("price"));
            } catch (Exception ignored) {}

            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (Exception ignored) {}

            try {
                categoryId = Integer.parseInt(req.getParameter("categoryId"));
            } catch (Exception ignored) {}

            if (req.getParameter("status") != null) {
                try {
                    status = Integer.parseInt(req.getParameter("status"));
                } catch (Exception ignored) {}
            }

            String description = req.getParameter("description");
            String oldImage = product.getImages();

            product.setProductName(productName);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDescription(description);
            product.setStatus(status);

            if (categoryId > 0) {
                Category category = categoryService.findById(categoryId);
                product.setCategory(category);
            }

            
            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                    
                    if (oldImage != null && !oldImage.isEmpty() && !oldImage.equals("default-product.png")) {
                        deleteFile(uploadPath + File.separator + oldImage);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index >= 0 ? filename.substring(index + 1) : "png";
                    String fname = "prod_" + System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (Files.exists(path)) {
            Files.delete(path);
        }
    }
}