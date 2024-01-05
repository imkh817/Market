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

	<c:if test="${result == 1 }">
		<script>
			alert("글 삭제 성공");
			location.href = "job_main";
		</script>
	</c:if>

	<c:if test="${result != 0 }">
		<script>
			alert("글 삭제 실패");
			history.go(-1);
		</script>
	</c:if>

</body>
</html>