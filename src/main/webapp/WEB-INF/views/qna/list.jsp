<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="QNA게시판" name="title"/>
</jsp:include>

<div class="cont-body">
    <!-- 페이지 내용 -->
    <!-- <form name="dataForm" id="dataForm" method="get" action="BD_selectBbsList.do" class="form-inline">
        <input type="hidden" name="q_bbsCode" id="q_bbsCode" value="1039" />
        <input type="hidden" name="q_bbscttSn" id="q_bbscttSn" value="" />
        <input type="hidden" name="q_currPage" id="q_currPage" value="1" />
        <input type="hidden" name="q_order" id="q_order" value="" />
        <input type="hidden" name="password" id="password" />
        <div class="page-detail white" data-bottom="md">
            <div class="desc">
                <em class="mini-title">Q&amp;A 게시판</em>
            </div>
        </div>
        <div class="search">
            <span>검색</span>
            <div class="select">
                <label for="q_searchKeyTy" class="sr-only">검색조건</label>
                <select name="q_searchKeyTy" id="q_searchKeyTy">
                    <option value="sj___1002">제목</option>

                    <option value="lngtCn___1002">내용</option>
                </select>
            </div>
            <div class="input">
                <label for="q_searchVal" class="sr-only">입력</label>
                <input type="text" name="q_searchVal" id="q_searchVal" value="" class="form-control" />
            </div>
            <button type="submit" class="btn sm dark">검색</button>
        </div>
    </form> -->

    <div class="table">
        <table>
            <caption>
                <span>QNA 목록을 나타낸 표</span>
            </caption>
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
		                            	<span class="icon"><img class="icon-new" src="${contextPath}/resources/images/icon-new.png" alt="새글" /></span>
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
		                            	<span class="icon"><img class="icon-new" src="${contextPath}/resources/images/icon-new.png" alt="새글" /></span>
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
                <!-- <tr>
                    <td class="text-center">12323</td>
                    <td class="subject">
                        └&nbsp;&nbsp;
                        <a href="#none;" onclick="pwdPop('1039','20221215093423320','V')">
                            <span>[비공개]</span>

                            입금확인

                            <span class="icon"><img class="icon-new" src="./icon-new.png" alt="새글" /></span>
                        </a>
                    </td>
                    <td>입금</td>
                    <td>2022-12-15</td>
                    <td>0</td>
                </tr> -->
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
    <c:if test="${loginUser != null}">
    	<c:if test="${loginUser.grade ne '0'}">
		    <div class="aligner" data-top="sm">
		        <div class="right">
		            <button type="button" class="btn" onclick="goWritePage();">
		                등록하기
		            </button>
		        </div>
		    </div>
	    </c:if>
    </c:if>
    <!-- //버튼 -->

    <!-- 페이징 -->

    <!-- <div class="pagination">
        <div class="num">
            <a href="#" title="현재 1 페이지" onclick="return false;" class="active">1</a>
            <a href="#" onclick="opMovePage(2); return false;" title="2 페이지">2</a>
            <a href="#" onclick="opMovePage(3); return false;" title="3 페이지">3</a>
            <a href="#" onclick="opMovePage(4); return false;" title="4 페이지">4</a>
            <a href="#" onclick="opMovePage(5); return false;" title="5 페이지">5</a>
            <a href="#" onclick="opMovePage(6); return false;" title="6 페이지">6</a>
            <a href="#" onclick="opMovePage(7); return false;" title="7 페이지">7</a>
            <a href="#" onclick="opMovePage(8); return false;" title="8 페이지">8</a>
            <a href="#" onclick="opMovePage(9); return false;" title="9 페이지">9</a>
            <a href="#" onclick="opMovePage(10); return false;" title="10 페이지">10</a>
        </div>

        <a href="#" class="next" onclick="opMovePage(11); return false;" title="다음페이지그룹 가기">다음페이지</a>
        <a href="#" class="last" onclick="opMovePage(2296); return false;" title="마지막페이지로 가기">마지막페이지</a>
    </div> -->

    <!-- 페이징  -->

    <div class="docs-case">
        <div class="docs-value">
            <div class="inquiry-area"></div>
        </div>
    </div>
</div>
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
        	windowOpen.location.href = "/qna/pwPopup?qaNo="+qaNo;
		}
	}
	
</script>
</html>