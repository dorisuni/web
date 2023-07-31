<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="insert.jsp"/>
<div class="row my-5 justify-content-center">
	<div class="col-8">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class="row">
			<form class="col-6" name="frm">
				<div class="input-group">
					<input class="form-control" placeholder="검색어" name="query">
					<button class="btn btn-primary">검색</button>
					<span id="total" class="ms-3">20건</span>
				</div>
			</form>
		</div>
		<hr/>
		<div id="div_product"></div>
		<div class="text-center mt-3" id="btn-group">
			<button class="btn btn-primary" id="prev">이전</button>
			<span class="mx-3" id="page">1/10</span>
			<button class="btn btn-primary" id="next">다음</button>
		</div>
	</div>
</div>
<!-- 상품목록 템플릿 -->
<script id="temp_product" type="text/x-handlebars.template">
	<table class="table">
		{{#each items}}
		<tr>
			<td class="code">{{code}}</td>
			<td><input value="{{name}}" class="name"></td>
			<td><input value="{{price}}" class="price" size=10>{{fprice}}</td>
			<td>{{fdate}}</td>
			<td><button class="btn btn-danger btn-sm" code="{{code}}">삭제</button></td>
			<td><button class="btn btn-warning btn-sm">수정</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let query="";
	getList();
	
	$("#div_product").on("click", ".btn-warning", function(){
		let row=$(this).parent().parent();
		let code=row.find(".code").text();
		let name=row.find(".name").val();
		let price=row.find(".price").val();
		if(confirm(code + ":" + name + ":" + price + " 수정하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/update",
				data:{"code":code, "name":name, "price":price},
				success:function(){
					alert("수정이 완료되었습니다.");
					getList();
				}
			});
		}else{
			alert("수정이 취소되었습니다.");
			getList();
		}
	});
	
	$("#div_product").on("click", ".btn-danger", function(){
		let code=$(this).attr("code");
		if(confirm(code + "번 상품을 삭제하실래요?")) {
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{"code": code},
				success:function(){
					alert("삭제완료되었습니다.");
					getList();
				}
			});
		}else{
			alert("삭제가 취소되었습니다.");
		}
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		query=$(frm.query).val();
		getList();
	});
	
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{"page": page, "query":query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_product").html());
				const html=temp(data);
				$("#div_product").html(html);
				
				const last=Math.ceil(data.total/5);
				$("#page").html(page + "/" + last);
				
				if(page==1) $("#prev").attr("disabled", true)
				else $("#prev").attr("disabled", false)
				
				if(page==last) $("#next").attr("disabled", true)
				else $("#next").attr("disabled", false);
				
				$("#total").html(data.total + "건");
				
				if(data.total==0) $("#btn-group").hide();
				else $("#btn-group").show();
			}
		});
	}
</script>