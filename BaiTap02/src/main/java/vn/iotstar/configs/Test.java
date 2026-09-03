package vn.iotstar.configs;

import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

public class Test {
	public static void main(String[] args) {
		UserService userService = new UserServiceImpl();

		if (!userService.checkExistUsername("admin")) {
			User admin = new User();
			admin.setUserName("admin");
			admin.setPassWord("123");
			admin.setEmail("admin@gmail.com");
			admin.setFullName("Administrator");
			admin.setRoleid(1); // 1: Role Admin
			admin.setPhone("0987654321");

			userService.insert(admin);
			System.out.println("-> Đã thêm tài khoản admin thành công (username: admin, password: 123, roleid: 1)");
		} else {
			System.out.println("-> Tài khoản admin đã tồn tại trong cơ sở dữ liệu!");
		}
	}
}