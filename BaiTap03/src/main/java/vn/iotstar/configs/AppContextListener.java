package vn.iotstar.configs;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println(">>> Ứng dụng web đang khởi động...");
        try {
            UserService userService = new UserServiceImpl();
            User existingAdmin = userService.get("admin");
            if (existingAdmin == null) {
                User admin = new User();
                admin.setUserName("admin");
                admin.setPassWord("123");
                admin.setEmail("admin@gmail.com");
                admin.setFullName("Administrator");
                admin.setRoleid(1); // 1: Role Admin
                admin.setPhone("0987654321");
                admin.setStatus(1); // 1: Active
                userService.insert(admin);
                System.out.println(">>> [SUCCESS] Đã tự động tạo tài khoản Admin (admin / 123, roleid: 1, status: 1) trong CSDL!");
            } else {
                if (existingAdmin.getStatus() != 1) {
                    existingAdmin.setStatus(1);
                    userService.update(existingAdmin);
                }
                System.out.println(">>> [INFO] Tài khoản admin đã sẵn sàng trong CSDL!");
            }
        } catch (Exception e) {
            System.err.println(">>> [WARN] Chưa thể kết nối CSDL khi khởi động: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println(">>> Ứng dụng web đang tắt...");
    }
}
