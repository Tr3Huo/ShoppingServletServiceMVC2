<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm danh mục mới</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-inverse" style="border-radius: 0; margin-bottom: 0;">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>">Shop MVC Trang Chủ</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="<c:url value='/admin/categories'/>">Quản lý danh mục</a></li>
                <li><a href="<c:url value='/admin/products'/>">Quản lý sản phẩm</a></li>
            </ul>
        </div>
    </nav>
    <div class="container" style="margin-top: 30px;">
        <h2>Thêm mới danh mục</h2>
        <form role="form" action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Tên danh mục:</label> 
                <input class="form-control" placeholder="Nhập tên danh mục" name="name" required />
            </div>
            <div class="form-group">
                <label>Ảnh đại diện:</label> 
                <input type="file" name="icon" class="form-control" />
            </div>
            <button type="submit" class="btn btn-success">Thêm</button>
            <button type="reset" class="btn btn-default">Hủy</button>
        </form>
        <br>
        <a href="<c:url value='/admin/categories'/>" class="btn btn-primary">Quay lại danh sách</a>
    </div>
</body>
</html>