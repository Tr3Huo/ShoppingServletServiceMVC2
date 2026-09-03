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
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userName = :username"; 
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("username", username);
            
            java.util.List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
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

    @Override
    public void update(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
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
    public User findByEmail(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.email = :email";
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("email", email);
            java.util.List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByUsernameOrEmail(String keyword) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userName = :keyword OR u.email = :keyword";
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("keyword", keyword);
            java.util.List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }
}