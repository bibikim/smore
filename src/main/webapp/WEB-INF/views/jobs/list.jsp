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
	}
	
	.div-comp {
		display: flex; 
		margin-left: 30px;
		color: #5a5a5a;
		font-size: 15px;
		font-weight: 600;
	}

	li a {
		text-decoration-line: none ;
		display: inline-block;
		color: black;
		font-weight: bold;
	}
	
	li a:focus,
	li a:hover {
		text-decoration-line: none ;
		display: inline-block;
		color: #0078FF;
		font-weight: bold;
	}

	
	.div-line {
		display: flex;
		flex-basis: 100%;
		font-size: 18px;
		margin: 8px 0px;
		align-items: center;
	}
	
	.div-line::before {
		content: "";
		flex-grow: 1;
		margin: 0px 16px;
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		background: lightgray;
	}
	
	.div-line::after {
		content: "";
		flex-grow: 1;
		margin: 0px 16px;
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		background: lightgray;
	}
	
	.li-bottom1 {
		width:200px; 
		display: inline-block;
		font-size: 14px;
		font-size: bold;
		color: gray;
		margin: 8px 0px 0px 15px;
	}
	
	.li-bottom2 {
		width: 200px; 
		display: inline-block;
		margin-left: 20px;
		font-size: 14px;
		font-size: bold;
		color: gray;
		margin: 8px 0px 0px 15px;
	}
	
	.skill {
		font-size: 14px;
		font-size: bold;
		color: gray;
		margin: 8px 0px 0px 15px;
	}
	
	#a-title {
		font-size: 16px;
		font-weight: 900;
	}
	
	#gubun {
		background: #bdbdbd; 
		height: 1px; 
		margin-top: 15px;
	}
	
</style>
<script>

</script>

</head>
<body>

	<div class="job-main">
	
		<div class="div-line">
			<span><a href="/job/list"> JOB </a></span>
		</div>

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
			<div id="gubun"></div>
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
							<div style="margin: 20px 0 10px 0;">
								<div class="div-comp">* ${job.companyName}</div>
								<div style="margin: 10px 0 10px 18px;">
									<a href="/job/increase/hit?jobNo=${job.jobNo}">${job.title}</a>
								</div>
								<div style="width:90%;">
									<div class="li-bottom1">
										<img style="margin-top: 8px;" src="https://img.icons8.com/ultraviolet/18/null/place-marker--v1.png"/>
										<span>${job.location}</span>
									</div>
									<div class="li-bottom2">
										<img style="margin-top: 8px;" src="https://img.icons8.com/external-flatarticons-blue-flatarticons/18/null/external-Career-achievements-and-badges-flatarticons-blue-flatarticons.png"/>
										<span>${job.career}</span>
									</div>
								</div>
								<div class="skill">
									<img style="margin-top: 8px;" src="https://img.icons8.com/color/18/null/source-code.png"/>
									<span>기술스택</span>
								</div>
							</div>
						</li>
						<div id="gubun" style="background: #bdbdbd; height: 1px; margin: 15px 15px 0 15px;"></div>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		
		
		
		
		
		
		
	</div>	

</body>
</html>