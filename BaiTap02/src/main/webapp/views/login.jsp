<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập hệ thống</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f4f6f9;
        font-family: Arial, sans-serif;
    }
    .login-container {
        max-width: 420px;
        margin: 80px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .login-title {
        text-align: center;
        margin-bottom: 25px;
        font-weight: bold;
        color: #333;
    }
    .btn-login {
        width: 100%;
        background-color: #00a8e6;
        border: none;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
    }
    .btn-login:hover {
        background-color: #008fca;
    }
</style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <h2 class="login-title">Đăng Nhập</h2>

        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="margin-bottom: 15px;">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span> 
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control" required>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 15px;">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span> 
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
                </div>
            </div>

            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <label class="checkbox-inline" style="color: #666;">
                    <input type="checkbox" name="remember" value="on"> Nhớ tôi
                </label>
                <a href="#" style="color: #777; font-size: 13px;">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-primary btn-login">
                <i class="fa fa-sign-in"></i> Đăng nhập
            </button>

            <div style="text-align: center; margin-top: 25px; font-size: 13px; color: #777;">
                <p>Nếu bạn chưa có tài khoản, hãy <a href="${pageContext.request.contextPath}/register">Đăng ký</a></p>
            </div>
        </form>
    </div>
</div>
</body>
</html>