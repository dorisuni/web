<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">지역검색</h1>
		<div class="row justify-content-end mb-3">
			<form class="col-6 col-md-4" name="frm">
				<div class="input-group">
					<select class="form-select me-2" name="city">
						<option>서울</option>
						<option selected>인천</option>
						<option>경기</option>
						<option>부산</option>
					</select>
					<input class="form-control" name="query" value="버거킹">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<hr>
		<div id="div_local"></div>
		<div class="text-center my-3">
			<button class="btn btn-primary" id="prev">이전</button>
			<span class="mx-3" id="page">1/100</span>
			<button class="btn btn-primary" id="next">다음</button>
		</div>
	</div>
</div>
<!-- 지도 Modal -->
<div class="row">
	<div class="col">
		<div id="map" style="width:100%;height:400px;display:none;" class="card"></div>
	</div>
</div>
<!-- 지역검색목록 템플릿 -->
<script id="temp_local" type="text/x-handlebars-template">
	<table class="table">
		<tr>
			<td colspan="6">
				<input type="checkbox" class="me-3" id="all">
				<button class="btn btn-primary btn-sm" id="btn-save">선택저장</button>
			<td>
		</tr>
		{{#each documents}}
		<tr class="local" local="{{toString @this}}">
			<td><input type="checkbox" class="chk"></td>
			<td>{{id}}</td>
			<td class="place">{{place_name}}</td>
			<td>{{address_name}}</td>
			<td class="phone">{{phone}}</td>
			<td><button class="btn btn-success btn-sm" x="{{x}}" y="{{y}}">위치</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("toString", function(local){
		return JSON.stringify(local);	
	});
	
</script>
<script>
	let page=1;
	getList();
	
	//선택 저장버튼을 클릭했을때
	$("#div_local").on("click", "#btn-save", function(){
		let chk=$("#div_local .chk:checked").length;
		if(chk==0){
			alert("저장할 항목을 선택하세요!");
		}else{
			if(!confirm(chk + "개 항목을 저장하실래요?")) return;
				
			$("#div_local .chk:checked").each(function(){
				let row=$(this).parent().parent();
				let data=JSON.parse(row.attr("local"));
				console.log(data);
				$.ajax({
					type:"post",
					url:"/local/insert",
					data: {
						lid:data.id, lname:data.place_name,
						laddress:data.address_name, lphone:data.phone,
						lurl:data.place_url, x:data.x, y:data.y},
					success:function(){}
				});
			});
			alert("저정되었습니다.");
			$("#div_local .chk").prop("checked", false);
			$("#div_local #all").prop("checked", false);
		}
	});
	
	//전체 체크박스를 클릭했을때
	$("#div_local").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_local .local .chk").prop("checked", true);
		}else{
			$("#div_local .local .chk").prop("checked", false);
		}
	});
	
	//각행의 체크박스를 클릭했을때
	$("#div_local").on("click", ".local .chk", function(){
		//전체 체크박스갯수
		let all=$("#div_local .local .chk").length;
		let chk=$("#div_local .local .chk:checked").length;
		if(all==chk){
			$("#div_local #all").prop("checked", true);
		}else{
			$("#div_local #all").prop("checked", false);
		}
	});
	
	$("#next").on("click", function(){
		$("#map").hide();
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		$("#map").hide();
		page--;
		getList();
	});
	
	$(frm).on("submit", function(e){
		$("#map").hide();
		e.preventDefault();
		page=1;
		getList();
	});
	
	//위치 버튼을 클릭한 경우
	$("#div_local").on("click", ".btn-success", function(){
		$("#map").show();
		const x=$(this).attr("x");
		const y=$(this).attr("y");
		
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(y, x),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(y, x); 
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		let row = $(this).parent().parent();
		let place = row.find(".place").text();
		let phone = row.find(".phone").text();
		
		var str ="<div style='padding:5px;font-size:12px;'>";
        str += place + "<br>" + phone;
        str +="</div>";
        var info=new kakao.maps.InfoWindow({ content:str });

        kakao.maps.event.addListener(marker, "mouseover", function(){ 
        	info.open(map, marker); 
        });
        kakao.maps.event.addListener(marker, "mouseout", function(){
        	info.close(map, marker); 
        });
	});
	
	function getList(){
		let query=$(frm.city).val() + $(frm.query).val();
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v2/local/search/keyword.json",
			headers:{"Authorization":"KakaoAK b80880fbde422de3fd9b4a4e67c9bb54"}, //REST API Key
			dataType:"json",
			data:{query:query, size:5, page:page},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_local").html());
				const html=temp(data);
				$("#div_local").html(html);
				
				if(page==1) $("#prev").attr("disabled", true)
				else $("#prev").attr("disabled", false);
				
				const last=Math.ceil(data.meta.pageable_count/5);
				
				if(data.meta.is_end) $("#next").attr("disabled", true)
				else $("#next").attr("disabled", false);
				
				$("#page").html(page + "/" + last);
			}
		});
	}
</script>