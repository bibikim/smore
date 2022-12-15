<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="코드게시판목록" name="title" />
</jsp:include>

<div>
	
	<h1>코드게시판 목록(전체 ${totalRecord}개)</h1>
	
	<div>
		<c:if test="${loginUser != null}">
			<input type="button" value="코드게시판 작성하기" onclick="location.href='${contextPath}/code/write'">
		</c:if>
	</div>
	
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>제목</td>
					<td>작성</td>
					<td>등록일</td>
					<td>조회</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${codeboardList}" var="codeboard" varStatus="vs">
					<c:if test="${codeboard != null}">
						<tr>
							<td>${beginNo - vs.index}</td>
							<td>
								<c:if test="${loginUser.userNo == codeboard.user.userNo}">
									<a href="${contextPath}/codeboard/detail?cNo=${codeboard.cNo}">${codeboard.C_TITLE}</a>  <!-- 작성자가 열어 보는 건 조회수 증가하지 않음 -->
								</c:if>
								<c:if test="${loginUser.userNo != codeboard.user.userNo}">
									<a href="${contextPath}/codeboard/increse/hit?cNo=${codeboard.cNo}">${codeboard.C_TITLE}</a>
								</c:if>
								<c:if test="${codeboard.NEW_YN eq 'Y'}">
									[최신글]
								</c:if>
							</td>
							<td>
								${codeboard.NICKNAME}
							</td>
							<td>${codeboard.C_CREATE_DATE}</td>
							<td>${codeboard.C_HIT}</td>
						</tr>
					</c:if>
					<c:if test="${codeboard == null}">
						<tr>
							조회된 내역이 없습니다.
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</div>

</body>
</html>