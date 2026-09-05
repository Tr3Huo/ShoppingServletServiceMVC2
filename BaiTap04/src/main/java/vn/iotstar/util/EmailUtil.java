package vn.iotstar.util;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static boolean sendOtpEmail(String toEmail, String otp, boolean isRegister) {
        String fromEmail = Constant.FROM_EMAIL;
        String fromPassword = Constant.FROM_PASSWORD;

        String subject = isRegister 
                ? "[Shop MVC] Xác nhận kích hoạt tài khoản - Mã OTP" 
                : "[Shop MVC] Yêu cầu đặt lại mật khẩu - Mã OTP";

        String title = isRegister ? "KÍCH HOẠT TÀI KHOẢN" : "ĐẶT LẠI MẬT KHẨU";
        String desc = isRegister 
                ? "Cảm ơn bạn đã đăng ký tài khoản tại hệ thống. Vui lòng sử dụng mã OTP dưới đây để kích hoạt tài khoản:" 
                : "Hệ thống nhận được yêu cầu đặt lại mật khẩu. Vui lòng sử dụng mã OTP dưới đây để xác nhận:";

        String contentHtml = "<div style=\"font-family: Arial, sans-serif; max-width: 550px; margin: 0 auto; padding: 25px; border: 1px solid #e0e0e0; border-radius: 8px;\">"
                + "<h2 style=\"color: #00a8e6; text-align: center; margin-bottom: 20px;\">" + title + "</h2>"
                + "<p style=\"font-size: 14px; color: #555;\">" + desc + "</p>"
                + "<div style=\"background-color: #f8f9fa; border: 2px dashed #00a8e6; padding: 15px; text-align: center; margin: 25px 0; border-radius: 6px;\">"
                + "<span style=\"font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #00a8e6;\">" + otp + "</span>"
                + "</div>"
                + "<p style=\"font-size: 13px; color: #888;\">Mã OTP có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                + "<hr style=\"border: none; border-top: 1px solid #eee; margin: 20px 0;\">"
                + "<p style=\"font-size: 12px; color: #aaa; text-align: center;\">Shopping MVC System</p>"
                + "</div>";

        System.out.println("================================================================================");
        System.out.println(">>> [EMAIL SERVICE] GỬI EMAIL TỚI: " + toEmail);
        System.out.println(">>> [EMAIL SERVICE] TIÊU ĐỀ: " + subject);
        System.out.println(">>> [EMAIL SERVICE] MÃ OTP LÀ: [ " + otp + " ]");
        System.out.println("================================================================================");

        // Nếu chưa thay đổi email mặc định trong Constant.java
        if (fromEmail == null || fromEmail.contains("your-email") || fromPassword == null || fromPassword.contains("your-app-password")) {
            System.out.println(">>> [EMAIL SERVICE THÔNG BÁO] Chưa cấu hình Gmail thật trong Constant.java.");
            System.out.println(">>> [EMAIL SERVICE] Mã OTP [ " + otp + " ] đã được in ở trên để bạn nhập xác nhận ngay.");
            return false;
        }

        final String cleanPassword = fromPassword.trim().replaceAll("\\s+", "");
        final String cleanEmail = fromEmail.trim();

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        props.put("mail.smtp.ssl.trust", "*");
        props.put("mail.smtp.connectiontimeout", "8000");
        props.put("mail.smtp.timeout", "8000");
        props.put("mail.smtp.writetimeout", "8000");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(cleanEmail, cleanPassword);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(cleanEmail, "Shopping MVC System", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setContent(contentHtml, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println(">>> [EMAIL SERVICE] Đã gửi email thành công qua Gmail SMTP tới " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println(">>> [EMAIL SERVICE LỖI SMTP]: " + e.getMessage());
            e.printStackTrace();
            System.out.println(">>> [EMAIL SERVICE] Hãy kiểm tra: 1) Tài khoản Gmail và 2) Google App Password (mật khẩu ứng dụng 16 ký tự)");
            return false;
        }
    }
}