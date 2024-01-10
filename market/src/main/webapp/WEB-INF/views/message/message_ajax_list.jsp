<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="tmp" items="${list }">
	<div class="chat_list_box${tmp.message_room } chat_list_box">
		<div type="button" class="chat_list" room="${tmp.message_room }"
			other-nick="${tmp.other_nick }">
			<!-- active-chat -->
			<div class="chat_people">
				<div class="chat_img">
					<!-- 사진 구해올 곳 여기도 수정해야함 -->
					<img src="./upload/${tmp.profile}" alt="sunil"> </a>
				</div>
				<div class="chat_ib">
					<h5>${tmp.other_nick }<span class="chat_date">${tmp.message_send_time }</span>
					</h5>
					<div class="row">
						<c:choose>
						<c:when test="${tmp.message_content == '암호화 된 메세지입니다.1112233333'}">
						<div class="col-10">
							<p>삭제된 메세지입니다.</p>
						</div>
						</c:when>
						<c:otherwise>
						<div class="col-10">
							<p>${tmp.message_content }</p>
						</div>
						</c:otherwise>
						</c:choose>
						<%-- 만약 현재사용자가 안읽은 메세지 갯수가 0보다 클때만 badge를 표시한다. --%>
						<c:if test="${tmp.unread > 0 }">
							<div class="col-2 unread${tmp.message_room }">
								<span class="badge bg-danger">${tmp.unread }</span>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
