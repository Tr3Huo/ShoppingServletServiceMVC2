package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface UserDao {
	User get(String username);

	void insert(User user);

	boolean checkExistEmail(String email);

	boolean checkExistUsername(String username);

	boolean checkExistPhone(String phone);

	void update(User user);

	User findByEmail(String email);

	User findByUsernameOrEmail(String keyword);
}