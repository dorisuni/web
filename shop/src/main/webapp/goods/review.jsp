<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.content {
		font-size:0.8rem;
	}
	textarea {
		overflow:hidden;
	}
	.btn-sm {
		font-size:0.7rem;
	}
</style>
<div class="my-5">
	<h3 class="text-center">고객리뷰</h3>
	<c:if test="${user==null}">
		<div class="text-center">
			<button class="btn btn-primary w-50" id="btn-review">리뷰작성</button>
		</div>
	</c:if>
	<c:if test="${user!=null}">
		<form name="frm">
			<textarea name="content" rows="3" class="form-control" placeholder="리뷰내용을 입력하세요!"></textarea>
			<div class="text-center mt-2">
				<button class="btn btn-primary px-5">글쓰기</button>
			</div>	
		</form>
	</c:if>	
	<div id="div_review" class="my-5"></div>
</div>
<!-- 리뷰목록 템플릿 -->
<script id="temp_review" type="x-handlebars-template">
	{{#each .}}
		<div class="row">
			<div class="col-md-1">
				<img src="{{photo}}" width="50px">
				<div>{{uid}}</div>
			</div>
			<div class="col">
				<div>
					<div>{{revDate}}</div>
					<div class="display{{rid}}" rid="{{rid}}">
						<div class="ellipsis content" style="cursor:pointer">{{content}}</div>
						<div class="text-end mt-2" style="{{show uid}}">
							<button class="btn btn-primary btn-sm btn-update">수정</button>
							<button class="btn btn-danger btn-sm btn-save">삭제</button>
						</div>
					</div>
					<div class="update{{rid}}" rid="{{rid}}" style="display:none;">
						<textarea class="content form-control" rows="3">{{content}}</textarea>
						<div class="text-end mt-2">
							<button class="btn btn-primary btn-sm btn-save">저장</button>
							<button class="btn btn-secondary btn-sm btn-cancel">취소</button>
						</div>
					</div>
				</div>
			</div>
		<div>
		<hr>
	{{/each}}
</script>
<script>
	//const uid="${user.uid}";
	Handlebars.registerHelper("show", function(writer){
		if(uid!=writer) return "display:none";
	})
</script>
<script>
	const uid="${user.uid}";
	const gid="${vo.gid}";
	
	//각 댓글의 내용을 클릭한 경우
	$("#div_review").on("click", ".content", function(){
		$(this).toggleClass("ellipsis");	
	});
	
	//각 댓글의 수정버튼이나 취소버튼을 클릭한 경우
	$("#div_review").on("click", ".btn-update, .btn-cancel", function(){
		const rid=$(this).parent().parent().attr("rid");
		$("#div_review .display" + rid).toggle();
		$("#div_review .update" + rid).toggle();
	});
	

	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			data:{gid},
			dataType:"json",
			success:function(data){
				//console.log(data);
				$("#rcnt").html(data.length);
				const temp=Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});	
	}
	
	$("#btn-review").on("click", function(){
		location.href="/user/login?target=/goods/read?gid=" + gid;	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const content=$(frm.content).val();
		if(content==""){
			alert("리뷰 내용을 입력하세요!");
			$(frm.content).focus();
		}else{
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{gid, uid, content},
				success:function(){
					alert("리뷰가 저장되었습니다.");
					$(frm.content).val("");
					getList();
				}
			});
		}
	});
</script>







