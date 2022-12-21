<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${loginUser.nickname}님 스터디 목록" name="title"/>
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
		<c:if test="${loginUser != null}">
			<input type="button" value="스터디 나가기" onclick="location.href='/user/studylist'">
		</c:if>
	</div>
	
	<div>
		
	</div>

</body>
</html>