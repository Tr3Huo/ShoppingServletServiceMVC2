<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f4f6f9;
        font-family: Arial, sans-serif;
    }
    .forgot-container {
        max-width: 440px;
        margin: 80px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .forgot-title {
        text-align: center;
        margin-bottom: 20px;
        font-weight: bold;
        color: #333;
    }
    .btn-submit {
        width: 100%;
        background-color: #00a8e6;
        border: none;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        color: white;
    }
    .btn-submit:hover {
        background-color: #008fca;
        color: white;
    }
</style>
</head>
<body>
<div class="container">
    <div class="forgot-container">
        <div style="text-align: center; margin-bottom: 15px;">
            <i class="fa fa-lock" style="font-size: 48px; color: #00a8e6;"></i>
        </div>
        <h2 class="forgot-title">Quên Mật Khẩu</h2>
        <p class="text-center text-muted" style="font-size: 13px; margin-bottom: 20px;">
            Nhập địa chỉ email liên kết với tài khoản của bạn để nhận mã OTP khôi phục mật khẩu.
        </p>

        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="margin-bottom: 15px;">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group" style="margin-bottom: 25px;">
                <label>Địa chỉ Email:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required autofocus>
                </div>
            </div>

            <button type="submit" class="btn btn-submit">
                <i class="fa fa-paper-plane"></i> Gửi mã OTP xác nhận
            </button>
        </form>

        <div style="text-align: center; margin-top: 25px; font-size: 13px;">
            <a href="${pageContext.request.contextPath}/login" style="color: #777;">
                <i class="fa fa-arrow-left"></i> Quay lại Đăng nhập
            </a>
        </div>
    </div>
</div>
</body>
</html>