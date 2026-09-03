<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="register" method="post">
	<h2>Tạo tài khoản mới</h2>
	
	<c:if test="${alert != null}">
		<h3 class="alert alert-danger">${alert}</h3>
	</c:if>
	
	<!-- 1. Tài khoản -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-user"></i></span> 
				<input type="text" placeholder="Tài khoản" name="username" class="form-control">
			</div>
		</label>
	</section>

	<!-- 2. Họ tên -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-user"></i></span> 
				<input type="text" placeholder="Họ tên" name="fullname" class="form-control">
			</div>
		</label>
	</section>

	<!-- 3. Nhập Email -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-envelope"></i></span> 
				<input type="email" placeholder="Nhập Email" name="email" class="form-control">
			</div>
		</label>
	</section>

	<!-- 4. Số điện thoại -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-phone"></i></span> 
				<input type="text" placeholder="Số điện thoại" name="phone" class="form-control">
			</div>
		</label>
	</section>

	<!-- 5. Mật khẩu -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-lock"></i></span> 
				<input type="password" placeholder="Mật khẩu" name="password" class="form-control">
			</div>
		</label>
	</section>

	<!-- 6. Nhập lại mật khẩu -->
	<section>
		<label class="input login-input">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-lock"></i></span> 
				<input type="password" placeholder="Nhập lại mật khẩu" name="repassword" class="form-control">
			</div>
		</label>
	</section>

	<!-- Nút Tạo tài khoản -->
	<section>
		<button type="submit" class="btn btn-primary" style="width: 100%; background-color: #00a8e6; border: none; padding: 10px; margin-top: 10px;">
			Tạo tài khoản
		</button>
	</section>

	<!-- Link chuyển về trang đăng nhập -->
	<div style="text-align: center; margin-top: 20px; font-size: 13px; color: #777;">
		<p>Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
	</div>
</form>