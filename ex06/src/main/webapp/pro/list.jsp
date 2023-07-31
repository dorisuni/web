<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class = "row">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
					
				</div>
			</form>
		</div>
		<hr>
		<div id="div_product"></div>
		<div id="pagination" class="pagination justify-content-center mt-3"></div>
	</div>
</div>


<!--  상품목록출력템플릿 -->
<script id="temp_product" type="text/x-handlebars-template">
	<table class="table">
		{{#each .}}
			<tr>
				<td>{{code}}</td>
				<td>{{name}}</td>
				<td>{{fprice}}</td>
				<td>{{fdate}}</td>
			</tr>

		{{/each}}
	</table>


</script>

<script>
	let query="";
	$(frm).on("submit",function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getList(1);
		getTotal();
	});
	
	function getList(page, query){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page:page,query:query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_product").html());
				const html = temp(data);
				$("#div_product").html(html);
			}
		});
	}
	
	getTotal();
	function getTotal() {
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query},
			success:function(data){
				const totalPages = Math.ceil(data/5);
				if(totalPages==0){
					alert("검색결과가 없습니다.")
					$("#div_product").hide();
					$("#pagination").hide();
					$(frm.query).val("");
				}else{
					$("#div_product").show();
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				}
				
			}
		})
	}
	
	
	//페이지네이션하기
	$('#pagination').twbsPagination({
	    totalPages:1,	// 총 페이지 번호 수
	    visiblePages: 10,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, page) {
	    	getList(page, query);
	    }
	});
	
	
	
	
	
	
</script>