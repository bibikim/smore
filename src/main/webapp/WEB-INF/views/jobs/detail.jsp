<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>
<style>

	.div-border {
		border: 1px solid silver;
	
	}
</style>
<script>

</script>

</head>
<body>

	<div class="write-main">
		
		<hr>
		
			<div class="div-border">
				<span> JOB </span>
			</div>
		
		
	</div>	

</body>
</html>