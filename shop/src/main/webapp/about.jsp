<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.title, .price {
		font-size:12px;
	}
</style>    
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">쇼핑몰</h1>
		<div class="row justify-content-end">
			<form name="frm" class="col-4">
				<div class="input-group">
					<input name="query" class="form-control" value="">
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.title, .price{
		font-size:12px;
	}


</style>    
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">쇼핑몰</h1>
		
		<div class="row justify-content-end mb-3">
			<form name="frm" class="col-4">
				<div class="input-group">
					<input name="query" class="form-control">
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
					<button class="btn btn-primary">검색</button>
				</div>	 
			</form>
		</div>
<<<<<<< HEAD
		<hr>
		<div id="div_goods" class="row"></div>
		<div id="pagination" class="pagination justify-content-center mt-3"></div>
	</div>
</div>
<!-- 상품목록 템플릿 -->
=======
		
		<div id= "div_goods" class="row"></div>
		<div id="pagination" class="pagination justify-content-center mt-5"></div>
		
	</div>
</div>
<!-- 상품목록 탬플릿 -->
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
<script id="temp_goods" type="x-handlebars/template">
	{{#each .}}
		<div class="col-6 col-md-4 col-lg-2 mb-3">
			<div class="card p-3">
<<<<<<< HEAD
				<img src="{{image}}" gid="{{gid}}" style="cursor:pointer;">
				<div class="ellipsis title mt-2">{{title}}</div>
				<div class="price">{{fmtPrice price}}</div>
			</div>
		</div>
	{{/each}}
</script>
=======
				<img src="{{image}}">
				<div class="ellipsis title mt-2">{{title}}</div>
				<div>{{fmtPrice price}}</div>
			</div>		
        </div>
	{{/each}}
</script>

>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
</script>
<<<<<<< HEAD
<script>
	let page=1;
	let query="";
	
	$("#div_goods").on("click", "img", function(){
		const gid=$(this).attr("gid");
		location.href="/goods/read?gid=" + gid;	
	});
	
=======



<script>
	let page = 1;
	let query = "";
	getList();
	
	//검색버튼을 눌렀을 떄
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
<<<<<<< HEAD
=======
	
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
<<<<<<< HEAD
				const totalPages=Math.ceil(data/6);
				if(totalPages==0){
					alert("검색내용이 존재하지않습니다.");
					$(frm.query).val("");
=======
				const totalPages= Math.ceil(data/6);
				if(totalPages==0){
					alert("검색내용이 존재하지 않습니다.")
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
					query="";
					getTotal();
				}else{
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				}
			}
		});
	}
	
<<<<<<< HEAD
=======
	
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_goods").html());
<<<<<<< HEAD
				$("#div_goods").html(temp(data));
			}
		});
=======
				const html=temp(data);
				$("#div_goods").html(html);
			}
		});
		
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
	}
	
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	page=curPage;
	    	getList();
	    }
	});
<<<<<<< HEAD
</script>
=======
	    
	    
</script>
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
