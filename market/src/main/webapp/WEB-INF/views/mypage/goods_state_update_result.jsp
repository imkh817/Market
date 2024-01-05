<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상태 수정 결과</title>
</head>
<body>

<c:if test="${result == 1}">
	<script>
		location.href="mypage_list";
	</script>
</c:if>
<c:if test="${result != 1}">
	<script>
		alert("상품 상태 수정 실패");
		history.go(-1);
	</script>
</c:if>

</body>
</html>