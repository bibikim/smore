<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<div>

	<h1>${study.title}</h1>
	
	<div>
		<span>▷ 작성자 ${study.nickname}</span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 작성일 <fmt:formatDate value="${study.createDate}" pattern="yyyy. M. d HH:mm" /></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${study.modifyDate}" pattern="yyyy. M. d HH:mm" /></span>
	</div>
	
	<div>
		<span>조회수 <fmt:formatNumber value="${study.hit}" pattern="#,##0" /></span>
	</div>
	
	<hr>
	
	<div>
		${study.content}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="studNo" value="${study.studNo}">
			<c:if test="${loginUser.nickname == study.nickname}">
				<input type="button" value="수정" id="btn_edit_study">
				<input type="button" value="삭제" id="btn_remove_study">
			</c:if>
			<input type="button" value="목록" onclick="location.href='/study/list'">
			<input type="button" value="신고하기" id="btn_red_study" onclick="showPopup();">
		</form>
		<script>
			$('#btn_edit_study').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/study/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_study').click(function(){
				if(confirm('이 게시판을 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/study/remove');
					$('#frm_btn').submit();
				}
			});

		</script> 
	</div>
	
	<hr>
	
	<!-- 12.20 시작 -->
	<span id="btn_comment_list">
		댓글
		<span id="comment_count"></span>개
	</span>
	<a id="lnk_Z">
		<span id="heart"></span><span id="good">찜하기 </span><span id="Z_count"></span>
	</a>
	
	<hr>
	
	<div id="comment_area" class="blind">
		<div id="comment_list"></div>
		<div id="paging"></div>
	</div>
	
	<hr>
	
	<div>
		<form id="frm_add_comment">
			<div class="add_comment">
				<div class="add_comment_input">
					<input type="text" name="content" id="content" placeholder="댓글을 작성하려면 로그인 해 주세요">
				</div>
				<div class="add_comment_btn">
					<c:if test="${loginUser != null}">
						<input type="button" value="작성완료" id="btn_add_comment">
					</c:if>
				</div>
			</div>
			<input type="hidden" name="studNo" value="${study.studNo}">
			<input type="hidden" name="nickname" value="${loginUser.nickname}">
		</form>
	</div>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	
</div>

</body>
</html>