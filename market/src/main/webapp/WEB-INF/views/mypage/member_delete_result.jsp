<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == -1 }">
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 1 }">
	<script>
		alert("회원 탈퇴에 성공하셨습니다.")
		location.href = "home";
	</script>
</c:if>