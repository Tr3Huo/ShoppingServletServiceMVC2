<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách sản phẩm - Shop MVC</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
    }
    .product-card {
        background: #ffffff;
        border: 1px solid #e5e5e5;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 25px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        height: 390px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .product-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.12);
        border-color: #00a8e6;
    }
    .product-img-container {
        height: 200px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 6px;
        background-color: #fdfdfd;
    }
    .product-img {
        max-height: 100%;
        max-width: 100%;
        object-fit: cover;
        transition: transform 0.3s;
    }
    .product-card:hover .product-img {
        transform: scale(1.05);
    }
    .product-title {
        font-size: 16px;
        font-weight: bold;
        margin: 12px 0 6px;
        height: 42px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    .product-title a {
        color: #333;
        text-decoration: none;
    }
    .product-title a:hover {
        color: #00a8e6;
    }
    .product-price {
        font-size: 18px;
        font-weight: bold;
        color: #d9534f;
        margin-bottom: 10px;
    }
    .btn-detail {
        background-color: #00a8e6;
        color: #ffffff;
        border-radius: 4px;
        font-weight: 600;
        width: 100%;
    }
    .btn-detail:hover {
        background-color: #008fca;
        color: #ffffff;
    }
    .sidebar-list a {
        display: block;
        padding: 10px 15px;
        border-bottom: 1px solid #eee;
        color: #555;
        text-decoration: none;
    }
    .sidebar-list a:hover, .sidebar-list a.active {
        background-color: #00a8e6;
        color: white;
        font-weight: bold;
    }
</style>
</head>
<body>
    
    <nav class="navbar navbar-default" style="border-radius: 0; margin-bottom: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.08);">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>" style="color: #00a8e6; font-weight: bold;">Shopping MVC</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="<c:url value='/home'/>"><i class="fa fa-home"></i> Trang chủ</a></li>
                <li class="active"><a href="<c:url value='/product'/>"><i class="fa fa-cubes"></i> Tất cả sản phẩm</a></li>
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

    
    <div class="container">
        <div class="row">
            
            <div class="col-md-3">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background-color: #00a8e6; color: white; font-weight: bold;">
                        <i class="fa fa-list"></i> Danh mục sản phẩm
                    </div>
                    <div class="sidebar-list">
                        <a href="<c:url value='/product'/>" class="${selectedCateId == null ? 'active' : ''}">
                            <i class="fa fa-angle-right"></i> Tất cả sản phẩm
                        </a>
                        <c:forEach items="${cateList}" var="c">
                            <a href="<c:url value='/product?cateId=${c.categoryId}'/>" class="${selectedCateId == c.categoryId ? 'active' : ''}">
                                <i class="fa fa-angle-right"></i> ${c.categoryname}
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <div class="panel panel-info" style="margin-top: 20px;">
                    <div class="panel-heading" style="font-weight: bold;">
                        <i class="fa fa-info-circle"></i> Thống kê
                    </div>
                    <div class="panel-body">
                        <p>Tổng số sản phẩm: <b>${totalProducts}</b></p>
                        <p>Trang hiện tại: <b>${currentPage} / ${totalPages}</b></p>
                    </div>
                </div>
            </div>

            
            <div class="col-md-9">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3 style="margin: 0; color: #333; font-weight: bold;">
                        <i class="fa fa-shopping-bag"></i> Danh Sách Sản Phẩm
                    </h3>
                    <span class="text-muted">Hiển thị trang ${currentPage} / ${totalPages} (Tổng: ${totalProducts} sản phẩm)</span>
                </div>

                
                <div class="row">
                    <c:forEach items="${productList}" var="prod">
                        <div class="col-sm-6 col-md-4">
                            <div class="product-card">
                                <div>
                                    <div class="product-img-container">
                                        <a href="<c:url value='/product/detail?id=${prod.productId}'/>">
                                            <c:if test="${not empty prod.images}">
                                                <img src="<c:url value='/image?fname=${prod.images}'/>" alt="${prod.productName}" class="product-img">
                                            </c:if>
                                            <c:if test="${empty prod.images}">
                                                <div style="height: 100%; display: flex; align-items: center; justify-content: center; color: #aaa; flex-direction: column; background-color: #f9f9f9;">
                                                    <i class="fa fa-picture-o" style="font-size: 42px; margin-bottom: 6px;"></i>
                                                    <span style="font-size: 12px;">Không có ảnh</span>
                                                </div>
                                            </c:if>
                                        </a>
                                    </div>
                                    <h4 class="product-title">
                                        <a href="<c:url value='/product/detail?id=${prod.productId}'/>" title="${prod.productName}">
                                            ${prod.productName}
                                        </a>
                                    </h4>
                                    <div>
                                        <span class="label label-info">${prod.category != null ? prod.category.categoryname : 'Chưa phân loại'}</span>
                                    </div>
                                </div>

                                <div>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                    </div>
                                    <a href="<c:url value='/product/detail?id=${prod.productId}'/>" class="btn btn-detail">
                                        <i class="fa fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty productList}">
                        <div class="col-md-12">
                            <div class="alert alert-warning text-center" style="padding: 30px;">
                                <i class="fa fa-exclamation-triangle" style="font-size: 36px; margin-bottom: 10px;"></i>
                                <p style="font-size: 16px;">Hiện chưa có sản phẩm nào thuộc mục này!</p>
                            </div>
                        </div>
                    </c:if>
                </div>

                
                <c:if test="${totalPages > 1}">
                    <div style="text-align: center; margin-top: 20px; margin-bottom: 40px;">
                        <ul class="pagination">
                            
                            <c:if test="${currentPage > 1}">
                                <li>
                                    <a href="<c:url value='/product?page=${currentPage - 1}${selectedCateId != null ? \"&cateId=\" : \"\"}${selectedCateId != null ? selectedCateId : \"\"}'/>" aria-label="Previous">
                                        <span aria-hidden="true">&laquo; Trước</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${currentPage == 1}">
                                <li class="disabled"><span>&laquo; Trước</span></li>
                            </c:if>

                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="${currentPage == i ? 'active' : ''}">
                                    <a href="<c:url value='/product?page=${i}${selectedCateId != null ? \"&cateId=\" : \"\"}${selectedCateId != null ? selectedCateId : \"\"}'/>">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            
                            <c:if test="${currentPage < totalPages}">
                                <li>
                                    <a href="<c:url value='/product?page=${currentPage + 1}${selectedCateId != null ? \"&cateId=\" : \"\"}${selectedCateId != null ? selectedCateId : \"\"}'/>" aria-label="Next">
                                        <span aria-hidden="true">Sau &raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${currentPage == totalPages}">
                                <li class="disabled"><span>Sau &raquo;</span></li>
                            </c:if>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>