<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="코드게시판" name="title" />
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>

<script>
	
	$(document).ready(function(){
		
		// 게시글 삭제
		$('.btn_remove').click(function(){
			if(confirm('게시글을 삭제하시겠습니까?')) {
				$('#frm_btn').attr('action', '/code/remove');
				$('#frm_btn').submit();
			}
		})
		
		// 게시글 수정
		$('.btn_modify').click(function(){
			$('#frm_btn').attr('action', '/code/edit');
			$('#frm_btn').submit();
		})
		
		// 댓글 관련 함수 호출
		fn_commentCnt();
		fn_switchCmtList();
		fn_addComment();
		fn_cmtList();
		fn_changePage();
		fn_switchRecmtArea();
		fn_addRecomment();
		fn_removeComment();
 		fn_editComment();
 		fn_switchEditcmtArea();
		
		// 댓글 카운트
		function fn_commentCnt() {
			$.ajax({
				type: 'get',
				url: '/code/comment/getcnt',
				data: 'coNo=${code.coNo}',
				dataType: 'json',
				success: function(resData) {
					$('.cmt_cnt').text(resData.commentCnt);
				}
			})
		}
		
  		function fn_switchCmtList() {
			$('#btn_cmtlist').click(function(){
				$('#cmt_area').toggleClass('blind');
			});
		} 
		
		
  		// 댓글 삽입
		function fn_addComment() {
			$('#btn_addcmt').click(function(){
				if($('#content').val() == '') {
					alert('댓글 내용을 입력해주세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/code/comment/add',
					data: $('#frm_addcmt').serialize(),
					dataType: 'json',
					success: function(resData) {
						if(resData.isSave) {
							alert('댓글이 등록되었습니다.');
							$('#content').val('');
							fn_cmtList();
							fn_commentCnt();
						}
					}, error: function(){
						alert('다시 로그인 해 주세요.');
						location.href='/user/login/form';
					}
				})
			})
		}
		
  		// 댓글 리스트
		function fn_cmtList(){
			$.ajax({
				type: 'get',
				url: '/code/comment/list',
				data: 'coNo=${code.coNo}&page=' + $('#page').val(),
				dataType: 'json',
				success: function(resData) {
					
					$('#cmt_list').empty();
					$.each(resData.cmtList, function(i, comment) {
						var div ='';
						if(comment.depth == 0) {   // 댓글
							div += '<div>';
						} else {
							div += '<div style="margin-left: 40px;">';
						}
						if(comment.state == 1) {   // 정상(삭제한 상태가 아니면)
							div += '<div class="comment_area">';
							div += '<span style="font-size: 14px; color: green;"><strong>' + comment.nickname + '</strong></span>';
							div += '<br>&nbsp;&nbsp;'
							div += '<input type="hidden" name="cmtNo" value="' + comment.cmtNo +'">';
							div += '<span class="origin_cmt">' + comment.cmtContent + '</span>';
							if( '${loginUser.nickname}' == comment.nickname || '${loginUser.nickname}' == '관리자') {
								// a링크 태그로 바꾸기
								div += '<input type="button" value="삭제" class="btn_removecmt" data-comment_no="' + comment.cmtNo + '">';
								div += '<input type="button" value="수정" class="btn_editcmt_area" data-comment_no="' + comment.cmtNo + '">';	
							}
							if(comment.depth == 0) {
								div += '&nbsp;&nbsp;<input type="button" value="답글" class="btn_recomment_area">'  // 대댓존
							}
							div += '</div>';
						} else {
							if(comment.depth == 0) {
								div += '<div>삭제된 댓글입니다.</div>';
							} else {
								div += '<div>삭제된 댓글입니다.</div>';  // 대댓 삭제
							}
						}
						div += '<div>';
						moment.locale('ko-KR');
						div += '<span style="font-size: 12px; color: silver;">' + moment(comment.createDate).format('YYYY. MM. DD hh:mm') + '</span>';
						div += '</div>';
						
						/********************************** 대댓 ****************************************/
						if(comment.state == 1) {
							div += '<div style="margin-left; 40px" class="recomment_area blind">';
							div += '<form class="frm_recomment">';
							div += '<input type="hidden" name="coNo" value="' +  comment.coNo + '">';
							div += '<input type="hidden" name="groupNo" value="' +  comment.groupNo + '">';
							div += '<input type="hidden" name="depth" value="' +  comment.depth + '">';
							div += '<input type="hidden" name="ip" value="' +  comment.ip + '">';
							if( '${loginUser.nickname}' != '') {
								div += '<textarea name="cmtContent" placeholder="내용을 입력해주세요."></textarea>';
								div += '<input type="button" value="등록" class="btn_addrecmt">';
							} else {
								div += '<textarea name="cmtContent" placeholder="댓글을 작성하려면 로그인을 해주세요."></textarea>';
							}
						}
						div += '</form>';
						div += '</div>';
						/****************************************************************************/
						
						
						
						/****************************  댓 수정 ***************************************/
						div += '<div style="margin-left; 40px" class="edit_cmt_area blind">';
						div += '<form class="frm_editcmt">';
						div += '<input type="hidden" name="coNo" value="' +  comment.coNo + '">';
						//div += '<input type="hidden" name="groupNo" id="cogroupNo" value="' +  comment.groupNo + '">';
						div += '<input type="hidden" name="ip" value="' +  comment.ip + '">';
						div += '<input type="hidden" name="depth" value="' +  comment.depth + '">';
						div += '<input type="hidden" name="cmtNo" value="' +  comment.cmtNo + '">';
						if( '${loginUser.nickname}' == comment.nickname ) {
							div += '<textarea name="cmtContent">' + comment.cmtContent + '</textarea>';
							div += '<input type="button" value="등록" class="btn_editcmt">';
						} 
						div += '</form>';
						div += '</div>';
						/****************************************************************************/
						
						
						
						div += '</div>';
						$('#cmt_list').append(div);
						$('#cmt_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
					});
					
					// 페이징
					$('#paging').empty();
					var pageUtil = resData.pageUtil;
					var paging = '';
					// 이전블록
					if(pageUtil.beginPage != 1) {
						paging += '<span class="enable_link" data-page="'+ (pageUtil.beginPage - 1) +'">prev</sapn>';
					}
					// 페이지 번호
					for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
						if(p == $('#page').val()) {
							paging += '<strong>' + p + '</strong>';
						} else {
							paging += '<span class="enable_link" data-page="' + p + '">' + p + '</span>';
						}
					}
					// 다음블록
					if(pageUtil.endPage != pageUtil.totalPage) {
						paging += '<span class="enable_link" data-page="' + (pageUtil.endPage + 1) +'">next</span>';
					}
					$('#paging').append(paging);
				}
			})
		}
		
		function fn_changePage(){
			$(document).on('click', '.enable_link', function(){
				$('#page').val($(this).data('page'));
				fn_cmtList();
			});
		}
		
		function fn_removeComment(){
			$(document).on('click', '.btn_removecmt', function(){
				if(confirm('댓글을 삭제할까요?')) {
					$.ajax({
						type: 'post',
						url: '/code/comment/remove',
						data: 'cmtNo=' + $(this).data('comment_no'),
						dataType: 'json',
						success: function(resData) {
							if(resData.isRemove) {
								alert('댓글이 삭제되었습니다.');
								fn_cmtList();
								fn_commentCnt();
							}
						}
					})
				}
			})	
		}	
		
		
		function fn_switchRecmtArea(){
			$(document).on('click', '.btn_recomment_area', function(){
				$(this).parent().next().next().toggleClass('blind');
			});
		}
		
		
		function fn_addRecomment(){
			$(document).on('click', '.btn_addrecmt', function(){
				if($(this).prev().val() == '') {
					alert('내용을 입력해주세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/code/comment/reply/save',
					data: $(this).closest('.frm_recomment').serialize(),
					dataType: 'json',
					success: function(resData) {
						if(resData.isSaveRe) {
							alert('대댓글이 등록되었습니다.');
							fn_cmtList();
							fn_commentCnt();
						}
					}
				})
			})
		}
		
		
		function fn_switchEditcmtArea(){
			$(document).on('click', '.btn_editcmt_area', function(){
				$(this).parent().next().next().next().toggleClass('blind');
			});
		}
		
		
 		function fn_editComment() {
			$(document).on('click', '.btn_editcmt', function() {
				if($(this).prev().val() == '') {
					alert('내용을 입력해주세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/code/comment/edit',
					data: $(this).closest('.frm_editcmt').serialize(),
					dataType: 'json',
					success: function(resData) {
						if(resData.isEdit) {
							alert('댓글이 수정되었습니다.');
							fn_cmtList();
						}
					}
				})				
			})
		}
		 
 		/**************************************************************************/
 		
 		// 좋아요 함수 호출
 		fn_likeCheck();
 		fn_likeCount();
 		fn_pressLike();
 		
 		// 좋아요 함수
 		// 내가 좋아요 누른 게시글인지 체크
 		function fn_likeCheck() {
 			$.ajax({
 				type: 'get',
 				url: '/code/likeCheck',
 				data: 'coNo=${code.coNo}&nickname=${loginUser.nickname}',
 				dataType: 'json',
 				success: function(resData) {
 					if(resData.count == 0) {
 						$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
 						$('#like').removeClass("like_checked");
 					} else {
 						$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
 						$('#like').addClass("like_checked");
 					}
 				}
 			})
 		}
		
 		// 좋아유 개수
 		function fn_likeCount(){
 			$.ajax({
 				type: 'get',
 				url: '/code/likeCnt',
 				data: 'coNo=${code.coNo}',
 				dataType: 'json',
 				success: function(resData){
 					$('#like_count').empty();
 					$('#like_count').text(resData.count);
 				}
 			})
 		}
 		
 		// 좋아요 누른 경우
 		function fn_pressLike() {
 			$('#lnk_like').click(function(){
 				// 로그인 해야 누를 수 있음
 				if('${loginUser.nickname}' == '') {
 					alert('해당 기능은 로그인이 필요합니다.');
 					return;
 				}
 				// 셀프 좋아요 방지
 				if('${loginUser.nickname}' == '${code.nickname}') {
 					alert('작성자의 게시글에서는 좋아요를 누를 수 없습니다.');
 					return;
 				}
 				// 좋아요 선택/해제 상태에 따른 하트 상태 변경
 				$('#like').toggleClass("like_checked");
 				if ($('#like').hasClass("like_checked")) {
 					$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
 				} else {
 					$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
 				}
 				
 				// 좋아요 처리
 				$.ajax({
 					type: 'get',
 					url: '/code/mark',
 					data: 'coNo=${code.coNo}&nickname=${loginUser.nickname}',
 					dataType: 'json',
 					success: function(resData) {
 						if(resData.isSuccess) {
 							fn_likeCount();
 						}
 					}
 				})
 			})
 		}
 		
 		
	});

