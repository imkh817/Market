<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

<c:forEach var="tmp" items="${clist}">
	<c:choose>
		<c:when test="${myNick ne tmp.message_send_nick}">
			<c:choose>
				<c:when test="${tmp.message_content == '암호화 된 메세지입니다.1112233333'}">
					<div>
						<div class="received_withd_msg">삭제된 메세지입니다.</div>
						<br> <br> <span class="time_date">
							${tmp.message_send_time } </span> <br>
					</div>
				</c:when>

				<c:otherwise>
					<div>
						<div class="received_withd_msg">${tmp.message_content }</div>
					</div>
					<br>
					<br>
					<span class="time_date"> ${tmp.message_send_time }</span>
					<br>
				</c:otherwise>
			</c:choose>
		</c:when>

		<c:when test="${tmp.message_content == '암호화 된 메세지입니다.1112233333'}">
			<div>
				<div class="sent_msg">삭제된 메세지입니다.</div>
				<br> <br> <span class="time_date2">
					${tmp.message_send_time } </span> <br>
			</div>
		</c:when>	
		<c:otherwise>
			<div>
				<div class="sent_msg">${tmp.message_content }</div>
				<br> <br> <span class="time_date2">
					<button type="button" class="btn-close" aria-label="Close"
						message_no="${tmp.message_no}"></button> ${tmp.message_send_time }
				</span> <br>
			</div>
		</c:otherwise>
	</c:choose>
</c:forEach>


<script type="text/javascript">
	$('.btn-close').on('click', function() {
		var message_no = $(this).attr('message_no');
		var confirmResult = confirm('정말 삭제하시겠습니까?');
		if (confirmResult) {
			message_content_remove(message_no);
		}
	});

	const message_content_remove = function(message_no) {
		$.ajax({
			url : "message_content_remove",
			type : "POST",
			data : {
				message_no : message_no
			},
			success : function() {
				alert('삭제되었습니다.');
			},
			error : function() {
				alert('서버 에러');
			}
		});
	}
</script>