<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/header.jsp">
   <jsp:param value="날씨" name="title"/>
</jsp:include>
<style>


</style>
<script>
	
	
</script>
</head>
<body>
	
	<h4>날씨 api 테스트</h4>
	<div class="weather">
		
	</div>
	
	

</body>
</html>