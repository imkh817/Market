<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 0 }">
	<script>
		alert('문자 발송 실패 !');
		history.go(-1);
	</script>
</c:if>
<c:if test="${result != 0 }">
	<script>
		alert('임시 비밀번호를 발송하였습니다.');
		location.href="home";
	</script>
</c:if>