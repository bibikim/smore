<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="찜 스터디 목록" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

</script>

<style>

	.btn_mypage{
		float: right;
	    width: 90px;
	    height: 32px;
	    font-size: 12px;
	    
	    clear: both;
	}
	
	
</style>

<div>
	<h3>${loginUser.nickname}님 찜 스터디 목록 <button type="button" class="btn btn-outline-success btn_mypage" onclick="location.href='/user/mypage'">마이페이지</button></h3>
	
</div>

<div>
	<table class="table">
		<thead>
			<tr>
				<td>순번</td>
				<td>모임장</td>
				<td>제목</td>
				<td>개발언어</td>
				<td>시작예정일</td>
				<td>조회수</td>
				<td><input type="checkbox" id="chk_all"></td>
			</tr>
		</thead>
 		<tbody>
 			<c:if test="${empty studyList}">
 				<tr>
 					<td colspan="7" style="text-align: center;">찜한 게시물이 없습니다.</td>
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
	 					<td><fmt:formatDate value="${study.studDate}" pattern="yyyy.M.d"/></td>		 					
	 					<td>${study.hit}</td>
						<td>
							<input type="checkbox" name="chk" class="del-chk" value="study.studNo">
						</td>
	 				</tr>			
	 			</c:forEach>
 			</c:if>
 		</tbody>
		<tfoot>
			<tr>
				<td colspan="7">
					${paging}
				</td>
			</tr>
		</tfoot>
	</table>
</div>

</body>
</html>