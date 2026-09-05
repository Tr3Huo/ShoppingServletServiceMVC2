<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .profile-container {
            margin-top: 50px;
            margin-bottom: 50px;
        }
        .profile-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            border-top: 5px solid #00a8e6;
        }
        .profile-img-container {
            position: relative;
            width: 160px;
            height: 160px;
            margin: 0 auto 20px;
        }
        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        .profile-img:hover {
            transform: scale(1.05);
        }
        .upload-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #00a8e6;
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            transition: background 0.3s;
        }
        .upload-btn:hover {
            background: #008fca;
        }
        .form-control {
            border-radius: 6px;
            height: 42px;
            box-shadow: none;
            border-color: #dce1e5;
        }
        .form-control:focus {
            border-color: #00a8e6;
            box-shadow: 0 0 5px rgba(0, 168, 230, 0.3);
        }
        .btn-update {
            background-color: #00a8e6;
            color: white;
            border-radius: 30px;
            padding: 10px 30px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            transition: all 0.3s;
        }
        .btn-update:hover {
            background-color: #008fca;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .control-label {
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <!-- Navbar Header -->
    <nav class="navbar navbar-default" style="border-radius: 0; margin-bottom: 0; box-shadow: 0 2px 4px rgba(0,0,0,0.08);">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value='/home'/>" style="color: #00a8e6; font-weight: bold;">Shopping MVC</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="<c:url value='/home'/>"><i class="fa fa-home"></i> Trang chủ</a></li>
                <li><a href="<c:url value='/product'/>"><i class="fa fa-cubes"></i> Tất cả sản phẩm</a></li>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li><a href="<c:url value='/admin/categories'/>"><i class="fa fa-cogs"></i> Quản trị Admin</a></li>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <li class="active"><a href="<c:url value='/profile'/>"><i class="fa fa-id-card"></i> Hồ sơ của tôi</a></li>
                </c:if>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${sessionScope.account == null}">
                    <li><a href="<c:url value='/login'/>"><span class="glyphicon glyphicon-log-in"></span> Đăng nhập</a></li>
                    <li><a href="<c:url value='/register'/>"><span class="glyphicon glyphicon-user"></span> Đăng ký</a></li>
                </c:if>
                <c:if test="${sessionScope.account != null}">
                    <li><a href="<c:url value='/profile'/>">Xin chào, <b>${sessionScope.account.fullName}</b></a></li>
                    <li><a href="<c:url value='/logout'/>"><span class="glyphicon glyphicon-log-out"></span> Đăng xuất</a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container profile-container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="profile-card">
                    <h2 class="text-center" style="color: #333; font-weight: bold; margin-bottom: 30px;">
                        Hồ Sơ Của Tôi
                    </h2>
                    
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <i class="fa fa-check-circle"></i> ${message}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <i class="fa fa-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <!-- Avatar Column -->
                            <div class="col-md-4 text-center">
                                <div class="profile-img-container">
                                    <c:choose>
                                        <c:when test="${not empty user.images}">
                                            <img src="<c:url value='/image?fname=${user.images}'/>" alt="Avatar" class="profile-img" id="previewImg">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://ui-avatars.com/api/?name=${user.fullName}&background=00a8e6&color=fff&size=150" alt="Default Avatar" class="profile-img" id="previewImg">
                                        </c:otherwise>
                                    </c:choose>
                                    <label for="images" class="upload-btn" title="Đổi ảnh đại diện">
                                        <i class="fa fa-camera"></i>
                                    </label>
                                    <input type="file" id="images" name="images" style="display: none;" accept="image/*" onchange="previewFile()">
                                </div>
                                <h4 style="font-weight: bold; color: #333; margin-top: 15px;">${user.fullName}</h4>
                                <p class="text-muted"><i class="fa fa-envelope-o"></i> ${user.email}</p>
                            </div>
                            
                            <!-- Info Column -->
                            <div class="col-md-8">
                                <h4 style="border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 20px; font-weight: 600; color: #00a8e6;">Thông tin cơ bản</h4>
                                
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <label class="control-label">Tên đăng nhập (Username)</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <input type="text" class="form-control" value="${user.userName}" readonly style="background-color: #f9f9f9;">
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label class="control-label">Email đăng ký</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                            <input type="email" class="form-control" value="${user.email}" readonly style="background-color: #f9f9f9;">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label">Họ và Tên (Fullname) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-id-badge"></i></span>
                                        <input type="text" class="form-control" name="fullname" value="${user.fullName}" required placeholder="Nhập họ và tên đầy đủ">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label">Số điện thoại (Phone)</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                        <input type="text" class="form-control" name="phone" value="${user.phone}" placeholder="Nhập số điện thoại liên hệ">
                                    </div>
                                </div>
                                
                                <div class="text-right" style="margin-top: 30px;">
                                    <button type="submit" class="btn btn-update">
                                        <i class="fa fa-save"></i> Cập Nhật Hồ Sơ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script>
        function previewFile() {
            const preview = document.getElementById('previewImg');
            const file = document.querySelector('input[type=file]').files[0];
            const reader = new FileReader();

            reader.addEventListener("load", function () {
                preview.src = reader.result;
            }, false);

            if (file) {
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>
