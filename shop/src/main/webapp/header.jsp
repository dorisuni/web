<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
=======
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
<div class="row">
	<div class="col">
		<img src="/image/hanbit.png" width="100%" id="img_header">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
			<div class="container-fluid">
				<a class="navbar-brand" href="/">쇼핑몰</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/goods/search">상품검색</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/goods/list">상품목록</a>
						</li>
<<<<<<< HEAD
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/user/list">회원목록</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/cart/list">장바구니</a>
						</li>
					</ul>
					<ul class="navbar-nav  mb-2 mb-lg-0">
						<c:if test="${user==null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
							</li>
						</c:if>
						<c:if test="${user!=null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/read">${user.uname}님</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/logout">로그아웃</a>
							</li>
						</c:if>
					</ul>		
=======
						
					</ul>
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
				</div>
			</div>
		</nav>
	</div>
</div>