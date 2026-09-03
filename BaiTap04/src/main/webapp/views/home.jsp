<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ - Cửa hàng</title>
<!-- Sử dụng Bootstrap 3/4 cho đẹp mắt -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <!-- Thanh Menu Header đơn giản cho khách -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>">ShoppingServletServiceMVC</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${sessionScope.account == null}">
                    <li><a href="<c:url value='/login'/>"><span class="glyphicon glyphicon-log-in"></span> Đăng nhập</a></li>
                    <li><a href="<c:url value='/register'/>"><span class="glyphicon glyphicon-user"></span> Đăng ký</a></li>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <li><a>Xin chào, <b>${sessionScope.account.fullName}</b></a></li>
                    <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <!-- Nội dung chính: Hiển thị danh mục sản phẩm cho khách -->
    <div class="container" style="margin-top: 30px;">
        <h2 style="color: #0099ff; font-weight: bold;">Danh mục sản phẩm</h2>
        <hr>
        
        <div class="row">
            <!-- Duyệt qua danh sách danh mục truyền từ Controller sang -->
            <c:forEach items="${cateList}" var="cate">
                <div class="col-md-3" style="margin-bottom: 20px;">
                    <div class="thumbnail" style="text-align: center; padding: 15px;">
                        <!-- Hiển thị hình ảnh icon danh mục -->
                        <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                        <img src="${imgUrl}" alt="Category Image" style="height: 120px; width: 100%; object-fit: cover; border-radius: 4px;">
                        
                        <div class="caption">
                            <h3 style="font-size: 18px; font-weight: bold;">${cate.name}</h3>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>