</script>
<style>
* {
	box-sizing: border-box;
}

.blind {
	display: none;
}

#lnk_like:hover span {
	cursor: pointer;
	color: #f83030;
}

#heart {
	width: 16px;
	margin-right: 5px;
}
</style>
</head>
<body>
	<div style="width: 800px; display: inline-block;">
		<div style="width: 300px;">
			<input type="button" value="목록" onclick="location.href='/code/list'">
		</div>
		<c:if test="${loginUser.nickname eq  code.nickname}">
		<div style="width: 200px; display: inline-block;">
			<form id="frm_btn" method="post">
				<input type="hidden" name="coNo" value="${code.coNo}"> <input
					type="button" value="수정" class="btn_modify"> <input
					type="button" value="삭제" class="btn_remove">
			</form>
		</div>
		</c:if>
		<div>
			<c:forEach items="${attachList}" var="attach">
				<div>
					<a
						href="${contextPath}/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a>
				</div>
			</c:forEach>
			<br>
			<div>
				<a href="${contextPath}/upload/downloadAll?coNo=${upload.coNo}">ZIP
					다운로드</a>
			</div>
		</div>
	</div>
	<div>
		<table>
			<tbody>
				<tr>
					<td>${code.title}</td>
				</tr>
				<tr>
					<td><fmt:formatDate value="${code.createDate}"
							pattern="yyyy.M.d a hh:m" /></td>
				</tr>
				<tr>
					<td>
						<p style="text-align: left;">${code.content}</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div>
		<span id="btn_cmtlist" class="" style=""> 댓글 <span
			class="cmt_cnt"></span>개
		</span> <a id="lnk_like"> <span id="heart"></span><span id="like">좋아요
		</span><span id="like_count"></span>
		</a>
	</div>

	<hr>

	<div id="cmt_area">
		<div id="cmt_list"></div>
		<div id="paging"></div>
	</div>

	<hr>

	<div>
		<form id="frm_addcmt">
			<div class="addcmt">
				<div class="addcmt_textarea">
					<textarea name="cmtContent" id="content" placeholder="댓글 작성하기"></textarea>
				</div>
				<div>
					<input type="button" value="등록" id="btn_addcmt">
				</div>
			</div>
			<input type="hidden" name="coNo" value="${code.coNo}"> <input
				type="hidden" name="ip" value="${cmtList.ip}"> <input
				type="hidden" name="groupNo" value="0"> <input type="hidden"
				name="nickname" value="${loginUser.nickname}">
		</form>
	</div>

	<input type="hidden" id="page" value="1">


</body>
</html>