<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<table class="table">
			<c:forEach items="${array}" var="vo">
				<tr>
					<td>${vo.code}</td>
					<td><a href="/pro/read?code=${vo.code}">${vo.name}</a></td>
					<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/>
					<td>${vo.rdate}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="text-center">
			<button class="btn btn-primary" id="prev">이전</button>
			<span class="mx-2" id="page">0</span>
			<button class="btn btn-primary" id="next">다음</button>
		</div>
	</div>
</div>

<script>
	let page="${page}";
	$("#page").html(page);
	
	if(page==1) $("#prev").attr("disabled",true);
	else $("#prev").attr("disabled",false);
	
	
	$("#prev").on("click",function(){
		page--;
		location.href="/pro/list?page="+page;
	});
	
	$("#next").on("click",function(){
		page++;
		location.href="/pro/list?page="+page;
	});
</script>