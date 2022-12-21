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
	* {
		box-sizing: border-box;
	}
	
	table {
		margin-left: auto;
		margin-right: auto;
	}
	
	th {
		padding: 5px;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
		text-align: center;
	}
	
	td:nth-of-type(1) { width: 100px; }
	td:nth-of-type(2) { width: 500px; }
	td:nth-of-type(3) { width: 200px; }
	td:nth-of-type(4) { width: 100px; }
	
	#align {
		text-align: center;
	}
	
</style>
</head>
<body>
	
	
	
	<div>
		<div>
			<span><a href="/free/write">글쓰기</a></span>
		</div>
	</div>
	
	<div>
		<table>
			<thead>
				<tr>
					<th scope="col">글번호</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty freeList}">
					<tr>
						<td colspan="5"> 게시물이 없습니다. </td>
					</tr>
				</c:if>
				
				<c:if test="${freeList ne null}">
					<c:forEach items="${freeList}" var="free" varStatus="vs">
						<tr>
							<td id="align">${beginNo - vs.index}</td>
							<td>
								<a href="#">${free.title}</a>
								<c:set var="now" value="${java.util.Date}"/>
								<fmt:parseDate value="${now}" var="now1" pattern="yyyyMMddHHmmss"/>
								<fmt:parseNumber value="${now1.time /(1000*60*60*24)}" integerOnly="true" var="today"/>
								<fmt:parseDate value="${createDate}" var="creDate" pattern="yyyyMMddHHmmss" />
								<fmt:parseNumber value="${creDate.time /(1000*60*60*24)}" integerOnly="true" var="creDt"/>
								<c:if test="${today - creDt le 1}">
									<img src="../../resources/images/icon-new.png">
								</c:if>
							</td>
							<td id="align">${free.nickname}</td>
							<td id="align"><fmt:formatDate value="${free.createDate}" pattern="yyyy.M.d a hh:m"/></td>
							<td id="align">${free.hit}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5"></td>
				</tr>
			</tfoot>
			
		</table>

	</div>

</body>
</html>