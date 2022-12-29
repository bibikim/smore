<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="/resources/css/base.css">



<jsp:include page="../layout/header.jsp">
   <jsp:param value="코드게시판" name="title"/>
</jsp:include>
<style>
	body {
  padding:1.5em;
  background: #f5f5f5
}

table {
  border: 1px #a39485 solid;
  font-size: .9em;
  box-shadow: 0 2px 5px rgba(0,0,0,.25);
  width: 100%;
  border-collapse: collapse;
  border-radius: 5px;
  overflow: hidden;
}

th {
  text-align: left;
}
  
thead {
  font-weight: bold;
  color: #fff;
  background: #73685d;
}
  
 td, th {
  padding: 1em .5em;
  vertical-align: middle;
}
  
 td {
  border-bottom: 1px solid rgba(0,0,0,.1);
  background: #fff;
}

a {
  color: #73685d;
}
  
 @media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  th {
    text-align: right;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
  }
  
  thead {
    float: left;
    white-space: nowrap;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    white-space: nowrap;
  }
  
  tr {
    display: inline-block;
    vertical-align: top;
  }
  
  th {
    border-bottom: 1px solid #a39485;
  }
  
  td {
    border-bottom: 1px solid #e5e5e5;
  }
  
  
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
	
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

</body>
</html>