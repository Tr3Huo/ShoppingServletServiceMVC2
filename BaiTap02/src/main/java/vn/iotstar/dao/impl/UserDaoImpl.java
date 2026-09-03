package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import vn.iotstar.configs.JPAConfig; 
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements UserDao {

    @Override
    public User get(String username) {
        // Đã sửa JpaConfig thành JPAConfig
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userName = :username"; 
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("username", username);
            
            return query.getSingleResult();
        } catch (Exception e) {
            // Dùng Exception chung để bao quát mọi lỗi không tìm thấy kết quả
            return null; 
        } finally {
            enma.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.email = :email";
            Long count = enma.createQuery(jpql, Long.class)
                             .setParameter("email", email)
                             .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.userName = :username";
            Long count = enma.createQuery(jpql, Long.class)
                             .setParameter("username", username)
                             .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT count(u) FROM User u WHERE u.phone = :phone";
            Long count = enma.createQuery(jpql, Long.class)
                             .setParameter("phone", phone)
                             .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            return false;
        } finally {
            enma.close();
        }
    }
}