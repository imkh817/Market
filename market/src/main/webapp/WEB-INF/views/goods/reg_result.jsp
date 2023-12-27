<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 결과</title>
</head>
<body>

	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("상품등록에 성공하였습니다 :)");
			location.href = "home";
		</script>
	</c:if>

	<c:if test="${result <= 0 }">
		<script type="text/javascript">
			alert("상품 등록에 실패하였습니다 :(");
			history.go(-1);
		</script>
	</c:if>

</body>
</html>