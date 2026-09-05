<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm sản phẩm mới</title>
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
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title" style="font-weight: bold;"><i class="fa fa-plus-circle"></i> Thêm Sản Phẩm Mới</h3>
            </div>
            <div class="panel-body">
                <form role="form" action="<c:url value='/admin/product/add'/>" method="post" enctype="multipart/form-data" onsubmit="var btn = document.getElementById('btnSubmit'); if(btn.getAttribute('data-submitting') === 'true') { return false; } btn.setAttribute('data-submitting', 'true'); btn.disabled = true; btn.innerHTML='<i class=\'fa fa-spinner fa-spin\'></i> Đang lưu...'; return true;">
                    <div class="form-group">
                        <label>Tên sản phẩm: <span class="text-danger">*</span></label> 
                        <input type="text" class="form-control" placeholder="Nhập tên sản phẩm" name="productName" required />
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Danh mục: <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-control" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.categoryId}">${cat.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Trạng thái:</label>
                                <select name="status" class="form-control">
                                    <option value="1">Đang kinh doanh</option>
                                    <option value="0">Tạm dừng kinh doanh</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Giá bán (VNĐ): <span class="text-danger">*</span></label> 
                                <input type="number" step="1000" min="0" class="form-control" placeholder="Ví dụ: 150000" name="price" required />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Số lượng tồn kho: <span class="text-danger">*</span></label> 
                                <input type="number" min="0" class="form-control" placeholder="Ví dụ: 100" name="quantity" required />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Hình ảnh sản phẩm (Không bắt buộc):</label> 
                        <input type="file" name="image" class="form-control" accept="image/*" />
                        <p class="help-block text-muted">Không bắt buộc đính kèm ảnh. Hỗ trợ các định dạng .jpg, .jpeg, .png, .webp.</p>
                    </div>

                    <div class="form-group">
                        <label>Mô tả chi tiết sản phẩm:</label> 
                        <textarea name="description" class="form-control" rows="5" placeholder="Nhập mô tả chi tiết về tính năng, công dụng sản phẩm..."></textarea>
                    </div>

                    <div style="margin-top: 25px;">
                        <button type="submit" id="btnSubmit" class="btn btn-success">
                            <i class="fa fa-save"></i> Lưu sản phẩm
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