<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 1 }">
	<script>
		alert('회정정보 수정 완료!');
		location.href='member_update_form';
	</script>
</c:if>
<c:if test="${result == -1 }">
	<script>
		alert('파일 저장 실패!');
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == -2 }">
	<script>
		alert('jpeg, gif, png 형식만 사용가능합니다.');
		history.go(-1);
	</script>
</c:if>