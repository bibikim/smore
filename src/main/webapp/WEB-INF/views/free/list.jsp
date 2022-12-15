<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
							<td><a href="#">${free.FTitle}</a></td>
							<td id="align">${free.nickname}</td>
							<td id="align"><fmt:formatDate value="${free.FCreateDate}" pattern="yyyy.M.d"/></td>
							<td id="align">${free.FHit}</td>
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