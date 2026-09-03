package vn.iotstar.controller.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// ĐÃ SỬA: Đổi từ vn.iotstar.model.User sang vn.iotstar.entity.User
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/login", "" })
public class LoginController extends HttpServlet {

	public static final String SESSION_USERNAME = "username";
	public static final String COOKIE_REMEMBER = "username";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			resp.sendRedirect(req.getContextPath() + "/waiting");
			return;
		}

		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(COOKIE_REMEMBER)) {
					String username = cookie.getValue();
					UserService service = new UserServiceImpl();
					User user = service.get(username);
					if (user != null) {
						session = req.getSession(true);
						session.setAttribute("account", user);
						session.setAttribute(SESSION_USERNAME, username);
						resp.sendRedirect(req.getContextPath() + "/waiting");
						return;
					}
				}
			}
		}

		String activated = req.getParameter("activated");
		if ("success".equals(activated)) {
			req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
		} else if ("already".equals(activated)) {
			req.setAttribute("message", "Tài khoản đã được kích hoạt từ trước. Hãy đăng nhập.");
		}
		String resetSuccess = req.getParameter("resetSuccess");
		if ("true".equals(resetSuccess)) {
			req.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới.");
		}

		req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");

		String username = req.getParameter("username");
		String password = req.getParameter("password");
		boolean isRememberMe = false;
		String remember = req.getParameter("remember");

		if ("on".equals(remember)) {
			isRememberMe = true;
		}

		String alertMsg = "";

		if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			alertMsg = "Tài khoản hoặc mật khẩu không được rỗng";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			return;
		}

		UserService service = new UserServiceImpl();
		User user = service.login(username.trim(), password.trim());

		if (user != null) {
			// Kiểm tra trạng thái kích hoạt tài khoản
			if (user.getStatus() == 0) {
				alertMsg = "Tài khoản của bạn chưa được kích hoạt! Vui lòng xác thực mã OTP gửi về email " + user.getEmail() + " để kích hoạt.";
				req.setAttribute("alert", alertMsg);
				req.setAttribute("unactivatedEmail", user.getEmail());
				req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
				return;
			}

			HttpSession session = req.getSession(true);
			session.setAttribute("account", user);
			session.setAttribute(SESSION_USERNAME, user.getUserName());

			if (isRememberMe) {
				saveRemeberMe(resp, user.getUserName());
			}

			resp.sendRedirect(req.getContextPath() + "/waiting");
		} else {
			alertMsg = "Tài khoản hoặc mật khẩu không đúng!";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		}
	}

	private void saveRemeberMe(HttpServletResponse response, String username) {
		Cookie cookie = new Cookie(COOKIE_REMEMBER, username);
		cookie.setMaxAge(30 * 60);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
}