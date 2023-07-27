<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">도서검색</h1>
	</div>
</div>


<script>
	

	getList();
	function getList(){
	$.ajax({
		type:"get",
		url:"https://dapi.kakao.com/v3/search/book?target=title",
		data:{query:"JSP"},
		headers:{"Authorization":"KakaoAK e27f77421cc48d2de1427a129426733d"},
		dataType:"json",
		success:function(data){
			console.log(data);
		}
	});
	}
</script>