<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="../../../resources/css/freelist.css">

<style>

		
	
</style>
<script>

	
		$('#frm_search').submit(function(ev) {
			if($('#type').val() == '' || $('#keyword').val() == '') {
				alert('검색 조건을 확인하세요.');
				ev.preventDefault();
				return;
			}
		});
	
</script>
</head>
<body>
	
	<div>
		<div>
			<c:if test="${loginUser != null}">
				<span><a id="f_write" href="/free/write">글쓰기</a></span>
			</c:if>
			<c:if test="${loginUser == null}">
				<span>글 작성은<a id="f_write" href="/user/login/form">로그인</a>후에 가능합니다.</span>
			</c:if>
		</div>
	</div>
	
	<div style="margin-left: auto; margin-right: auto;">
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
								
								<a href="/free/increase/hit?freeNo=${free.freeNo}">${free.title}</a>
								<span>[${freeCmtCnt[vs.index]}]</span>
								
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
							<td id="align"><fmt:formatDate value="${free.createDate}" pattern="yy.M.d hh:m"/></td>
							<td id="align">${free.hit}</td>
						</tr>
					</c:forEach>
				</c:if>
<%-- 				<tr>
					<td colspan="5">${paging}</td>
				</tr> --%>
			</tbody>
		</table>
			<div class="paging">
				<nav class="pagination">${paging}</nav>
			</div>
			<div class="searching">
				<form id="frm_search" action="/free/list?page=${page}&type=${type}&keyword=${keyword}" method="get">
					<select name="type" id="type">
						<option value=""> 선택 </option>
						<option value="TITLE"> 제목 </option>
						<option value="CONTENT"> 내용 </option>
						<option value="NICKNAME"> 작성자 </option>
					</select>
					<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해주세요" list="auto_complete">
					<input type="submit" value="search">
				</form>
			</div>
	</div>
	

<jsp:include page="../layout/footer.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>