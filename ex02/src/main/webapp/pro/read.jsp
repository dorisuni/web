<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="row my-5 justify-content-center">
	<div class="col">
		<h1 class="text-center mb-3">상품정보</h1>
		<div class="card p-3">
			<h5>상품코드: ${vo.code}</h5>
			<h5>상품이름: ${vo.name}</h5>
			<h5>상품가격: <fmt:formatNumber value="${vo.price}" pattern="#,###원"/></h5>
			<h5>상품등록일: <fmt:formatDate value="${vo.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/></h5>
		</div>
		<div class="text-center my-3">
			<button class="btn btn-primary">수정</button>
			<button class="btn btn-danger">삭제</button>
		</div>
	</div>
</div>
<script>
	const code="${vo.code}";
	
	//수정버튼을 클릭한 경우
	$(".btn-primary").on("click", function(){
		location.href="/pro/update?code=" + code;	
	});
	
	//삭제버튼을 클릭한 경우
	$(".btn-danger").on("click", function(){
		if(confirm(code + "번 상품을 삭제하실래요?")){
			//삭제로이동
			location.href="/pro/delete?code=" + code;
		}
	});
</script>