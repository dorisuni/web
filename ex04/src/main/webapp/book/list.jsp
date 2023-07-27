<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<div class="col">
		<h1 class="text-center">도서목록</h1>
		<div id="div_book" class="text-center"></div>
	</div>
	<div class="text-center my-3">
			<button class="btn btn-primary" id="prev">이전</button>
			<span class="mx-3" id="page">1/100</span>
			<button class="btn btn-primary" id="next">다음</button>
	</div>
</div>

<script id="temp_book" type="text/x-handlebars-template">
	<table class="table">
	{{#each documents}}


		<tr class="search">
			<td>{{title}}</td>
			<td>{{price}}</td>
			<td>{{authors}}</td>
		</tr>


	{{/each}}
	</table>

</script>

<script>
let page = 1;
getList();
function getList(){
	$.ajax({
		type:"get",
		url:"/book/list.json",
		dataType:"json",
		data:{page:2},
		success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_book").html());
			const html=temp(data);
			$("#div_book").html(html);
		}
	});
}
getList();
</script>



