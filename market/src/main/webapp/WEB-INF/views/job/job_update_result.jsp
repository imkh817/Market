<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 게시판 글 등록 결과</title>
</head>
<body>

	<c:if test="${result == 1 }">
		<script>
			alert("글 수정에 성공하였습니다 :)");
			location.href = "job_main";
		</script>
	</c:if>

	<c:if test="${result != 0 }">
		<script type="text/javascript">
			alert("글 수정에 실패하였습니다 :(");
			history.go(-1);
		</script>
	</c:if>

</body>
</html>