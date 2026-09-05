package vn.iotstar.controller.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    public static final String REGISTER = "/views/register.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    session = req.getSession(true);
                    session.setAttribute("username", cookie.getValue());
                    resp.sendRedirect(req.getContextPath() + "/admin");
                    return;
                }
            }
        }
        
        req.getRequestDispatcher(REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String repassword = req.getParameter("repassword");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        UserService service = new UserServiceImpl();
        String alertMsg = "";

        if (repassword != null && !repassword.equals(password)) {
            alertMsg = "Mật khẩu xác nhận không khớp!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistEmail(email)) {
            alertMsg = "Email đã tồn tại!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistUsername(username)) {
            alertMsg = "Tài khoản đã tồn tại!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistPhone(phone)) {
            alertMsg = "Số điện thoại đã tồn tại!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        
        String otp = vn.iotstar.util.EmailUtil.generateOtp();

        
        boolean isSuccess = service.register(email, password, username, fullname, phone, otp);
        
        if (isSuccess) {
            
            boolean emailSent = vn.iotstar.util.EmailUtil.sendOtpEmail(email, otp, true);

            
            HttpSession session = req.getSession(true);
            session.setAttribute("registeredEmail", email);
            if (!emailSent) {
                session.setAttribute("otpNotice", "Mã OTP kích hoạt của bạn là: <b>" + otp + "</b> (Hệ thống hiển thị trực tiếp để bạn kích hoạt ngay. Để nhận email thật, vui lòng cấu hình Gmail và App Password trong vn.iotstar.util.Constant.java)");
            } else {
                session.setAttribute("message", "Mã OTP đã được gửi đến email " + email + ". Vui lòng kiểm tra hộp thư!");
            }
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + java.net.URLEncoder.encode(email, "UTF-8"));
        } else {
            alertMsg = "Lỗi hệ thống khi đăng ký tài khoản!";
            req.setAttribute("alert", alertMsg);
            req.getRequestDispatcher(REGISTER).forward(req, resp);
        }
    }
}