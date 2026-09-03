<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <!-- Thanh Header phía trên -->
    <nav class="navbar navbar-inverse" style="border-radius: 0; margin-bottom: 0;">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>">Trang chủ Admin</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="<c:url value='/admin/categories'/>"><i class="glyphicon glyphicon-folder-open"></i> Quản lý danh mục</a></li>
                <li><a href="<c:url value='/admin/products'/>"><i class="glyphicon glyphicon-th-large"></i> Quản lý sản phẩm</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>Xin chào, <b>admin</b></a></li>
                <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
            </ul>
        </div>
    </nav>

    <!-- Nội dung chính được mở rộng toàn màn hình (col-md-12) sau khi đã bỏ menu bên trái -->
    <div class="container" style="margin-top: 30px; width: 95%;">
        <div class="panel panel-default">
            <div class="panel-heading" style="background-color: #f5f5f5;">
                <h3 style="color: #d9534f; font-weight: bold; margin-top: 5px;">Quản lý danh mục</h3>
                <p class="text-muted">Nơi bạn có thể quản lý danh mục sản phẩm của mình</p>
            </div>
            <div class="panel-body">
                <!-- Nút thêm mới -->
                <a href="<c:url value='/admin/category/add'/>" class="btn btn-success" style="margin-bottom: 15px;">
                    <span class="glyphicon glyphicon-plus"></span> Thêm danh mục mới
                </a>

                <!-- Bảng hiển thị danh sách -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead style="background-color: #f9f9f9;">
                            <tr>
                                <th style="width: 80px; text-align: center;">STT</th>
                                <th style="width: 150px; text-align: center;">Hình ảnh</th>
                                <th>Tên danh mục</th>
                                <th style="width: 150px; text-align: center;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                <tr>
                                    <td style="text-align: center; vertical-align: middle;">${STT.index + 1}</td>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <c:if test="${not empty cate.icon}">
                                            <img src="<c:url value='/image?fname=${cate.icon}'/>" alt="Icon" style="height: 50px; width: 50px; object-fit: cover; border-radius: 4px;">
                                        </c:if>
                                        <c:if test="${empty cate.icon}">
                                            <span>Không có ảnh</span>
                                        </c:if>
                                    </td>
                                    <td style="vertical-align: middle; font-weight: 500;">${cate.name}</td>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-primary btn-sm">Sửa</a>
                                        <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty cateList}">
                                <tr>
                                    <td colspan="4" style="text-align: center; color: #888;">Chưa có danh mục nào trong hệ thống.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>