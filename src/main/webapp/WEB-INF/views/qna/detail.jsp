<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link href="/resources/css/board/main.d10e25fd.chunk.css"
	rel="stylesheet">
<jsp:include page="../layout/header.jsp">
	<jsp:param value="" name="title" />
</jsp:include>

<body>
	<div id="root">
		<form name="dataForm" id="dataForm" method="post">
			<input type="hidden" name="qaNo" id="qaNo" value="${question.qaNo}">
		</form>
		<div class="studyContent_wrapper__VVyNH">
			<section class="studyContent_postHeader__2Qu_y">
				<div class="studyContent_title__3680o">${question.title}</div>
				<div class="studyContent_userAndDate__1iYDv">
					<div class="studyContent_user__1XYmH">
						<img class="studyContent_userImg__3gyI-"
							src="../../resources/images/monster.png" alt="userImg">
						<div class="studyContent_userName__1GBr8">${question.nickname}</div>
					</div>
					<div class="studyContent_registeredDate__3lybC">${question.createDate}</div>
					<div class="studyContent_registeredDate__3lybC">조회
						${question.hit}</div>
				</div>

				<div class="studyContent_postContentWrapper__187Zh">
					<div class="studyContent_postContent__2c-FO">
						${question.content}</div>
				</div>
			</section>
			<section class="studyContent_commentAndViews__LrV6X">
				<div class="studyContent_postComment__2lpJV">
					<div class="commentInput_commentInput__39H41">
						<div class="commentInput_buttonWrapper__2f_l10">
							<div class="navbar_loginElementWrapper__11CeH">
								<c:if test="${loginUser != null}">
									<c:if test="${loginUser.nickname eq question.nickname}">
										<button type="button"
											class="commentInput_buttonComplete__24z4B"
											onclick="goPage(${question.qaNo},'del');">삭제</button>
									</c:if>
									<c:if test="${loginUser.grade eq '0'}">
										<button type="button"
											class="commentInput_buttonComplete__24z4B"
											onclick="location.href='/qna/adm/write?qaNo='+${question.qaNo};">답변하기</button>
									</c:if>
								</c:if>
								<c:if test="${loginUser != null}">
									<c:if test="${loginUser.nickname eq question.nickname}">
										<button type="button"
											class="commentInput_buttonComplete__24z4B"
											onclick="goPage(${question.qaNo}, 'mod');">수정</button>
									</c:if>
								</c:if>
							</div>
							<div class="navbar_loginElementWrapper__11CeH">
								<button type="button" class="commentInput_buttonComplete__24z4R"
									onclick="goPage(${question.qaNo}, 'list');">목록</button>
							</div>
						</div>
						
						<div class="commentInput_buttonWrapper__2f_l9"></div>
					</div>
					<ul class="commentList_CommentList__30HUh"></ul>
				</div>
			</section>
		</div>
		<div class="Toastify"></div>
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
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>	
</body>
</html>