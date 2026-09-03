<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu mới</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f4f6f9;
        font-family: Arial, sans-serif;
    }
    .reset-container {
        max-width: 440px;
        margin: 70px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .reset-title {
        text-align: center;
        margin-bottom: 20px;
        font-weight: bold;
        color: #333;
    }
    .btn-reset {
        width: 100%;
        background-color: #28a745;
        border: none;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        color: white;
    }
    .btn-reset:hover {
        background-color: #218838;
        color: white;
    }
</style>
</head>
<body>
<div class="container">
    <div class="reset-container">
        <div style="text-align: center; margin-bottom: 15px;">
            <i class="fa fa-unlock-alt" style="font-size: 48px; color: #28a745;"></i>
        </div>
        <h2 class="reset-title">Đặt Lại Mật Khẩu</h2>
        <p class="text-center text-muted" style="font-size: 13px; margin-bottom: 20px;">
            Mã OTP đã được xác thực thành công. Vui lòng thiết lập mật khẩu mới cho tài khoản của bạn.
        </p>

        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="margin-bottom: 15px;">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <div class="form-group" style="margin-bottom: 15px;">
                <label>Mật khẩu mới:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu mới" required autofocus>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 25px;">
                <label>Nhập lại mật khẩu mới:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" name="repassword" class="form-control" placeholder="Xác nhận mật khẩu mới" required>
                </div>
            </div>

            <button type="submit" class="btn btn-reset">
                <i class="fa fa-check"></i> Hoàn tất đổi mật khẩu
            </button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 13px;">
            <a href="${pageContext.request.contextPath}/login" class="text-muted">Hủy bỏ và quay lại Đăng nhập</a>
        </div>
    </div>
</div>
</body>
</html>