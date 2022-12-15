<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${qnaboard.qNo}번 게시판" name="title"/>
</jsp:include>

<style>
	.blind {
		display: none;
	}
	#lnk_good:hover span {
		cursor: pointer;
		color: #f83030;
	}
	#heart {
		width: 16px;
		margin-right: 5px;
	}
</style>

<div>

	<h1>${qnaboard.title}</h1>
	
	<div>
		<span>▷ 작성자 ${qnaboard.user.name}</span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 작성일 <fmt:formatDate value="${qnaboard.createDate}" pattern="yyyy. M. d HH:mm" /></span>
		&nbsp;&nbsp;&nbsp;
		<span>▷ 수정일 <fmt:formatDate value="${qnaboard.modifyDate}" pattern="yyyy. M. d HH:mm" /></span>
	</div>
	
	<div>
		<span>조회수 <fmt:formatNumber value="${qnaboard.hit}" pattern="#,##0" /></span>
	</div>
	
	<hr>
	
	<div>
		${qnaboard.content}
	</div>
	
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="qNo" value="${qnaboard.qNo}">
			<c:if test="${loginUser.userNo == qnaboard.user.userNo}">
				<input type="button" value="수정" id="btn_edit_qnaboard">
				<input type="button" value="삭제" id="btn_remove_qnaboard">
			</c:if>
			<input type="button" value="목록" onclick="location.href='${contextPath}/qnaboard/list'">
		</form>
		<script>
			$('#btn_edit_qnaboard').click(function(){
				$('#frm_btn').attr('action', '${contextPath}/codeboard/edit');
				$('#frm_btn').submit();
			});
			$('#btn_remove_qnaboard').click(function(){
				if(confirm('블로그를 삭제하면 블로그에 달린 댓글을 더 이상 확인할 수 없습니다. 삭제하시겠습니까?')){
					$('#frm_btn').attr('action', '${contextPath}/qnaboard/remove');
					$('#frm_btn').submit();
				}
			});
		</script> 
	</div>
	
	<hr>
	
	
	<span id="btn_comment_list">
		댓글
		<span id="comment_count"></span>개
	</span>
	<a id="lnk_good">
		<span id="heart"></span><span id="good">좋아요 </span><span id="good_count"></span>
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
			<input type="hidden" name="qNo" value="${qnaboard.qNo}">
			<input type="hidden" name="userNo" value="${loginUser.userNo}">
		</form>
	</div>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	
	<script>
	
		// 함수 호출
		fn_commentCount();
		fn_switchCommentList();
		fn_addComment();
		fn_commentList();
		fn_changePage();
		fn_removeComment();
		fn_switchReplyArea();
		fn_addReply();
		
		fn_goodCheck();
		fn_goodCount();
		fn_pressGood();
		
		// 함수 정의
		function fn_commentCount(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/comment/getCount',
				data: 'qNo=${qnaboard.qNo}',
				dataType: 'json',
				success: function(resData){  // resData = {"commentCount": 개수}
					$('#comment_count').text(resData.commentCount);
				}
			});
		}
		
		function fn_switchCommentList(){
			$('#btn_comment_list').click(function(){
				$('#comment_area').toggleClass('blind');
			});
		}
		
		function fn_addComment(){
			$('#btn_add_comment').click(function(){
				if($('#content').val() == ''){
					alert('댓글 내용을 입력하세요');
					return;
				}
				$.ajax({
					type: 'post',
					url: '${contextPath}/comment/add',
					data: $('#frm_add_comment').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#content').val('');
							fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
							fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
						}
					}
				});
			});
		}
		
		function fn_commentList(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/comment/list',
				data: 'qNo=${qnaboard.qNo}&page=' + $('#page').val(),
				dataType: 'json',
				success: function(resData){
					/*
						resData = {
							"commentList": [
								{댓글하나},
								{댓글하나},
								...
							],
							"pageUtil": {
								page: x,
								...
							}
						}
					*/
					// 화면에 댓글 목록 뿌리기
					$('#comment_list').empty();
					moment.locale('ko-KR');
					$.each(resData.commentList, function(i, comment){
						var div = '';
						if(comment.state == -1) {
							if(comment.depth == 0) {
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div style="margin-left: 40px;">삭제된 답글입니다.</div>';
							}
						} else {
							if(comment.depth == 0) {
								div += '<div>';
							} else {
								div += '<div style="margin-left:40px;">';
							}
							div += '  <span>' + comment.user.name + '</span>';
							div += '  <span style="font-size:12px; color:silver;">' + moment(comment.createDate).format('YYYY년 MM월 DD일 A h:mm:ss') + '</span>';
							div += '<div>' + comment.content + '</div>';
							if('${loginUser.userNo}' != '') {
								if('${loginUser.userNo}' == comment.user.userNo && comment.state == 1) {
									div += '<input type="button" value="삭제" class="btn_comment_remove" data-comment_no="' + comment.commentNo + '">';
								} else if('${loginUser.userNo}' != comment.user.userNo && comment.depth == 0) {
									div += '<input type="button" value="답글" class="btn_reply_area">';
								}
							}
							div += '</div>';
						}
						div += '<div style="margin-left: 40px;" class="reply_area blind">';
						div += '<form class="frm_reply">';
						div += '<input type="hidden" name="qNo" value="' + comment.qNo + '">';
						div += '<input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
						div += '<input type="hidden" name="userNo" value="${loginUser.userNo}">';
						div += '<input type="text" name="content" placeholder="답글을 작성하려면 로그인을 해주세요">';
						if('${loginUser.userNo}' != '') {
							div += '<input type="button" value="답글작성완료" class="btn_reply_add">';
						}
						div += '</form>';
						div += '</div>';
						$('#comment_list').append(div);
						$('#comment_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
					});
					// 페이징
					$('#paging').empty();
					var pageUtil = resData.pageUtil;
					var paging = '<div>';
					// 이전 블록
					if(pageUtil.beginPage != 1) {
						paging += '<span class="lnk_enable" data-page="' + (pageUtil.beginPage - 1) + '">◀</span>';
					}
					// 페이지번호
					for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
						if(p == $('#page').val()){
							paging += '<strong>' + p + '</strong>';
						} else {
							paging += '<span class="lnk_enable" data-page="'+ p +'">' + p + '</span>';
						}
					}
					// 다음 블록
					if(pageUtil.endPage != pageUtil.totalPage){
						paging += '<span class="lnk_enable" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
					}
					paging += '</div>';
					// 페이징 표시
					$('#paging').append(paging);
				}
			});
		}  // fn_commentList
		
		function fn_changePage(){
			$(document).on('click', '.lnk_enable', function(){
				$('#page').val( $(this).data('page') );
				fn_commentList();
			});
		}
		
		function fn_removeComment(){
			$(document).on('click', '.btn_comment_remove', function(){
				if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
					$.ajax({
						type: 'post',
						url: '${contextPath}/comment/remove',
						data: 'commentNo=' + $(this).data('comment_no'),
						dataType: 'json',
						success: function(resData){  // resData = {"isRemove": true}
							if(resData.isRemove){
								alert('댓글이 삭제되었습니다.');
								fn_commentList();
								fn_commentCount();
							}
						}
					});
				}
			});
		}
		
		function fn_switchReplyArea(){
			$(document).on('click', '.btn_reply_area', function(){
				$(this).parent().next().toggleClass('blind');
			});
		}
		
		function fn_addReply(){
			$(document).on('click', '.btn_reply_add', function(){
				if($(this).prev().val() == ''){
					alert('답글 내용을 입력하세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '${contextPath}/comment/reply/add',
					data: $(this).closest('.frm_reply').serialize(),  // 이건 안 됩니다 $('.frm_reply').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
						if(resData.isAdd){
							alert('답글이 등록되었습니다.');
							fn_commentList();
							fn_commentCount();
						}
					}
				});
			});
		}
		
		//////////////////////////////////////////////////
		
		// 내가 "좋아요"를 누른 게시글인가?(좋아요 테이블에 사용자와 게시글 정보가 있는지 확인, 눌렀으면 빨간하트, 안 눌렀으면 빈하트)
		function fn_goodCheck() { 
			$.ajax({
				url: '${contextPath}/good/getGoodCheck',
				type: 'get',
				data: 'cNo=${qnaboard.qNo}&userNo=${loginUser.userNo}',
				dataType: 'json',
				success: function(resData){
					if (resData.count == 0) {
						$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
						$('#good').removeClass("good_checked");
					} else {
						$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
						$('#good').addClass("good_checked");
					}
				}
			});
		}
		
		// "좋아요" 개수 표시하기
		function fn_goodCount(){
			$.ajax({
				url: '${contextPath}/good/getGoodCount',
				type: 'get',
				data: 'qNo=${qnaboard.qNo}',
				dataType: 'json',
				success: function(resData){
					$('#good_count').empty();
					$('#good_count').text(resData.count + '개');
				}
			});
		}
		
		// "좋아요" 누른 경우
		function fn_pressGood(){
			$('#lnk_good').click(function(){
				// 로그인을 해야 "좋아요"를 누를 수 있다.
				if('${loginUser.userNo}' == ''){
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				}
				// 셀프 좋아요 방지
				if('${loginUser.userNo}' == '${codeboard.user.userNo}'){
					alert('본인의 게시글에서는 "좋아요"를 누를 수 없습니다.');
					return;
				}
				// "좋아요" 선택/해제 상태에 따른 하트 변경
				$('#good').toggleClass("good_checked");
				if ($('#good').hasClass("good_checked")) {
					$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
				} else {
					$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
				}
				// "좋아요" 처리
				$.ajax({
					url: '${contextPath}/good/mark',
					type: 'get',
					data: 'qNo=${qnaboard.qNo}&userNo=${loginUser.userNo}',
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess) {
							fn_goodCount();							
						}
					}
				});
			});
		}
		
	</script>
	
</div>

</body>
</html>