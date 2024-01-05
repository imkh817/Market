<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${result == 'Fail' }">
	<script>
		alert('이미지 생성 실패..');
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 'Success' }">
	<script>
		alert('이미지 생성 성공');
		location.href="member_update_form";
	</script>
</c:if>