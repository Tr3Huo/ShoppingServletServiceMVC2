<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý sản phẩm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <!-- Thanh Header Admin -->
    <nav class="navbar navbar-inverse" style="border-radius: 0; margin-bottom: 0;">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>">Shop MVC Trang Chủ</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="<c:url value='/admin/categories'/>"><i class="fa fa-folder"></i> Quản lý danh mục</a></li>
                <li class="active"><a href="<c:url value='/admin/products'/>"><i class="fa fa-cubes"></i> Quản lý sản phẩm</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>Xin chào, <b>${sessionScope.account != null ? sessionScope.account.fullName : 'Admin'}</b></a></li>
                <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
            </ul>
        </div>
    </nav>

    <!-- Nội dung chính -->
    <div class="container" style="margin-top: 25px; width: 95%;">
        <div class="panel panel-default">
            <div class="panel-heading" style="background-color: #f5f5f5; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="color: #00a8e6; font-weight: bold; margin-top: 5px;">Danh sách sản phẩm</h3>
                    <p class="text-muted" style="margin-bottom: 0;">Quản lý toàn bộ thông tin sản phẩm của hệ thống</p>
                </div>
                <div>
                    <a href="<c:url value='/admin/product/add'/>" class="btn btn-success">
                        <i class="fa fa-plus"></i> Thêm sản phẩm mới
                    </a>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead style="background-color: #f9f9f9;">
                            <tr>
                                <th style="width: 50px; text-align: center;">STT</th>
                                <th style="width: 90px; text-align: center;">Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th style="width: 140px;">Danh mục</th>
                                <th style="width: 120px; text-align: right;">Giá (VNĐ)</th>
                                <th style="width: 80px; text-align: center;">Số lượng</th>
                                <th style="width: 100px; text-align: center;">Trạng thái</th>
                                <th style="width: 140px; text-align: center;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productList}" var="prod" varStatus="STT">
                                <tr>
                                    <td style="text-align: center; vertical-align: middle;">${STT.index + 1}</td>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <c:if test="${not empty prod.images}">
                                            <img src="<c:url value='/image?fname=${prod.images}'/>" alt="${prod.productName}" style="height: 55px; width: 55px; object-fit: cover; border-radius: 4px;">
                                        </c:if>
                                        <c:if test="${empty prod.images}">
                                            <span class="text-muted">Không có ảnh</span>
                                        </c:if>
                                    </td>
                                    <td style="vertical-align: middle; font-weight: 600;">
                                        <a href="<c:url value='/product/detail?id=${prod.productId}'/>" target="_blank" title="Xem trên web">
                                            ${prod.productName}
                                        </a>
                                    </td>
                                    <td style="vertical-align: middle;">
                                        <span class="label label-info">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; font-weight: bold; color: #d9534f;">
                                        <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                    </td>
                                    <td style="text-align: center; vertical-align: middle;">${prod.quantity}</td>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <c:if test="${prod.status == 1}">
                                            <span class="label label-success">Đang bán</span>
                                        </c:if>
                                        <c:if test="${prod.status == 0}">
                                            <span class="label label-default">Tạm dừng</span>
                                        </c:if>
                                    </td>
                                    <td style="text-align: center; vertical-align: middle;">
                                        <a href="<c:url value='/admin/product/edit?id=${prod.productId}'/>" class="btn btn-primary btn-sm">
                                            <i class="fa fa-pencil"></i> Sửa
                                        </a>
                                        <a href="<c:url value='/admin/product/delete?id=${prod.productId}'/>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
                                            <i class="fa fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty productList}">
                                <tr>
                                    <td colspan="8" style="text-align: center; padding: 25px; color: #888;">Chưa có sản phẩm nào trong hệ thống. Hãy thêm sản phẩm mới!</td>
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