<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>


<c:forEach var="tmp" items="${clist }">
	<c:choose>
		<c:when test="${myNick ne tmp.message_send_nick }">
			<div>
				<div class="received_withd_msg">${tmp.message_content }</div>
			</div>
			<br>
			<br>
			<span class="time_date">      ${tmp.message_send_time }</span>
			<br>
		</c:when>

		<c:otherwise>
			<div>
				<div class="sent_msg">${tmp.message_content }</div>
			</div>
			<br>
			<br>
			<span class="time_date2"> ${tmp.message_send_time }</span>
			<br>
		</c:otherwise>
	</c:choose>
</c:forEach>