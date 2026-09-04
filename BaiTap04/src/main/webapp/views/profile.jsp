<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật Profile</title>
</head>
<body>
    <div class="profile-container">
        <h2>Chỉnh sửa thông tin cá nhân</h2>
        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${user.id}">
            
            <div class="form-group">
                <label>Họ và tên:</label>
                <input type="text" name="fullname" value="${user.fullname}" required>
            </div>
            
            <div class="form-group">
                <label>Số điện thoại:</label>
                <input type="text" name="phone" value="${user.phone}">
            </div>
            
            <div class="form-group">
                <label>Ảnh đại diện hiện tại:</label><br>
                <img src="${pageContext.request.contextPath}/uploads/${user.images}" alt="Avatar" width="150" height="150"><br>
                
                <label>Chọn ảnh mới:</label>
                <input type="file" name="images" accept="image/png, image/jpeg">
            </div>
            
            <button type="submit">Lưu thay đổi</button>
        </form>
    </div>
</body>
</html>