package vn.iotstar.controller.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = { "/profile" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProfileController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User account = (User) session.getAttribute("account");
		
		if (account == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		User user = userService.get(account.getUserName());
		req.setAttribute("user", user);

		req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();
		User account = (User) session.getAttribute("account");

		if (account == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		try {
			User user = userService.get(account.getUserName());

			String fullName = req.getParameter("fullname");
			String phone = req.getParameter("phone");

			String fileName = "";
			Part part = req.getPart("images");
			if (part != null && part.getSize() > 0) {
				String uploadPath = Constant.DIR;
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}
				String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				
				int index = originalFileName.lastIndexOf(".");
				String ext = "";
				if(index > 0){
				    ext = originalFileName.substring(index);
				}
				fileName = System.currentTimeMillis() + ext;
				
				part.write(uploadPath + File.separator + fileName);
				
				user.setImages(fileName);
			}

			user.setFullName(fullName);
			user.setPhone(phone);

			userService.update(user);
			
			session.setAttribute("account", user);

			req.setAttribute("message", "Cập nhật thông tin thành công!");
			req.setAttribute("user", user);

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("error", "Có lỗi xảy ra khi cập nhật!");
		}

		req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
	}
}
