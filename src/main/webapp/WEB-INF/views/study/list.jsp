<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<div>
	
	<h1>목록(전체 ${totalRecord}개)</h1>
	
	<div>
		<c:if test="${loginUser != null}">
			<input type="button" value="글 작성하기" onclick="location.href='/study/write'">
		</c:if>
	</div>
	
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
		 					<td><a href="/study/detail?SNo=${study.studNo}">${study.title}</a></td>
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
	<!-- 이거 누르면 무한스크롤버전으로 보이게 -->
		<c:if test="${loginUser != null}">
			<input type="button" value="스크롤페이지" onclick="location.href='/study/list_scroll'">
		</c:if>
	</div>
</div>

</body>
</html>