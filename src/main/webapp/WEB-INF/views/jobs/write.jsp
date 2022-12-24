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
				<span><a href="/job/list">JOB</a></span>
			</div>
			
		<div>
			<section>
				<div class="part1">

					<h5> 회사 정보 </h5>

					<div>
						<label for="name"> 회사명 </label>
						<div>
							<input type="text" id="name" name="companyName">
						</div>
					</div>
					<div style="float:left; margin-right: 70px;">
						<label for="contact"> 대표 연락처 </label>
						<div>
							<input type="text" id="contact" name="contact">
						</div>
					</div>
					<div style="float:left;">
						<label for="homepage"> 홈페이지 </label>
						<div>
							<input type="text" id="homepage" name="homepage">
						</div>
					</div>
				</div>
				<br>
				<h5> 채용 담당자 정보 </h5>
				<br>
				<div>
					<label for="hrName"> 담당자명 </label>
					<div>
						<input type="text" id="hrName" name="hrName">
					</div>
				</div>
				<div>
					<label for="hrContact"> 담당자 연락처 </label>
					<div>
						<input type="text" id="hrContact" name="hrContact">
					</div>
				</div>
				<div>
					<label for="hrEmail"> 담당자 이메일 </label>
					<div>
						<input type="text" id="hrEmail" name="hrEmail">
					</div>
				</div>
				<div>
					<label for="position"> 채용 포지션 </label>
					<div>
						<input type="text" id="position" name="position">
					</div>
				</div>
				<div>
					<label for="jopType"> 고용 형태 </label>
					<div>
						<input type="text" id="jopType" name="jopType">
					</div>
				</div>
				<div>
					<label for="career"> 요구 경력 </label>
					<div>
						<input type="text" id="career" name="career">
					</div>
				</div>
				<div>
					<label for="location"> 근무 지역 </label>
					<div>
						<input type="text" id="location" name="location">
					</div>
				</div>
			</section>
		</div>
		
		
	</div>	

</body>
</html>