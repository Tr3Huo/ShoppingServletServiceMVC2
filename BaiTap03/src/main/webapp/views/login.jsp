<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="login" method="post">
	<h2 style="text-align: center; margin-bottom: 20px;">Đăng Nhập Vào Hệ Thống</h2>
	
	<c:if test="${alert != null}">
		<h3 class="alert alert-danger">${alert}</h3>
	</c:if>
	
	<section style="margin-bottom: 15px;">
		<label class="input login-input" style="width: 100%;">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-user"></i></span> 
				<input type="text" placeholder="Tài khoản" name="username" class="form-control" required>
			</div>
		</label>
	</section>

	<section style="margin-bottom: 15px;">
		<label class="input login-input" style="width: 100%;">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-lock"></i></span> 
				<input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
			</div>
		</label>
	</section>

	<section style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
		<label class="checkbox" style="font-weight: normal; color: #777;">
			<input type="checkbox" name="remember" value="on"> Nhớ tôi
		</label>
		<a href="#" style="color: #777; font-size: 13px;">Quên mật khẩu?</a>
	</section>

	<section>
		<button type="submit" class="btn btn-primary" style="width: 100%; background-color: #00a8e6; border: none; padding: 10px;">
			Đăng nhập
		</button>
	</section>
	
	<div style="text-align: center; margin-top: 30px; font-size: 13px; color: #777;">
		<p>Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a href="${pageContext.request.contextPath}/register">Đăng ký</a></p>
	</div>
</form>