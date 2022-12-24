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
	a {
		text-decoration-line: none ;
		cursor: pointer;
		color: black;
		padding-bottom: 10px;
	}
</style>
<script>

</script>

</head>
<body>

	<div class="job-main">
	
	

		<div>
			<!-- && loginUser == 3 이어야 글쓰기 가능 -->
			<c:if test="${loginUser != null}">
				<span><a id="j_write" href="/job/write">구인 공고 등록</a></span>
			</c:if>
		</div>
		<div>
			<c:if test="${loginUser == null}">
				<span>글 작성은<a id="j_write" href="/user/login/form">로그인</a> 후에 가능합니다.</span>
			</c:if>
		</div>
	
	
	
	
		<div>
			<div class="board-name-wrapper">
			<div class="board-name">
				<span style="font-weight: bold;"> 구인 공고 </span>
				<span style="font-weight: 200; font-size: 9px"> 구인 공고 </span>
			</div>
			</div>
		</div>	
		
		<div>
			<!-- 검색 input 위치 -->
		</div>
		
		
		<div class="job-list">
			<ul>
				<c:if test="${empty jobList}">
					<li> 게시물이 없습니다. </li>
				</c:if>
				
				<c:if test="${jobList ne null}">
					<c:forEach items="${jobList}" var="job">
						<li>
							<div>
								<div>${job.companyName}</div>
							</div>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		
		
		
		
		
		
		
	</div>	

</body>
</html>