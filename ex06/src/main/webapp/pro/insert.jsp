<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row justify-content-center">
	<div class="col-md-8">
		<h1 class="text-center">상품등록</h1>
		<form name="frm1" class="card p-3">
			<div class="input-group mb-3">
				<span class="input-group-text">상품이름</span>
				<input name="name" class="form-control">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상품가격</span>
				<input name="price" class="form-control">
			</div>
			<div class="text-center">
				<input type="submit" value="상품등록" class="btn btn-primary">
				<input type="reset" value="등록취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>
<script>
//섬밋
	$(frm1).on("submit", function(e) {
		e.preventDefault();
		const name=$(frm1.name).val();
		const price=$(frm1.price).val();
		if(name==""){
			alert("이름을 입력하세요!");
			$(frm1.name).focus();
		}else if(price==""){
			alert("가격을 입력하세요!");
			$(frm1.price).focus();
		}else if(price.replace(/[0-9]/g, '')){
			alert("가격을 숫자로 입력하세요!");
			$(frm1.price).val("");
			$(frm1.price).focus();
		}else{
			if(confirm("새로운 상품을 등록하실래요?")){
				$.ajax({
					type:"post",
					url:"/pro/insert",
					data:{"name":name, "price":price},
					success:function(){
						alert("등록완료!");
						$(frm1.name).val("");
						$(frm1.price).val("");
						$(frm1.name).focus();
						getTotal();
					}
				});
			}
		}
	});

</script>