<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5 justify-content-center">
	<div class="col-md-6">
		<h1 class="text-center mb-3">상품등록</h1>
		<%--//섭밋될때 생략하면 get 메서드를 주면 post --%>
		<form class="card p-3" method="post" name = "frm">
			<div class="input-group my-2">
				<span class="input-group-text">상품이름</span> <input
					class="form-control" name="name">
			</div>
			<div class="input-group my-2">
				<span class="input-group-text">상품가격</span> <input
					class="form-control" name="price">
			</div>
			<div class="text-center mt-3">
				<input type="submit" value="상품등록" class="btn btn-primary"> 
				<input type="reset" value="상품취소" class="btn btn-secondary">
			</div>

		</form>

	</div>
</div>


<script>
	//폼이 서밋될때
	$(frm).on("submit", function(e){
		e.preventDefault();
		let name=$(frm.name).val();
		let price=$(frm.price).val();
		if(name==""){
			alert("이름을 입력하세요");
			$(frm.name).focus();
		}else if(price==""){
			alert("가격을 입력하세요!");
			$(frm.price).focus();
		}else if(price.replace(/[0-9]/g,'')){
			alert("숫자로 입력하세요!")
			$(frm.price).val("");
			$(frm.price).focus();
		}else{
			if(confirm("새로운 상품을 등록하실래요?")){
				frm.summit;
			}
		}
	});

</script>




