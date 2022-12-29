<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="/resources/css/base.css">

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<body>
<script>
	
</script>
 	<div class="cont-body">
 		<form name="dataForm" id="dataForm" method="post">
            <input type="hidden" name="qaNo" id="qaNo" value="${question.qaNo}">
        </form>
        <!-- 페이지 내용 -->
        <div class="detail-area">
            <div class="title">
                ${question.title}
            </div>
            <div class="util">
                <span>${question.nickname}</span>
                <span class="date">
                	${question.createDate}
                </span>
                <span>조회 ${question.hit}</span>
            </div>
            <div class="article">
                <div class="txt">
                    ${question.content}
                </div>
            </div>
        </div>

        <!-- 버튼 -->
        <div class="aligner" data-top="sm">
            <div class="left">
            	<c:if test="${loginUser != null}">
            		<c:if test="${loginUser.nickname eq question.nickname}">
            			<button type="button" class="btn" onclick="goPage(${question.qaNo},'del');">삭제</button>
            		</c:if>
            		<c:if test="${loginUser.grade eq '0'}">
            			<button type="button" class="btn" onclick="location.href='/qna/adm/write?qaNo='+${question.qaNo};">답변하기</button>
            		</c:if>
            	</c:if>
            </div>
            <div class="right">
            	<c:if test="${loginUser != null}">
            		<c:if test="${loginUser.nickname eq question.nickname}">
            			<button type="button" class="btn" onclick="goPage(${question.qaNo}, 'mod');">수정</button>
            		</c:if>
            	</c:if>
                <button type="button" class="btn" onclick="goPage(${question.qaNo}, 'list');">목록</button>
            </div>
        </div>
        <!-- 버튼 -->

        <div class="docs-case">
            <div class="docs-value">
                <div class="inquiry-area">
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	/** 페이지 이동 **/
	function goPage(qaNo, task){
		
		if(task == 'list'){
			location.href = '/qna/list';
		}else if(task == 'mod'){
			$("#dataForm").attr("action", "/qna/edit");
			$("#dataForm").submit();
		}else if(task == 'del'){
			var _confirm = confirm('정말로 삭제하시겠습니까?');
			
			if(_confirm){
				$("#dataForm").attr("action", "/qna/remove");
				$("#dataForm").submit();
			}else{
				return;
			}
		}
	}
	
</script>
</html>