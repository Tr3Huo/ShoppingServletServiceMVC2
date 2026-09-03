<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa sản phẩm</title>
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
        </div>
    </nav>

    <div class="container" style="margin-top: 30px; max-width: 800px;">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title" style="font-weight: bold;"><i class="fa fa-pencil-square-o"></i> Chỉnh Sửa Sản Phẩm (ID: ${product.productId})</h3>
            </div>
            <div class="panel-body">
                <form role="form" action="<c:url value='/admin/product/edit'/>" method="post" enctype="multipart/form-data" onsubmit="var btn = document.getElementById('btnUpdate'); if(btn.getAttribute('data-submitting') === 'true') { return false; } btn.setAttribute('data-submitting', 'true'); btn.disabled = true; btn.innerHTML='<i class=\'fa fa-spinner fa-spin\'></i> Đang cập nhật...'; return true;">
                    <input type="hidden" name="productId" value="${product.productId}" />

                    <div class="form-group">
                        <label>Tên sản phẩm: <span class="text-danger">*</span></label> 
                        <input type="text" class="form-control" name="productName" value="${product.productName}" required />
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Danh mục: <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-control" required>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.categoryId}" ${product.category != null && product.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                            ${cat.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Trạng thái:</label>
                                <select name="status" class="form-control">
                                    <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang kinh doanh</option>
                                    <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm dừng kinh doanh</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Giá bán (VNĐ): <span class="text-danger">*</span></label> 
                                <input type="number" step="1000" min="0" class="form-control" name="price" value="${product.price}" required />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Số lượng tồn kho: <span class="text-danger">*</span></label> 
                                <input type="number" min="0" class="form-control" name="quantity" value="${product.quantity}" required />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Hình ảnh hiện tại:</label><br>
                        <c:if test="${not empty product.images}">
                            <img src="<c:url value='/image?fname=${product.images}'/>" alt="${product.productName}" style="height: 100px; width: 100px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; margin-bottom: 10px;"/><br>
                        </c:if>
                        <c:if test="${empty product.images}">
                            <p class="text-muted">Chưa có ảnh</p>
                        </c:if>

                        <label>Chọn ảnh mới (nếu muốn thay đổi - Multipart Upload):</label> 
                        <input type="file" name="image" class="form-control" accept="image/*" />
                    </div>

                    <div class="form-group">
                        <label>Mô tả chi tiết sản phẩm:</label> 
                        <textarea name="description" class="form-control" rows="5">${product.description}</textarea>
                    </div>

                    <div style="margin-top: 25px;">
                        <button type="submit" id="btnUpdate" class="btn btn-primary">
                            <i class="fa fa-check"></i> Cập nhật sản phẩm
                        </button>
                        <a href="<c:url value='/admin/products'/>" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>