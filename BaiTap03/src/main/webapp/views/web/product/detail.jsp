<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.productName} - Chi tiết sản phẩm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
    }
    .detail-container {
        background: #ffffff;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.06);
        margin-bottom: 40px;
    }
    .product-img-box {
        text-align: center;
        border: 1px solid #eee;
        border-radius: 8px;
        padding: 20px;
        background-color: #fff;
    }
    .product-img-large {
        max-height: 400px;
        max-width: 100%;
        object-fit: contain;
    }
    .product-title {
        font-size: 26px;
        font-weight: bold;
        color: #222;
        margin-top: 0;
        margin-bottom: 15px;
    }
    .product-price-box {
        background-color: #fbfbfb;
        padding: 15px 20px;
        border-radius: 6px;
        margin-bottom: 20px;
    }
    .price-text {
        font-size: 28px;
        font-weight: bold;
        color: #d9534f;
    }
    .meta-row {
        margin-bottom: 12px;
        font-size: 15px;
    }
    .meta-label {
        font-weight: bold;
        color: #555;
        width: 140px;
        display: inline-block;
    }
    .related-card {
        background: #fff;
        border: 1px solid #eee;
        border-radius: 6px;
        padding: 10px;
        text-align: center;
        transition: transform 0.2s;
        height: 250px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .related-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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
        
        <ol class="breadcrumb" style="background-color: #fff;">
            <li><a href="<c:url value='/home'/>">Trang chủ</a></li>
            <li><a href="<c:url value='/product'/>">Sản phẩm</a></li>
            <c:if test="${product.category != null}">
                <li><a href="<c:url value='/product?cateId=${product.category.categoryId}'/>">${product.category.categoryname}</a></li>
            </c:if>
            <li class="active">${product.productName}</li>
        </ol>

        <div class="detail-container">
            <div class="row">
                
                <div class="col-md-5">
                    <div class="product-img-box">
                        <c:if test="${not empty product.images}">
                            <img src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}" class="product-img-large">
                        </c:if>
                        <c:if test="${empty product.images}">
                            <div style="padding: 70px 20px; color: #bbb;">
                                <i class="fa fa-picture-o fa-5x"></i>
                                <p style="margin-top: 15px; font-size: 14px;">Sản phẩm chưa có hình ảnh</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                
                <div class="col-md-7">
                    <h1 class="product-title">${product.productName}</h1>

                    <div class="product-price-box">
                        <span style="font-size: 14px; color: #777;">Giá sản phẩm: </span><br>
                        <span class="price-text">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                        </span>
                    </div>

                    <div class="meta-row">
                        <span class="meta-label"><i class="fa fa-folder-open text-muted"></i> Danh mục:</span>
                        <c:if test="${product.category != null}">
                            <a href="<c:url value='/product?cateId=${product.category.categoryId}'/>" class="label label-info" style="font-size: 13px;">
                                ${product.category.categoryname}
                            </a>
                        </c:if>
                        <c:if test="${product.category == null}">
                            <span class="text-muted">Chưa phân loại</span>
                        </c:if>
                    </div>

                    <div class="meta-row">
                        <span class="meta-label"><i class="fa fa-archive text-muted"></i> Tình trạng:</span>
                        <c:if test="${product.quantity > 0}">
                            <span class="label label-success">Còn hàng (${product.quantity} sản phẩm)</span>
                        </c:if>
                        <c:if test="${product.quantity <= 0}">
                            <span class="label label-danger">Hết hàng</span>
                        </c:if>
                    </div>

                    <div class="meta-row">
                        <span class="meta-label"><i class="fa fa-calendar text-muted"></i> Ngày đăng:</span>
                        <span><fmt:formatDate value="${product.createdDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </div>

                    <div class="meta-row">
                        <span class="meta-label"><i class="fa fa-check-circle text-muted"></i> Trạng thái:</span>
                        <c:if test="${product.status == 1}">
                            <span class="text-success">Đang hoạt động</span>
                        </c:if>
                        <c:if test="${product.status == 0}">
                            <span class="text-danger">Tạm ngừng bán</span>
                        </c:if>
                    </div>

                    <hr>

                    <div style="margin-bottom: 25px;">
                        <h4 style="font-weight: bold; color: #333;"><i class="fa fa-align-left"></i> Mô tả sản phẩm:</h4>
                        <div style="font-size: 14px; color: #555; line-height: 1.7; background-color: #fafafa; padding: 15px; border-radius: 6px; border: 1px solid #f0f0f0;">
                            <c:if test="${not empty product.description}">
                                <p style="white-space: pre-line;">${product.description}</p>
                            </c:if>
                            <c:if test="${empty product.description}">
                                <p class="text-muted">Chưa có mô tả chi tiết cho sản phẩm này.</p>
                            </c:if>
                        </div>
                    </div>

                    
                    <div>
                        <a href="<c:url value='/product'/>" class="btn btn-primary" style="margin-right: 10px;">
                            <i class="fa fa-arrow-left"></i> Quay lại danh sách sản phẩm
                        </a>
                        <a href="<c:url value='/home'/>" class="btn btn-default">
                            <i class="fa fa-home"></i> Về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        
        <c:if test="${not empty relatedProducts}">
            <div style="margin-top: 30px; margin-bottom: 40px;">
                <h3 style="font-weight: bold; color: #333; margin-bottom: 20px;">
                    <i class="fa fa-tags"></i> Sản phẩm cùng danh mục
                </h3>
                <div class="row">
                    <c:forEach items="${relatedProducts}" var="rp">
                        <c:if test="${rp.productId != product.productId}">
                            <div class="col-xs-6 col-md-3" style="margin-bottom: 20px;">
                                <div class="related-card">
                                    <div style="height: 120px; display: flex; align-items: center; justify-content: center; overflow: hidden; background-color: #fafafa;">
                                        <c:if test="${not empty rp.images}">
                                            <img src="<c:url value='/image?fname=${rp.images}'/>" alt="${rp.productName}" style="max-height: 100%; max-width: 100%; object-fit: cover;">
                                        </c:if>
                                        <c:if test="${empty rp.images}">
                                            <span class="text-muted" style="font-size: 11px;"><i class="fa fa-picture-o"></i> Không có ảnh</span>
                                        </c:if>
                                    </div>
                                    <div>
                                        <h5 style="font-weight: bold; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-bottom: 5px;">
                                            <a href="<c:url value='/product/detail?id=${rp.productId}'/>" title="${rp.productName}" style="color: #333;">
                                                ${rp.productName}
                                            </a>
                                        </h5>
                                        <p style="color: #d9534f; font-weight: bold; margin-bottom: 8px;">
                                            <fmt:formatNumber value="${rp.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                        </p>
                                        <a href="<c:url value='/product/detail?id=${rp.productId}'/>" class="btn btn-default btn-xs btn-block">
                                            Xem ngay
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>