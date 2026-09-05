<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa danh mục</title>
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
        <h2>Chỉnh sửa danh mục</h2>
        
        <c:url value="/admin/category/edit" var="edit"></c:url>
        <form role="form" action="${edit}" method="post" enctype="multipart/form-data">
            <input name="id" value="${category.id}" type="hidden">
            
            <div class="form-group">
                <label>Tên danh mục:</label> 
                <input type="text" class="form-control" value="${category.name}" name="name" required />
            </div>
            
            <div class="form-group">
                <label>Ảnh đại diện hiện tại:</label><br>
                <c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
                <img class="img-responsive" width="100px" src="${imgUrl}" alt="Old Image" style="margin-bottom: 10px;"/><br>
                
                <label>Chọn ảnh mới (nếu muốn thay đổi):</label> 
                <input type="file" name="icon" class="form-control" />
            </div>
            
            <button type="submit" class="btn btn-primary">Cập nhật</button>
            <button type="reset" class="btn btn-default">Reset</button>
        </form>
        <br>
        <a href="<c:url value='/admin/categories'/>" class="btn btn-primary">Quay lại danh sách</a>
    </div>
</body>
</html>