<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="QNA게시판" name="title"/>
</jsp:include>

<style>
	a { text-decoration: none; outline: none}

 a:hover, a:active {text-decoration: none; }

</style>

<link rel="stylesheet" type="text/css" href="../../../resources/css/free/list.css"> 

<body>
	<c:if test="${loginUser != null}">
    	<c:if test="${loginUser.grade ne '0'}">
		    <div class="aligner" data-top="sm">
		        <div class="right">
		            <button type="button" class="btn" id="btn_write" onclick="goWritePage();">
		                글 작성하러 가기
		            </button>
		        </div>
		    </div>
	    </c:if>
    </c:if>

<div class="cont-body">

    <div class="table">
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
                    <th scope="col">No.</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">조회</th>
                </tr>
            </thead>
            <tbody>
            	<tr>
            			
	                    <td class="text-center" style="color:#ff0000; font-weight: bold;">공지</td>
	                    <td class="subject">	                   
		                        <a href="javascript:void(0)">
		                            <span style="color:#ff0000; font-weight: bold;">※중요※ 욕설 및 타인에게 불쾌감을 주는 질문 작성은 금지합니다.</span> 
		                        </a>		                        
	                    </td>
	                    <td>관리자</td>
	                    <td>
	                    	2022-12-27
	                    </td>
	                    <td></td>
	                </tr>
            	<tr>
	                   <td class="text-center" style="color:#ff0000; font-weight: bold;">공지</td>
	                    <td class="subject">
		                        <a href="javascript:void(0)">
		                            <span style="color:#ff0000; font-weight: bold;">※중요※ 답변은 게시글 확인하는 대로 빠르게 답변해 드리겠습니다.</span> 
		                        </a>		                        
	                    </td>
	                    <td>관리자</td>
	                    <td>
	                    	2022-12-27
	                    </td>
	                    <td></td>
	                </tr>
            	<c:if test="${qnaboardList ne null}">
            		<c:forEach items="${qnaboardList}" var="question" varStatus="vs">
	                <tr>
	                    <td class="text-center">${beginNo - vs.index}</td>
	                    <td class="subject">
	                    	<!-- chkUser 1: 본인 2: 다른사용자 3: 관리자 -->
	                    	<c:if test="${loginUser.nickname eq question.NICKNAME}">
	                    		<c:set var="chkUser" scope="request" value="1" />
	                    	</c:if>
	                    	
	                    	<c:if test="${loginUser.nickname ne question.NICKNAME}">
	                    		<c:set var="chkUser" scope="request" value="2" />
	                    	</c:if>
	                    	
	                    	<c:if test="${question.CMT_NO ne ''}">
	                    		<c:set var="chkUser" scope="request" value="3" />
	                    	</c:if>
	                    	
	                    	<c:if test="${question.PW ne 0}">
		                        <a href="javascript:void(0)" onclick="goDetailPage('${question.CMT_NO}', '${question.QA_NO}', '${chkUser}', 'Y')">
		                            <c:if test="${question.ANSWER eq 1}">
		                            	<span>[답변완료]</span>
		                            </c:if>
		                            <span>(비공개)</span> 
		                            ${question.TITLE}
		                            <c:if test="${question.NEW_YN eq 'Y'}">
		                            	<span class="icon"><img class="icon-new" src="/resources/images/icon-new.png" alt="새글" /></span>
		                            </c:if>
		                        </a>
	                        </c:if>
	                        <c:if test="${question.PW eq 0}">
	                        	<a href="javascript:void(0)" onclick="goDetailPage('${question.CMT_NO}', '${question.QA_NO}', '${chkUser}', 'N')">
		                        	<c:if test="${question.ANSWER eq 1}">
		                            	<span>[답변완료]</span>
		                            </c:if>
		                        	${question.TITLE}
		                            <c:if test="${question.NEW_YN eq 'Y'}">
		                            	<span class="icon"><img class="icon-new" src="/resources/images/icon-new.png" alt="새글" /></span>
		                            </c:if>
	                            </a>
	                        </c:if>
	                    </td>
	                    <td>${question.NICKNAME}</td>
	                    <td>
	                    	<fmt:parseDate value="${question.CREATE_DATE}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
	                    	<fmt:formatDate value="${parsedDateTime}" pattern="yyyy-MM-dd"/>
	                    </td>
	                    <td>${question.HIT}</td>
	                </tr>
	                </c:forEach>
                </c:if>

                <c:if test="${empty qnaboardList}">
	                <tr class="nodata-tr">
	                    <td class="nodata-td text-center" colspan="6"><span class="nodata-msg text-warning">데이터가 존재하지
	                            않습니다.</span></td>
	                </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 버튼 -->
    
    <!-- //버튼 -->

    <!-- 페이징 -->

    <div class="pagination">
<nav class="pagination">
		${paging}
</nav>
    </div>

    <!-- 페이징  -->

    <div class="docs-case">
        <div class="docs-value">
            <div class="inquiry-area"></div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp">
   <jsp:param value="qna게시판" name="title"/>
</jsp:include>

</body>
<script type="text/javascript">
	/**
		등록페이지 이동
	**/
	function goWritePage(){
		location.href = '/qna/write';
	}
	
	/** 상세페이지 이동 **/
	function goDetailPage(cmtNo, qaNo, chkUser, pwYN){

		var goUrl = '/qna/detail?qaNo='+qaNo;
		var userGrade = '<c:out value="${loginUser.grade}"/>';
		
		// 관리자는 모든글 진입가능
		if(userGrade == '0'){
			if(chkUser == '3'){ // 관리자가 쓴글이면 관리자 상세
				location.href = '/qna/detail?qaNo='+qaNo + '&cmtNo='+cmtNo;
			}else{
				location.href = goUrl;
			}
			return;
		}
		
		// 본인이 쓴 글 조회수 증가 없이 진입
		if(chkUser == '1'){
			goUrl = '/qna/detail?qaNo='+qaNo;
		}else if(chkUser == '2'){
			goUrl = '/qna/increse/hit?qaNo='+qaNo;
		}if(chkUser == '3'){ // 관리자가 쓴글이면 관리자 상세
			goUrl = '/qna/detail?qaNo='+qaNo + '&cmtNo='+cmtNo;
		}
		
		// 비밀글 여부
		if(pwYN == 'N'){
			location.href = goUrl;
			return;
		}else{
			var popupX = (document.body.offsetWidth / 2) - (200 / 2);
			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

			var popupY= (window.screen.height / 2) - (300 / 2);
			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

			var windowOpen = window.open("","selectBbsPwdForm","width=520,height=270, scrollbars=yes, resizable=yes left='+ popupX + ', top='+ popupY");
			
			if(chkUser == '3'){ // 관리자가 쓴글이면 관리자 상세
				windowOpen.location.href = "/qna/pwPopup?qaNo="+qaNo+'&cmtNo='+cmtNo;
			}else{
				windowOpen.location.href = "/qna/pwPopup?qaNo="+qaNo;
			}
        	
		}
	}
	
</script>
</body>
</html>