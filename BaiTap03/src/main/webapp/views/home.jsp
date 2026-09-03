<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
    }
    .hero-banner {
        background: linear-gradient(135deg, #00a8e6 0%, #0056b3 100%);
        color: white;
        padding: 40px 0;
        margin-bottom: 30px;
        text-align: center;
        border-radius: 0 0 10px 10px;
    }
    .section-title {
        color: #333;
        font-weight: bold;
        position: relative;
        margin-bottom: 25px;
        padding-bottom: 10px;
        border-bottom: 2px solid #00a8e6;
        display: inline-block;
    }
    .cate-box {
        background: white;
        border-radius: 8px;
        padding: 15px;
        text-align: center;
        transition: all 0.3s;
        border: 1px solid #eee;
        margin-bottom: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.04);
    }
    .cate-box:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        border-color: #00a8e6;
    }
    .cate-img {
        height: 100px;
        width: 100%;
        object-fit: cover;
        border-radius: 6px;
        margin-bottom: 10px;
    }
    .prod-card {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 25px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        height: 380px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .prod-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 18px rgba(0,0,0,0.12);
        border-color: #00a8e6;
    }
    .prod-img-box {
        height: 190px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 6px;
        background-color: #fafafa;
    }
    .prod-img {
        max-height: 100%;
        max-width: 100%;
        object-fit: cover;
        transition: transform 0.3s;
    }
    .prod-card:hover .prod-img {
        transform: scale(1.05);
    }
    .prod-title {
        font-size: 15px;
        font-weight: bold;
        margin: 10px 0 5px;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    .prod-title a {
        color: #2d3748;
        text-decoration: none;
    }
    .prod-title a:hover {
        color: #00a8e6;
    }
    .prod-price {
        font-size: 17px;
        font-weight: bold;
        color: #e53e3e;
        margin-bottom: 10px;
    }
    .btn-view {
        background-color: #00a8e6;
        color: white;
        border-radius: 4px;
        font-weight: bold;
        width: 100%;
        border: none;
        padding: 8px;
    }
    .btn-view:hover {
        background-color: #008fca;
        color: white;
    }
</style>
</head>
<body>
    <!-- Thanh Menu Header -->
    <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0; box-shadow: 0 2px 4px rgba(0,0,0,0.06);">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>" style="color: #00a8e6; font-weight: bold; font-size: 20px;">
                    <i class="fa fa-shopping-cart"></i> Shopping MVC
                </a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="<c:url value='/home'/>"><i class="fa fa-home"></i> Trang chủ</a></li>
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
                    <li><a>Xin chào, <b>${sessionScope.account.fullName}</b></a></li>
                    <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <!-- Banner chào mừng -->
    <div class="hero-banner">
        <div class="container">
            <h1 style="font-weight: bold; margin-bottom: 10px;">Chào Mừng Đến Với Shopping MVC</h1>
            <p style="font-size: 16px; opacity: 0.9;">Hệ thống mua sắm trực tuyến đa dạng sản phẩm chất lượng cao</p>
            <a href="<c:url value='/product'/>" class="btn btn-warning btn-lg" style="margin-top: 15px; font-weight: bold;">
                <i class="fa fa-shopping-bag"></i> Khám phá ngay
            </a>
        </div>
    </div>

    <div class="container">
        <!-- PHẦN 1: DANH MỤC SẢN PHẨM -->
        <div>
            <h3 class="section-title"><i class="fa fa-list"></i> Danh Mục Sản Phẩm</h3>
            <div class="row">
                <c:forEach items="${cateList}" var="cate">
                    <div class="col-xs-6 col-sm-4 col-md-3">
                        <div class="cate-box">
                            <a href="<c:url value='/product?cateId=${cate.id}'/>" style="text-decoration: none; color: inherit;">
                                <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                <img src="${imgUrl}" alt="${cate.name}" class="cate-img" onerror="this.src='<c:url value='/image?fname=default-product.png'/>'">
                                <h4 style="font-size: 16px; font-weight: bold; margin: 5px 0;">${cate.name}</h4>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <hr style="margin: 30px 0;">

        <!-- PHẦN 2: 10 SẢN PHẨM MỚI NHẤT (Requirement 4b & 4d) -->
        <div>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h3 class="section-title" style="margin-bottom: 0;">
                    <i class="fa fa-bolt" style="color: #f39c12;"></i> 10 Sản Phẩm Mới Nhất
                </h3>
                <a href="<c:url value='/product'/>" class="btn btn-link" style="color: #00a8e6; font-weight: bold;">
                    Xem tất cả sản phẩm <i class="fa fa-angle-double-right"></i>
                </a>
            </div>

            <div class="row">
                <c:forEach items="${top10Products}" var="prod">
                    <div class="col-xs-12 col-sm-6 col-md-3" style="padding: 10px;">
                        <div class="prod-card">
                            <div>
                                <!-- Bấm chuột vào hình ảnh sản phẩm để xem chi tiết -->
                                <div class="prod-img-box">
                                    <a href="<c:url value='/product/detail?id=${prod.productId}'/>">
                                        <c:if test="${not empty prod.images}">
                                            <img src="<c:url value='/image?fname=${prod.images}'/>" alt="${prod.productName}" class="prod-img">
                                        </c:if>
                                        <c:if test="${empty prod.images}">
                                            <div style="height: 100%; display: flex; align-items: center; justify-content: center; color: #aaa; flex-direction: column; background-color: #f9f9f9;">
                                                <i class="fa fa-picture-o" style="font-size: 42px; margin-bottom: 6px;"></i>
                                                <span style="font-size: 12px;">Không có ảnh</span>
                                            </div>
                                        </c:if>
                                    </a>
                                </div>

                                <!-- Bấm chuột vào tên sản phẩm để xem chi tiết -->
                                <h4 class="prod-title">
                                    <a href="<c:url value='/product/detail?id=${prod.productId}'/>" title="${prod.productName}">
                                        ${prod.productName}
                                    </a>
                                </h4>

                                <div>
                                    <span class="label label-info">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                                </div>
                            </div>

                            <div>
                                <div class="prod-price">
                                    <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                </div>
                                <a href="<c:url value='/product/detail?id=${prod.productId}'/>" class="btn btn-view">
                                    <i class="fa fa-eye"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty top10Products}">
                    <div class="col-md-12">
                        <div class="alert alert-info text-center" style="padding: 25px;">
                            <p style="font-size: 15px; margin: 0;">Hiện chưa có sản phẩm nào. Vui lòng đăng nhập quyền Quản trị viên (admin / 123) để thêm sản phẩm mới!</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Banner chuyển sang trang /product -->
        <div class="well text-center" style="margin: 40px 0; background-color: #eef6fc; border-color: #bce8f1;">
            <h4>Bạn muốn xem thêm nhiều sản phẩm khác?</h4>
            <a href="<c:url value='/product'/>" class="btn btn-primary">
                <i class="fa fa-th-large"></i> Đến trang tất cả sản phẩm
            </a>
        </div>
    </div>
</body>
</html>