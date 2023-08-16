<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	 .bi-suit-heart,  .bi-suit-heart-fill{
		cursor:pointer;
		color: red;
	}
	.bi {
		font-size:1.2rem;
	}

	#rcnt, #fcnt {
		font-size:0.7rem;
	}
</style>
<div class="row my-5  justify-content-center">
	<div class="col-md-10 col-lg-8">
		<h1 class="text-center mb-5">상품정보</h1>
		<div class="card p-5">
			<div class="row">
				<div class="col-lg-4 mb-5 text-center">
					<img src="${vo.image}" width="100%">
				</div>
				<div class="col">
					<div>상품코드: ${vo.gid}</div>
					<div>상품이름: ${vo.title}</div>
					<hr>
					<div class="my-2">상품가격: <fmt:formatNumber value="${vo.price}" pattern="#,###원"/></div>
					<div class="my-2">제조사: ${vo.maker}</div>
					<div class="my-2">상품등록일: ${vo.regDate}</div>
					<hr>
					<div class="row">
						<div class="col-6">
							<button class="btn btn-primary" id="btn-cart">장바구니</button>
						</div>
						<div class="col-6 text-end" id="count">
							<i id="heart" class="bi bi-suit-heart ms-3"></i>
							<span id="fcnt"></span>
							<i class="bi bi-chat-left-text ms-3"></i>
							<span id="rcnt"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="review.jsp"/>	
	</div>
</div>


<script>
	getFavorite();
	function getFavorite(){
		$.ajax({
			type:"get",
			url:"/favorite/read",
			data:{gid, uid},
			dataType:"json",
			success:function(data){
				console.log(data);
				$("#fcnt").html(data.fcnt);
				if(data.ucnt==1){
					$("#heart").addClass("bi-suit-heart-fill").removeClass("bi-suit-heart");
				}else{
					$("#heart").addClass("bi-suit-heart").removeClass("bi-suit-heart-fill");
				}
			}
		});
	}
	
	//빈하트를 클릭한 경우
	$("#count").on("click", ".bi-suit-heart" ,function(){
		if(uid=="") {
			location.href="/user/login?target=/goods/read?gid=" + gid;
		}else{
			if(confirm("좋아요!를 추가하실래요")){
				$.ajax({
					type:"get",
					url:"/favorite/insert",
					data:{gid, uid},
					success:function(){
						 getFavorite();
					}
				});
			}
		}		
	});
	
	//채운하트를 클릭한 경우
	$("#count").on("click", ".bi-suit-heart-fill", function(){
		if(confirm("좋아요!를 삭제하실래요")){
			$.ajax({
				type:"get",
				url:"/favorite/delete",
				data:{gid, uid},
				success:function(){
					 getFavorite();
				}
			});
		}		
	});
	
	$("#btn-cart").on("click", function(){
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data: {gid:gid},
			success:function(){
				if(confirm("계속 쇼핑하실래요?")) {
					location.href="/";
				}else{
					location.href="/cart/list";
				}
			}
		});
	});
</script>








