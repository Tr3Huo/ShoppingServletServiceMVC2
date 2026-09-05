<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><decorator:title default="Trang chủ" /></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body { background-color: #f8f9fa; font-family: Arial, sans-serif; }
</style>
<decorator:head />
</head>
<body>
    <!-- Thanh Menu Header Sitemesh Decorator -->
    <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0; box-shadow: 0 2px 4px rgba(0,0,0,0.06);">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>" style="color: #00a8e6; font-weight: bold; font-size: 20px;">
                    <i class="fa fa-shopping-cart"></i> Shopping MVC
                </a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="<c:url value='/home'/>"><i class="fa fa-home"></i> Trang chủ</a></li>
                <li><a href="<c:url value='/product'/>"><i class="fa fa-cubes"></i> Tất cả sản phẩm</a></li>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li><a href="<c:url value='/admin/categories'/>"><i class="fa fa-cogs"></i> Quản trị Admin</a></li>
                </c:if>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${sessionScope.account == null}">
                    <li><a href="<c:url value='/login'/>"><span class="glyphicon glyphicon-log-in"></span> Đăng nhập</a></li>
                    <li><a href="<c:url value='/register'/>"><span class="glyphicon glyphicon-user"></span> Đăng ký</a></li>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <li class="active"><a href="<c:url value='/profile'/>">Xin chào, <b>${sessionScope.account.fullName}</b></a></li>
                    <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <!-- Nội dung chính được Sitemesh nhúng vào đây -->
    <decorator:body />
</body>
</html>
