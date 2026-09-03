<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận mã OTP đặt lại mật khẩu</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f4f6f9;
        font-family: Arial, sans-serif;
    }
    .otp-container {
        max-width: 440px;
        margin: 70px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .otp-title {
        text-align: center;
        margin-bottom: 20px;
        font-weight: bold;
        color: #333;
    }
    .otp-input {
        letter-spacing: 6px;
        font-size: 24px;
        text-align: center;
        font-weight: bold;
    }
    .btn-verify {
        width: 100%;
        background-color: #f0ad4e;
        border: none;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        color: white;
    }
    .btn-verify:hover {
        background-color: #ec971f;
        color: white;
    }
</style>
</head>
<body>
<div class="container">
    <div class="otp-container">
        <div style="text-align: center; margin-bottom: 15px;">
            <i class="fa fa-shield" style="font-size: 48px; color: #f0ad4e;"></i>
        </div>
        <h2 class="otp-title">Xác Nhận Mã OTP</h2>
        <p class="text-center text-muted" style="font-size: 13px; margin-bottom: 20px;">
            Vui lòng nhập mã OTP 6 chữ số vừa được gửi đến email của bạn để tiếp tục đặt lại mật khẩu.
        </p>

        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="margin-bottom: 15px;">${alert}</div>
        </c:if>

        <c:if test="${sessionScope.message != null}">
            <div class="alert alert-success" style="margin-bottom: 15px;">${sessionScope.message}</div>
        </c:if>

        <c:if test="${sessionScope.otpNotice != null}">
            <div class="alert alert-info" style="margin-bottom: 15px; font-size: 13px;">
                <i class="fa fa-info-circle"></i> ${sessionScope.otpNotice}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-forgot-otp" method="post">
            <div class="form-group">
                <label>Email xác nhận:</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" name="email" value="${email}" class="form-control" readonly required>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 25px;">
                <label>Mã OTP (6 chữ số):</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-key"></i></span>
                    <input type="text" name="otp" class="form-control otp-input" maxlength="6" placeholder="------" required autofocus autocomplete="off">
                </div>
            </div>

            <button type="submit" class="btn btn-verify">
                <i class="fa fa-arrow-right"></i> Tiếp tục
            </button>
        </form>

        <div style="text-align: center; margin-top: 20px; font-size: 13px;">
            <a href="${pageContext.request.contextPath}/forgot-password" style="color: #777;">
                <i class="fa fa-arrow-left"></i> Nhập lại email khác
            </a>
        </div>
    </div>
</div>
</body>
</html>