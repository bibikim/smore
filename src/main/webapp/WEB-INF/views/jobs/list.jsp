<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="/resources/css/base.css">

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>


<style>

	body
	{
	  margin: 0 auto;
	  /* width: 1000px; */
	}
	
	a {
		text-decoration-line: none ;
		cursor: pointer;
		color: black;
	}
	
	.job-main {
	    margin-left: 300px;
	    margin-right: 300px;
	}
	
	.div-comp {
		display: flex; 
		margin-left: 30px;
		color: #5a5a5a;
		font-size: 15px;
		font-weight: 600;
	}

	.a-title-a {
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
		margin: 3px 0px 0px 15px;
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
	.status1 {
		background-color : #bdbdbd; opacity : 0.5;
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

	$(function(){
		
		$('#job_write').click(function(ev) {
			if('${loginUser.grade}' != 3) {
				alert('기업회원만 글 작성이 가능합니다.');
				ev.preventDefault();
				return;
			}
		});
		
		$('#frm_search').submit(function(ev){
			if($('#type').val() == '' || $('#keyword').val() == '') {
				alert('검색 조건을 확인하세요.');
				ev.preventDefault();
				return;
			}
		})
		
	});

</script>

</head>
<body>

	<div class="job-main">
		
			<div class="div-line">
				<span><a href="/job/list"> JOB </a></span>
			</div>
	
			<div>
				<!-- && loginUser == 3 이어야 글쓰기 가능 -->
				<%-- <c:if test="${loginUser.grade == 3}"> --%>
					<span><a id="job_write" href="/job/write">구인 공고 등록</a></span>
				<%-- </c:if> --%>
			</div>
			<div>
				<c:if test="${loginUser == null}">
					<span>글 작성은<a href="/user/login/form">로그인</a> 후에 가능합니다.</span>
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
			
			<div class="searching">
				<!-- 검색 input 위치 -->
				<form id="frm_search" action="/job/list?page=${page}&type=${type}&keyword=${keyword}">
					<select name="type" id="type">
						<option value="">선택</option>
						<option value="TITLE">제목</option>
						<option value="CONTENT">내용</option>
						<option value="COMPANY_NAME">기업명</option>
					</select>
					<input type="text" name="keyword">
					<input type="submit" value="search">
				</form>
			</div>
			
			
			<div class="job-list">
				<ul>
					<c:if test="${empty jobList}">
						<li> 게시물이 없습니다. </li>
					</c:if>
					
 					<c:if test="${not empty jobList}">
						<c:forEach items="${jobList}" var="job" varStatus="vs">
							<c:if test="${job.status == 0}">
								<li>
									<div style="margin: 20px 0 10px 0;">
										<div class="div-comp">⊹&nbsp;${job.companyName}</div>
										<div style="margin: 10px 0 10px 18px;">
											<a href="/job/increase/hit?jobNo=${job.jobNo}">${job.title}</a>
										</div>
										
										<!-- 찜 갯수 -->
										<div>
											<img src="../resources/images/f-bookmark.png" width="20px">
										</div>
										<div>
											${zzimCnt[vs.index]}
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
											<span>${job.skillStack}</span>
										</div>
										<div>
											<input type="hidden" name="status" value="0">
										</div>
									</div>
								</li>
								<div id="gubun" style="background: #bdbdbd; height: 1px; margin: 15px 15px 0 15px;"></div>
							</c:if>
							<c:if test="${job.status == 1}">
								<ul>
										
									<li class="status1"> 
										
										<div>채용 완료된 공고입니다.</div>
									
										<div style="margin: 20px 0 10px 0;">
											<div class="div-comp">⊹&nbsp;${job.companyName}</div>
											<div style="margin: 10px 0 10px 18px;">
												<a class="a-title-a" href="#">${job.title}</a>
											</div>
											
											<!-- 찜 갯수 -->
											<div>
												
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
												<span>${job.skillStack}</span>
											</div>
											<div>
												<input type="hidden" name="status" value="0">
											</div>
										</div>
									</li>
								</ul>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			
			<!-- 페이징 -->
			<div class="paging">
				<nav class="pagination">${paging}</nav>
			</div>
			
	</div>	

<jsp:include page="../layout/footer.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>