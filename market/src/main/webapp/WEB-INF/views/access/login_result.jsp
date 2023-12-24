<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 1 }">
	<script>
		alert('환영합니다 :)');
		location.href="${url}";
	</script>
</c:if>
<c:if test="${result == -1 }">
	<script>
		alert('등록되지 않은 회원 입니다.');
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 0 }">
	<script>
	alert('비밀번호가 일치하지 않습니다.');
	history.go(-1);
	</script>
</c:if>