package vn.iotstar.controller.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/verify-otp", "/resend-otp" })
public class VerifyOtpController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/resend-otp")) {
            String email = req.getParameter("email");
            if (email == null || email.isEmpty()) {
                HttpSession session = req.getSession(false);
                if (session != null) {
                    email = (String) session.getAttribute("registeredEmail");
                }
            }

            if (email != null && !email.isEmpty()) {
                boolean sent = userService.resendOtp(email, true);
                if (sent) {
                    req.setAttribute("message", "Mã OTP mới đã được gửi đến " + email);
                } else {
                    req.setAttribute("alert", "Không thể gửi lại mã OTP. Vui lòng kiểm tra lại email.");
                }
                req.setAttribute("email", email);
            }
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // /verify-otp GET
        String email = req.getParameter("email");
        if (email == null || email.isEmpty()) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                email = (String) session.getAttribute("registeredEmail");
            }
        }

        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ email và mã OTP!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        email = email.trim();
        otp = otp.trim();

        User user = userService.findByEmail(email);
        if (user == null) {
            req.setAttribute("alert", "Không tìm thấy tài khoản với email: " + email);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        if (user.getStatus() == 1) {
            // Đã kích hoạt rồi
            resp.sendRedirect(req.getContextPath() + "/login?activated=already");
            return;
        }

        boolean isValid = userService.verifyOtp(email, otp);
        if (isValid) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.removeAttribute("registeredEmail");
            }
            resp.sendRedirect(req.getContextPath() + "/login?activated=success");
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hiệu lực. Vui lòng thử lại!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}