<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/main_list.jsp"%>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
<script>
	$(".list_content").load("<c:url value='list' />");
</script>
</html>