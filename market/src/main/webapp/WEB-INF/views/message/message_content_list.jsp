<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>


<c:forEach var="tmp" items="${clist }">
	
	<c:choose>
		<c:when test="${sessionScope.nick ne tmp.message_send_nick }">
		<!-- 받은 메세지 -->
		<div class="	">
			<div class="incoming_msg_img">
					<!-- 사진 부분 수정해야함. -->
					<img src="./upload/profile/${tmp.profile }" alt=${tmp.message_send_nick }>
				</a>
			</div>
			<div class="received_msg">
				<div class="received_withd_msg">
					<p>${tmp.message_content }</p>
					<span class="time_date"> ${tmp.message_send_time }</span>
				</div>
			</div>
		</div>
		</c:when>
		
		<c:otherwise>
		<!-- 보낸 메세지 -->
		<div class="outgoing_msg">
			<div class="sent_msg">
				<p>${tmp.message_content }</p>
				<span class="time_date"> ${tmp.message_send_time }</span>
			</div>
		</div>
		</c:otherwise>
	</c:choose>


</c:forEach>