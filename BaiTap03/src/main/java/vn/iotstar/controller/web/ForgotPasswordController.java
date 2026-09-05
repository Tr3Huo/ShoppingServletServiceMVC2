package vn.iotstar.controller.web;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailUtil;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/forgot-password", "/verify-forgot-otp", "/reset-password" })
public class ForgotPasswordController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/verify-forgot-otp")) {
            String email = req.getParameter("email");
            if (email == null || email.isEmpty()) {
                HttpSession session = req.getSession(false);
                if (session != null) {
                    email = (String) session.getAttribute("resetEmail");
                }
            }
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("/reset-password")) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("forgotOtpVerified") == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("/forgot-password")) {
            String email = req.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                req.setAttribute("alert", "Vui lòng nhập địa chỉ email!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            email = email.trim();
            User user = userService.findByEmail(email);
            if (user == null) {
                req.setAttribute("alert", "Email này chưa được đăng ký trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            
            String otp = EmailUtil.generateOtp();
            user.setCode(otp);
            userService.update(user);

            
            boolean emailSent = EmailUtil.sendOtpEmail(email, otp, false);

            HttpSession session = req.getSession(true);
            session.setAttribute("resetEmail", email);
            if (!emailSent) {
                session.setAttribute("otpNotice", "Mã OTP đặt lại mật khẩu là: <b>" + otp + "</b> (Hệ thống hiển thị trực tiếp để bạn đổi mật khẩu ngay. Để nhận email thật, vui lòng cấu hình Gmail và App Password trong vn.iotstar.util.Constant.java)");
            } else {
                session.setAttribute("message", "Mã OTP đã được gửi đến email " + email + ". Vui lòng kiểm tra hộp thư!");
            }

            resp.sendRedirect(req.getContextPath() + "/verify-forgot-otp?email=" + URLEncoder.encode(email, "UTF-8"));
            return;
        }

        if (uri.contains("/verify-forgot-otp")) {
            String email = req.getParameter("email");
            String otp = req.getParameter("otp");

            if (email == null || email.trim().isEmpty()) {
                HttpSession session = req.getSession(false);
                if (session != null) {
                    email = (String) session.getAttribute("resetEmail");
                }
            }

            if (email == null || otp == null || otp.trim().isEmpty()) {
                req.setAttribute("alert", "Vui lòng nhập mã OTP!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
                return;
            }

            email = email.trim();
            otp = otp.trim();

            User user = userService.findByEmail(email);
            if (user != null && otp.equals(user.getCode())) {
                HttpSession session = req.getSession(true);
                session.setAttribute("forgotOtpVerified", true);
                session.setAttribute("resetEmail", email);
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
            }
            return;
        }

        if (uri.contains("/reset-password")) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("forgotOtpVerified") == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }

            String password = req.getParameter("password");
            String repassword = req.getParameter("repassword");

            if (password == null || password.trim().isEmpty() || repassword == null || repassword.trim().isEmpty()) {
                req.setAttribute("alert", "Mật khẩu không được để trống!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            if (!password.equals(repassword)) {
                req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            String email = (String) session.getAttribute("resetEmail");
            boolean updated = userService.updatePassword(email, password);

            if (updated) {
                session.removeAttribute("forgotOtpVerified");
                session.removeAttribute("resetEmail");
                resp.sendRedirect(req.getContextPath() + "/login?resetSuccess=true");
            } else {
                req.setAttribute("alert", "Không thể cập nhật mật khẩu. Vui lòng thử lại!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            }
        }
    }
}