package vn.iotstar.controller.admin; 

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

// Bổ sung các lệnh import cần thiết
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileServlet extends HttpServlet {
    
    // Khởi tạo đối tượng bằng class Impl, không dùng Interface
    private UserDao userDao = new UserDaoImpl();
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Giả sử user có ID = 1 (Trong thực tế nên lấy từ Session đăng nhập)
        User user = userDao.findById(1); 
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int userId = Integer.parseInt(request.getParameter("id"));
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");

        User user = userDao.findById(userId);
        user.setFullName(fullname); // Viết hoa chữ N để khớp với Entity
        user.setPhone(phone);

        // Xử lý upload ảnh
        Part part = request.getPart("images");
        if (part != null && part.getSize() > 0) {
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            part.write(uploadFilePath + File.separator + fileName);
            user.setImages(fileName); // Lưu tên file vào Database
        }

        userDao.update(user);
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}