<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>
<link rel="stylesheet" type="text/css" href="../../../resources/css/free/detail.css">

<script>
	
	$(document).ready(function(){
		
		// 게시글 삭제
		$('.btn_remove').click(function(){
			if(confirm('게시글을 삭제하시겠습니까?')) {
				$('#frm_btn').attr('action', '/free/remove');
				$('#frm_btn').submit();
			}
		})
		
		// 게시글 수정
		$('.btn_modify').click(function(){
			$('#frm_btn').attr('action', '/free/edit');
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
				url: '/free/comment/getcnt',
				data: 'freeNo=${free.freeNo}',
				dataType: 'json',
				success: function(resData) {
					$('.cmt_cnt').text(resData.commentCnt);  // 실제들어있는 값은 아닌데 key 자체를 써야 실제 값(value == db에서 꺼내온 값)을 꺼내올수 있다.
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
			$('.btn_addcmt').click(function(){
				if($('#content').val() == '') {
					alert('댓글 내용을 입력해주세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/free/comment/add',
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
				url: '/free/comment/list',
				data: 'freeNo=${free.freeNo}&page=' + $('#page').val(),
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
							div += '<span style="font-size: 14px;"><strong>' + comment.nickname + '</strong></span>';
							div += '<br>&nbsp;&nbsp;'
							div += '<input type="hidden" name="cmtNo" value="' + comment.cmtNo +'">';
							div += '<span class="origin_cmt">' + comment.cmtContent + '</span>';
							if( '${loginUser.nickname}' == comment.nickname || '${loginUser.nickname}' == '관리자') {
								// a링크 태그로 바꾸기
								div += '<input type="button" value="삭제" class="btn_removecmt btn" data-comment_no="' + comment.cmtNo + '">';
								div += '<input type="button" value="수정" class="btn_editcmt_area btn" data-comment_no="' + comment.cmtNo + '">';	
							}
							if(comment.depth == 0) {
								div += '&nbsp;&nbsp;<input type="button" value="답글" class="btn_recomment_area btn">'  // 대댓존
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
						div += '<span style="font-size: 12px; color: silver;">' + moment(comment.createDate).format('YYYY. MM. DD HH:mm') + '</span>';
						div += '</div>';
						
						/********************************** 대댓 ****************************************/
						if(comment.state == 1) {
							div += '<div style="margin-left; 40px" class="recomment_area blind">';
							div += '<form class="frm_recomment">';
							div += '<input type="hidden" name="freeNo" value="' +  comment.freeNo + '">';
							div += '<input type="hidden" name="groupNo" value="' +  comment.groupNo + '">';
							div += '<input type="hidden" name="depth" value="' +  comment.depth + '">';
							div += '<input type="hidden" name="ip" value="' +  comment.ip + '">';
							if( '${loginUser.nickname}' != '') {
								div += '<textarea name="cmtContent" class="commentinput" placeholder="댓글을 입력해주세요."></textarea>';
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
						div += '<input type="hidden" name="freeNo" value="' +  comment.freeNo + '">';
						//div += '<input type="hidden" name="groupNo" id="cogroupNo" value="' +  comment.groupNo + '">';
						div += '<input type="hidden" name="ip" value="' +  comment.ip + '">';
						div += '<input type="hidden" name="depth" value="' +  comment.depth + '">';
						div += '<input type="hidden" name="cmtNo" value="' +  comment.cmtNo + '">';
						if( '${loginUser.nickname}' == comment.nickname ) {
							div += '<textarea class="commentinput" name="cmtContent">' + comment.cmtContent + '</textarea>';
							div += '<input type="button" value="수정" class="btn_editcmt">';
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
						url: '/free/comment/remove',
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
					url: '/free/comment/reply/save',
					data: $(this).closest('.frm_recomment').serialize(),
					dataType: 'json',
					success: function(resData) {
						if(resData.isSaveRe) {
							alert('답글이 등록되었습니다.');
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
					url: '/free/comment/edit',
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
 				url: '/free/likeCheck',
 				data: 'freeNo=${free.freeNo}&nickname=${loginUser.nickname}',
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
 				url: '/free/likeCnt',
 				data: 'freeNo=${free.freeNo}',
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
 				if('${loginUser.nickname}' == '${free.nickname}') {
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
 					url: '/free/mark',
 					data: 'freeNo=${free.freeNo}&nickname=${loginUser.nickname}',
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

</head>
<body>
	<div class="wr-wrapper">
		<div style="width: 800px; display: inline-block;" >
<!-- 			<div style="float: left;">
				<input type="button" class="btn_list" value="목록" onclick="location.href='/free/list'">
			</div> -->
			<div class="btn_zone">
				<form id="frm_btn" method="post">
					<input type="hidden" name="freeNo" value="${free.freeNo}">
					<input type="button" class="btn_list" value="목록" onclick="location.href='/free/list'">
					<c:if test="${free.nickname eq loginUser.nickname || loginUser.grade eq 0}">
						<input type="button" value="수정" class="btn_modify">
						<input type="button" value="삭제" class="btn_remove">
					</c:if>
				</form>
			</div>
		</div>
		<div>
		
			<div id="fr-title"><strong>${free.title}</strong></div>
			<div id="fr-nick"><img src="../../resources/images/monster.png" >${free.nickname}</div>
			<div id="fr-hit"><img src="../../resources/images/eye.png">${free.hit}</div>
			<div id="fr-date"><span><fmt:formatDate value="${free.createDate}" pattern="yyyy.MM.dd HH:mm"/></span></div>
			<p style="text-align: left;">${free.content}</p>
			
			
		</div>
	
			<div>
				<span id="btn_cmtlist" class="">
					<img src="../../resources/images/comments-16.png">
					댓글
					<span class="cmt_cnt"></span>
				</span>
				<a id="lnk_like">
					<span id="heart"></span><span id="like">좋아요 </span><span id="like_count"></span>
				</a>
			</div>
			
			<hr>
	
			<div id="cmt_area">
				<div id="cmt_list"></div>
				<div id="paging"></div>
			</div>
			
			<br>

	
			<div>
				<form id="frm_addcmt">
					<div class="addcmt">
						<div class="addcmt_textarea">
							<textarea class="commentinput" name="cmtContent" id="content" placeholder="댓글을 입력하세요."></textarea>
						</div>
						<div>
							<input type="button" value="등록" class="btn_addcmt">
						</div>
					</div>
					<input type="hidden" name="freeNo" value="${free.freeNo}">
					<input type="hidden" name="ip" value="${cmtList.ip}">
					
					<input type="hidden" name="groupNo" value="0">
					<input type="hidden" name="nickname" value="${loginUser.nickname}">
					<input type="hidden" id="page" value="1">
				</form>
			</div>
	</div>
		
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="JOBS" name="title"/>
</jsp:include>