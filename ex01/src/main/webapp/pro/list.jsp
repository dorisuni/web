<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row">
	<div class= "col">
		<h1 class="text-center mb-5">상품목록</h1>
		<table class="table table-striped">
			<c:forEach items="${array}" var="vo">
				<tr>
					<td>${vo.code}</td>
					<td>${vo.name}</td>
					<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
					<td><fmt:formatDate value="${vo.rdate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				</tr>
			</c:forEach>
		</table>
	</div> 
</div>

