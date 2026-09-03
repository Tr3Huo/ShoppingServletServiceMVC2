package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User; 
import vn.iotstar.service.UserService;

public class UserServiceImpl implements UserService {

    UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }

        // Đảm bảo tài khoản admin (admin / 123) luôn đăng nhập được trên web
        if ("admin".equalsIgnoreCase(username) && "123".equals(password)) {
            try {
                if (user == null) {
                    User admin = new User();
                    admin.setUserName("admin");
                    admin.setPassWord("123");
                    admin.setEmail("admin@gmail.com");
                    admin.setFullName("Administrator");
                    admin.setRoleid(1); // 1: Role Admin
                    admin.setPhone("0987654321");
                    userDao.insert(admin);
                    return admin;
                }
            } catch (Exception e) {
                User admin = new User();
                admin.setId(1);
                admin.setUserName("admin");
                admin.setPassWord("123");
                admin.setEmail("admin@gmail.com");
                admin.setFullName("Administrator");
                admin.setRoleid(1);
                admin.setPhone("0987654321");
                return admin;
            }
        }
        return null; 
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        if (checkExistEmail(email) || checkExistUsername(username) || checkExistPhone(phone)) {
            return false; 
        }

        User user = new User();
        user.setEmail(email);
        user.setPassWord(password);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPhone(phone);
        user.setRoleid(3); 
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }
}