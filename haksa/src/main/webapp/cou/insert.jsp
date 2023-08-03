<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form name="frm1" action="/cou/insert" method="post">
	<div class="input-group mb-3">
		<span class="input-group-text">강좌이름</span>
		<input name="lname" class="form-control">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">강 의 실</span>
		<input name="room" class="form-control">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">강의시수</span>
		<input name="hours" class="form-control" value="3" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">최대인원</span>
		<input name="capacity" class="form-control" value="30" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">수강인원</span>
		<input name="persons" class="form-control" value="0" oninput="isNumber(this)">
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">담당교수</span>
		<select name="instructor" class="form-select">
			<c:forEach items="${parray}" var="p">
				<option value="${p.pcode}">${p.pcode}:${p.pname}:${p.dept}</option>
			</c:forEach>
		</select>
	</div>
	<div class="text-center">
		<input type="submit" value="강좌등록" class="btn btn-primary">
		<input type="reset" value="등록취소" class="btn btn-secondary">
	</div>
</form>
<script>
	$(frm1).on("submit", function(e){
		e.preventDefault();
		const lname=$(frm1.lname).val();
		if(lname==""){
			alert("강좌이름을 입력하세요!");
			$(frm1.lname).focus();
		}else{
			if(confirm("새로운 강좌를 입력하실래요?")){
				frm1.submit();
			}
		}
	});
	
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>