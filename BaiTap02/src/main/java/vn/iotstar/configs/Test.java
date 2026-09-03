package vn.iotstar.configs;

import java.util.List;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

public class Test {
	public static void main(String[] args) {
		jakarta.persistence.EntityManager em = JPAConfig.getEntityManager();
		jakarta.persistence.EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			List<User> admins = em.createQuery("SELECT u FROM User u WHERE u.userName = :username", User.class)
					.setParameter("username", "admin")
					.getResultList();
			System.out.println("Total admin accounts in DB: " + admins.size());
			
			if (admins.isEmpty()) {
				User admin = new User();
				admin.setUserName("admin");
				admin.setPassWord("123");
				admin.setEmail("admin@gmail.com");
				admin.setFullName("Administrator");
				admin.setRoleid(1); // 1: Role Admin
				admin.setPhone("0987654321");
				em.persist(admin);
				System.out.println("-> Created new admin account (admin / 123, roleid: 1)");
			} else {
				// Keep the first one and ensure its password is 123 and roleid is 1
				User firstAdmin = admins.get(0);
				firstAdmin.setPassWord("123");
				firstAdmin.setRoleid(1);
				firstAdmin.setEmail("admin@gmail.com");
				firstAdmin.setFullName("Administrator");
				firstAdmin.setPhone("0987654321");
				em.merge(firstAdmin);
				System.out.println("-> Updated admin (id=" + firstAdmin.getId() + "): username=admin, password=123, roleid=1");

				// Delete any duplicates
				for (int i = 1; i < admins.size(); i++) {
					em.remove(admins.get(i));
					System.out.println("-> Removed duplicate admin with id=" + admins.get(i).getId());
				}
			}
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (tx.isActive()) tx.rollback();
		} finally {
			em.close();
		}
		System.exit(0);
	}
}