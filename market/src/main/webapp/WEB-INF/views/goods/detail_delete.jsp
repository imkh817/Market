<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<input type="hidden" id="goods_no" value="${goods_no }">
	<c:choose>
		<c:when test="${detail_delete == 1}">
			<script>
				alert("삭제 완료");
				location.href = "home";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("삭제 실패");
				history.go(-1);
			</script>
		</c:otherwise>
	</c:choose>

</body>
</html>