<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class="row justify-content-end">
			<div class="col">
				<a href="/goods/insert">
					<button class="btn btn-primary">상품등록</button>
				</a>
			</div>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">상품목록</h1>
		<div class="row justify-content-end mb-3">
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
			<form name="frm" class="col-4">
				<div class="input-group">
					<input name="query" class="form-control" value="">
					<button class="btn btn-primary">검색</button>
<<<<<<< HEAD
				</div>	 
			</form>
		</div>
		<hr>
		<div id="div_goods"></div>
		<div id="pagination" class="pagination justify-content-center mt-3"></div>
	</div>
</div>
<!-- 상품목록 템플릿 -->
<script id="temp_goods" type="x-handlebars/template">
	<table class="table">
	{{#each .}}
		<tr>
			<td class="gid"><a href="/goods/update?gid={{gid}}">{{gid}}</a></td>
			<td><img class="image" src="{{image}}" width="50px"></td>
			<td>{{title}}</td>
			<td>{{fmtPrice price}}</td>
			<td>{{maker}}</td>
			<td><button class="btn btn-danger btn-sm" gid="{{gid}}" image="{{image}}">삭제</button><td>
		</tr>
	{{/each}}
	</table>
</script>
=======
				</div>
			</form>
		</div>

		<div id="div_goods"></div>
		<div id="pagination" class="pagination justify-content-center mt-5"></div>

	</div>
</div>

<!-- 상품목록 탬플릿 -->
<script id="temp_goods" type="x-handlebars/template">
	<table class= "table">	
	{{#each .}}
		<tr>
			<td class="gid">{{gid}}</td>
			<td><img class="img" src = "{{image}}" width="50px"></td>
			<td><div class="ellipsis">{{title}}</td>
			<td>{{fmtPrice price}}</td>
			<td>{{maker}}</td>
			<td><button class="btn btn-danger" gid="{{gid}}" image="{{image}}">삭제</button><td>
        </tr>
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
	
=======



<script>
	let page = 1;
	let query = "";
	getList();
	
	//삭제버튼을 누른 경우
	$("#div_goods").on("click",".btn-danger",function(){
		const image = $(this).attr("image");
		const gid = $(this).attr("gid");
		if(confirm("해당 상품을 삭제할까요?")){
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid:gid,image:image},
				success:function(){
					alert("상품이 삭제되었습니다.");
					getTotal();
				}
			});
		}
			
		//alert(image + "," + gid);
		
	});
	
	
	
	
	//검색버튼을 눌렀을 떄
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
<<<<<<< HEAD
	//삭제버튼을 클릭한경우
	$("#div_goods").on("click", ".btn-danger", function(){
			const image=$(this).attr("image");
			const gid=$(this).attr("gid");
			if(confirm("해당 상품을 삭제하실래요?")){
				$.ajax({
					type:"post",
					url:"/goods/delete",
					data:{gid:gid, image:image},
					success:function(){
						alert("상품이 삭제되었습니다.");
						getTotal();
					}
				});
			}
	});
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
=======
	    
	    
>>>>>>> 0f9b6db6cc413c7e1dc48fd5ce04cfd353c3fdf5
</script>
