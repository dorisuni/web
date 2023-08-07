<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	span{
		width: 150px;
		justify-content: center;
	}
</style>



<div class="row my-5" id="page_order" style="display:none;">
	<div class="col">
		<h1 class="text-center mb-5">주문하기</h1>
		<div id="div_order"></div>
		<h1 class="text-center my-5">주문자정보</h1>
		<form name="frm" class="card p-3">
			<div class="input-group mb-3">
				<span class="input-group-text">주문자명</span>
				<input name="phone" class="form-control" value="${user.uname}">
			</div>	
				
			<div class="input-group mb-3">	
				<span class="input-group-text">주문자전화번호</span>
				<input class="form-control" value="${user.phone}">
			</div>
			<div class="input-group mb-3">	
				<span class="input-group-text">주문주소</span>
				<input name="address1" class="form-control" value="${user.address1}">
				<a class="btn btn-primary" id="btn-search">주소검색</a>
			</div>
			<div class="input-group mb-3">	
				<span class="input-group-text">상세주소</span>
				<input name="address2" class="form-control" value="${user.address2}">
			</div>
			<input name="sum" type="hidden">	
			<div class="text-center my-3">
				<button class="btn btn-primary px-5">주문하기</button>
			</div>
		</form>
	</div>
</div>
<!-- 주문상품목록 템플릿 -->
<script id="temp_order" type="x-handlebar-template">
	<table class="table">
		{{#each .}}
			<tr class="tr" price="{{price}}" qnt="{{qnt}}">
				<td>{{gid}}</td>
				<td><img src="{{image}}" width="50px"></td>
				<td>{{title}}</td>
				<td>{{sum price 1}}</td>
				<td>{{qnt}}</td>
				<td>{{sum price qnt}}</td>
			</tr>
		{{/each}}
		<tr>
			<td colspan="6" class="text-end">
				<h5>총합계: <span id="orderSum">0원</span></h5>
			</td>
		</tr>
	</table>
</script>
<script>
	
	//주문하기 버튼을 클릭한경우
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(confirm("위 상품을 주문하실래요?")) {
			//구매자정보등록
			$.ajax({
				type:"post",
				url:"/purchase/insert",
				data:{
					uid:"${user.uid}", 
					address1:$(frm.address1).val(),
					address2:$(frm.address2).val(), 
					phone:$(frm.phone).val(),
					sum:$(frm.sum).val()},
				success:function(data){
					alert(data);
				}	
			});
		}
	});



	//주소검색버튼을 누른 경우
	$("#btn-search").on("click",function(){
		new daum.Postcode({
			oncomplete:function(data){
				console.log(data);
				if(data.buildingName!=""){
					$(frm.address1).val(data.address + " " + data.buildingName);
				}else{
					$(frm.address1).val(data.address);
				}
				
			}
		}).open();
	});
	function getOrder(data){
		const temp=Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		getOrderSum();
	}
	
	function getOrderSum(){
		let sum=0;
		$("#div_order .tr").each(function(){
			const price=$(this).attr("price");
			const qnt=$(this).attr("qnt");
			sum += price*qnt;
		});
		$(frm.sum).val(sum);
		$("#orderSum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}
</script>