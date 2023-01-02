<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<link rel="stylesheet" href="/resources/css/base.css">


<jsp:include page="../layout/header.jsp">
	<jsp:param value="코드게시판" name="title" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/free/list.css">
<script>

   
      $('#frm_search').submit(function(ev) {
         if($('.type').val() == '' || $('.keyword').val() == '') {
            alert('검색 조건을 확인하세요.');
            ev.preventDefault();
            return;
         }
      });
   
</script>
</head>
<body>

	<div class="wr-box">
		<c:if test="${loginUser != null}">
			<button id="btn_write" onclick="location.href='/code/write';">글쓰기</button>
		</c:if>
		<c:if test="${loginUser == null}">
			<span>글 작성은<a id="c_write" href="/user/login/form">로그인</a>후에
				가능합니다.
			</span>
		</c:if>
	</div>


	<div style="margin-left: auto; margin-right: auto; min-height: 966px;">
		<table>
			<colgroup class="table-col">
				<col style="width: 10%" />
				<col style="width: 50%" />
				<col style="width: 15%" />
				<col style="width: 15%" />
				<col style="width: 10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">작성일</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty codeboardList}">
					<tr>
						<td colspan="5">게시물이 없습니다.</td>
					</tr>
				</c:if>

				<c:if test="${codeboardList ne null}">
					<c:forEach items="${codeboardList}" var="code" varStatus="vs">
						<tr>
							<td id="align">${beginNo - vs.index}</td>
							<td><a href="/code/increase/hit?coNo=${code.coNo}">${code.title}</a>
								<span>[${codeCmtCnt[vs.index]}]</span> <c:set var="now"
									value="${java.util.Date}" /> <fmt:parseDate value="${now}"
									var="now1" pattern="yyyyMMdd" /> <fmt:parseNumber
									value="${now1.time /(1000*60*60*24)}" integerOnly="true"
									var="today" /> <fmt:parseDate value="${createDate}"
									var="creDate" pattern="yyyyMMdd" /> <fmt:parseNumber
									value="${creDate.time /(1000*60*60*24)}" integerOnly="true"
									var="creDt" /> <c:if test="${today - creDt le 1}">
									<img src="../../resources/images/icon-new.png">
								</c:if></td>
							<td id="align">${code.nickname}</td>
							<td id="align"><fmt:formatDate value="${code.createDate}"
									pattern="yyyy.M.d a hh:m" /></td>
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
			<form id="frm_search"
				action="/code/list?page=${page}&type=${type}&keyword=${keyword}"
				method="get">
				<select name="type" class="type">
					<option value="">선택</option>
					<option value="TITLE">제목</option>
					<option value="CONTENT">내용</option>
					<option value="NICKNAME">작성자</option>
				</select> <input type="text" name="keyword" class="keyword"
					placeholder="검색어를 입력해주세요" list="auto_complete">
				<!-- <datalist id="auto_complete"></datalist> -->
				<input type="submit" class="btn_search" value="search">
			</form>
		</div>
	</div>

	<jsp:include page="../layout/footer.jsp">
		<jsp:param value="" name="title" />
	</jsp:include>

</body>
</html>