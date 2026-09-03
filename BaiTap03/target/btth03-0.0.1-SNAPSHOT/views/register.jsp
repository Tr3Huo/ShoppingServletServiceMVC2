<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký tài khoản</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f4f6f9;
        font-family: Arial, sans-serif;
    }
    .register-container {
        max-width: 480px;
        margin: 50px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .register-title {
        text-align: center;
        margin-bottom: 25px;
        font-weight: bold;
        color: #333;
    }
    .btn-register {
        width: 100%;
        background-color: #00a8e6;
        border: none;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        margin-top: 10px;
    }
    .btn-register:hover {
        background-color: #008fca;
    }
</style>
</head>
<body>
<div class="container">
    <div class="register-container">
        <h2 class="register-title">Tạo Tài Khoản Mới</h2>

        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="margin-bottom: 15px;">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <!-- 1. Tài khoản -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span> 
                    <input type="text" placeholder="Tên tài khoản" name="username" class="form-control" required>
                </div>
            </div>

            <!-- 2. Họ tên -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-id-card"></i></span> 
                    <input type="text" placeholder="Họ và tên" name="fullname" class="form-control" required>
                </div>
            </div>

            <!-- 3. Nhập Email -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span> 
                    <input type="email" placeholder="Email" name="email" class="form-control" required>
                </div>
            </div>

            <!-- 4. Số điện thoại -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span> 
                    <input type="text" placeholder="Số điện thoại" name="phone" class="form-control" required>
                </div>
            </div>

            <!-- 5. Mật khẩu -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span> 
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
                </div>
            </div>

            <!-- 6. Nhập lại mật khẩu -->
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span> 
                    <input type="password" placeholder="Nhập lại mật khẩu" name="repassword" class="form-control" required>
                </div>
            </div>

            <!-- Nút Tạo tài khoản -->
            <button type="submit" class="btn btn-primary btn-register">
                <i class="fa fa-user-plus"></i> Tạo tài khoản
            </button>

            <!-- Link chuyển về trang đăng nhập -->
            <div style="text-align: center; margin-top: 20px; font-size: 13px; color: #777;">
                <p>Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
            </div>
        </form>
    </div>
</div>
</body>
</html>