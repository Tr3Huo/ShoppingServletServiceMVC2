package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface UserService {

	User login(String username, String password);

	User get(String username);

	void insert(User user);

	boolean register(String email, String password, String username, String fullname, String phone);

	boolean checkExistEmail(String email);

	boolean checkExistUsername(String username);

	boolean checkExistPhone(String phone);

	void update(User user);

	User findByEmail(String email);

	User findByUsernameOrEmail(String keyword);

	boolean register(String email, String password, String username, String fullname, String phone, String code);

	boolean verifyOtp(String email, String otp);

	boolean updatePassword(String email, String newPassword);

	boolean resendOtp(String email, boolean isRegister);
}