<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="스터디 목록" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

</script>

<style>

</style>
</head>
<body>
	
	<h1>${loginUser.nickname}님 스터디 목록</h1>
	
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>모임장</td>
					<td>제목</td>
					<td>개발 언어</td>
					<td>시작예정일</td>
					<td>조회수</td>
					<td>작성일</td>
				</tr>
			</thead>
	 		<tbody>
	 			<c:if test="${empty studyList}">
	 				<tr>
	 					<td colspan="7">게시물이 없습니다.</td>
	 				</tr>
	 			</c:if>
	 			
	 			<c:if test="${studyList ne null}">
		 			<c:forEach items="${studyList}" var="study">
		 				<tr>
							<td>${study.studNo}</td>
		 					<td>${study.nickname}</td>	
		 					<td>
		 						<a href="/study/detail?studNo=${study.studNo}">${study.title}</a>
			 					<c:if test="${loginUser.nickname != study.nickname}">
									<a href="${contextPath}/study/increse/hit?studNo=${study.studNo}">${study.title}(작성회원번호 ${study.nickname})</a>
								</c:if>
		 					</td>
		 					<td>${study.lang}</td>
		 					<td>${study.studDate}</td>		 					
		 					<td>${study.hit}</td>
		 					<td><fmt:formatDate value="${study.createDate}" pattern="yyyy.M.d"/></td>		 					
		 				</tr>			
		 			</c:forEach>
	 			</c:if>
	 		</tbody>
			<tfoot>
				<tr >
					<td colspan="7">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<div>
		<c:if test="${loginUser.nickname != null}">
			<input type="button" value="스터디 나가기" onclick="location.href='/user/studylist'">
		</c:if>
	</div>

</body>
</html>