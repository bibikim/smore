<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<jsp:include page="../layout/header.jsp">
   <jsp:param value="코드게시판" name="title"/>
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
	
	.ul-paging{
	list-style:none;
	float:left;
	display:inline;
	}
	
	.li-page {
	    float: left;
	    margin-right: 20px;
	}
	
	.li-page a {
		float:left;
		padding:4px;
		margin-right:3px;
		width:15px;
		color:#000;
		font:bold 12px tahoma;
		border:1px solid #eee;
		text-align:center;
		text-decoration:none;
	}
	
	.ul-paging li a:hover, .ul-paging li a:focus, .ul-paging li a:active {
		color:#fff;
		border:1px solid #1e90ff;
		background-color:#1e90ff;
	}
		
	
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
			<c:if test="${loginUser != null}">
				<span><a id="c_write" href="/code/write">등록하기</a></span>
			</c:if>
			<c:if test="${loginUser == null}">
				<span>글 작성은<a id="c_write" href="/user/login/form">로그인</a>후에 가능합니다.</span>
			</c:if>
		</div>
	
	<div>
		<table>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
            <tbody>
				<c:if test="${empty codeboardList}">
					<tr>
						<td colspan="5"> 게시물이 없습니다. </td>
					</tr>
				</c:if>
				
				<c:if test="${codeboardList ne null}">
					<c:forEach items="${codeboardList}" var="code" varStatus="vs">
						<tr>
							<td id="align">${beginNo - vs.index}</td>
							<td>
								<a href="/code/increase/hit?coNo=${code.coNo}">${code.title}</a>
								<span>[${codeCmtCnt[vs.index]}]</span>
								
				
								<c:set var="now" value="${java.util.Date}"/>
								<fmt:parseDate value="${now}" var="now1" pattern="yyyyMMdd"/>
								<fmt:parseNumber value="${now1.time /(1000*60*60*24)}" integerOnly="true" var="today"/>
								<fmt:parseDate value="${createDate}" var="creDate" pattern="yyyyMMdd" />
								<fmt:parseNumber value="${creDate.time /(1000*60*60*24)}" integerOnly="true" var="creDt"/>
								<c:if test="${today - creDt le 1}">
									<img src="../../resources/images/icon-new.png">
								</c:if>
							</td>
							<td id="align">${code.nickname}</td>
							<td id="align"><fmt:formatDate value="${code.createDate}" pattern="yyyy.M.d a hh:m"/></td>
							<td id="align">${code.hit}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			</table>
			<div class="paging">
				<nav class="pagination">${paging}</nav>
			</div>
			<div class="searching">
				<form id="frm_search" action="/code/list?page=${page}&type=${type}&keyword=${keyword}" method="get">
					<select name="type" id="type">
						<option value=""> 선택 </option>
						<option value="TITLE"> 제목 </option>
						<option value="CONTENT"> 내용 </option>
						<option value="NICKNAME"> 작성자 </option>
					</select>
					<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해주세요" list="auto_complete">
					<!-- <datalist id="auto_complete"></datalist> -->
					<input type="submit" value="search">
				</form>
			</div>
	</div>

</body>
</html>