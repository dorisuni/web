<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="insert.jsp"/>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class="row">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			<div class="col">
				<span>검색수</span>
				<span id="total">100</span>
			</div>
		</div>
		<hr>
		<div id="div_product"></div>
		<div id="pagination" class="pagination justify-content-center mt-5"></div>
	</div>
</div>
<!-- 상품목록 템플릿 -->
<script id="temp_product" type="text/x-handlebars-template">
	<table class="table">
		{{#each .}}
		<tr>
			<td class="code">{{code}}</td>
			<td><input class="name" value="{{name}}"></td>
			<td>
				<input value="{{price}}" class="price">
				<br>
				<span class="fprice">{{fprice}}</span>
			</td>
			<td>{{fdate}}</td>
			<td><button class="btn btn-danger btn-sm" code="{{code}}" >삭제</button></td>
			<td><button class="btn btn-success btn-sm" >수정</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	let query=$(frm.query).val();
	
	//수정 버튼을 클릭한 경우
	$("#div_product").on("click",".btn-success",function(){
		const row = $(this).parent().parent();
		const code = row.find(".code").html();
		const name = row.find(".name").val();
		const price = row.find(".price").val();
		alert(code+":"+name+":"+price);
		if(confirm("상품정보를 수정하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/update",
				data:{code:code,name:name,price:price},
				success:function(){
					alert("수정완료!");
				}
			})
		}
	});
	
	
	
	
	//삭제버튼을 클릭한 경우
	$("#div_product").on("click",".btn-danger",function(){
		const code=$(this).attr("code");
		const name=$(this).parent().parent().find(".name").text();
		if(confirm(name+" 상품을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{"code":code},
				success:function(){
					alert("삭제완료!");
					getTotal();
				}
				
			})
			
		}
		
		
		
	});
	
	
	
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_product").html());
				const html=temp(data);
				$("#div_product").html(html);
			}
		});
	}
	
	 $('#pagination').twbsPagination({
		    totalPages:1,	// 총 페이지 번호 수
		    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		    startPage : 1, // 시작시 표시되는 현재 페이지
		    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		    first : '<i class="bi bi-chevron-bar-left"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		    prev : '<i class="bi bi-caret-left"></i>',	// 이전 페이지 버튼에 쓰여있는 텍스트
		    next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		    last : '<i class="bi bi-chevron-bar-right"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		    onPageClick: function (event, page) {
		    	getList(page);
		    }
	});
	 
	getTotal();
	function getTotal() {
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query},
			success:function(data){
				const totalPages=Math.ceil(data/5);
				$("#total").html(data);
				if(totalPages==0){
					alert("검색한 결과가 없습니다.")
					$(frm.query).val("");
					$("#pagination").hide();
				}else{
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				}
			}
		});
	}
</script>