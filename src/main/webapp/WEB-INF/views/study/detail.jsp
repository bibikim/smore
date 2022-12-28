<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<style>
	.blind {
		display: none;
	}
	
	#lnk_Z:hover span {
		cursor: pointer;
		color: #f83030;
	}
	
	#heart {
		width: 16px;
		margin-right: 5px;
	}
	#map {
        width: 300px;
        height: 300px;
        background-color: grey;
      }
</style>

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
	<div id="map"></div> <!-- 지도가 붙을 위치 -->
	<div>
		<form id="frm_btn" method="post">
			<input type="hidden" name="studNo" value="${study.studNo}">
			<c:if test="${loginUser.nickname == study.nickname}">
				<input type="button" value="수정" id="btn_edit_study">
				<input type="button" value="삭제" id="btn_remove_study">
			</c:if>
			<input type="button" value="목록" onclick="location.href='/'">
			<input type="button" value="신고하기" id="btn_red_study">
			<input type="button" value="채팅하기" id="btn_chat">
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

			$('#btn_chat').click(function(){
				
				window.open('/chat', 'chatting', 'width=670,height=670,top=100,left=500,menubar=no,history=no');							
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
		<span id="heart"></span><span id="z">찜하기 </span><span id="z_count"></span>
	</a>
	
	<hr>
	
	<div id="comment_area" class="blind">
		<div id="comment_list"></div>
		<div id="paging"></div>
	</div>
	
	<hr>
	
	<div>
		<form id="frm_addcomment">
			<div class="addcomment">
				<div class="addcomment_input">
					<input type="text" name="content" id="content" placeholder="댓글을 작성하려면 로그인 해 주세요">
				</div>
				<div class="add_comment_btn">
					<c:if test="${loginUser != null}">
						<input type="button" value="작성완료" id="btn_addcomment">
					</c:if>
				</div>
			</div>
			<input type="hidden" name="studNo" value="${study.studNo}">
			<input type="hidden" name="nickname" value="${loginUser.nickname}">
		</form>
	</div>
	
	<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
	<input type="hidden" id="page" value="1">
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA04EQzcwD9wp_TDVwnp-owrOYASb6u4Z8&callback=initMap&region=kr"></script>
	
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
		
		fn_ZCheck();
		fn_ZCount();
		fn_pressZ();
		fn_pressRed();
		
		// 함수 정의
		function fn_commentCount(){
			$.ajax({
				type: 'get',
				url: '${contextPath}/study/comment/getCount',
				data: 'studNo=${study.studNo}',
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
			$('#btn_addcomment').click(function(){
				if($('#content').val() == ''){
					alert('댓글 내용을 입력하세요.');
					return;
				}
				$.ajax({
					type: 'post',
					url: '/study/comment/add',
					data: $('#frm_addcomment').serialize(),
					dataType: 'json',
					success: function(resData){  // resData = {"isAdd", true}
						if(resData.isAdd){
							alert('댓글이 등록되었습니다.');
							$('#content').val('');
							fn_commentList();   // 댓글 목록 가져와서 뿌리는 함수
							fn_commentCount();  // 댓글 목록 개수 갱신하는 함수
						}
					}, 
				});
			});
		}
		
  		// 댓글 리스트
		function fn_commentList(){
			$.ajax({
				type: 'get',
				url: '/study/comment/list',
				data: 'studNo=${study.studNo}&page=' + $('#page').val(),
				dataType: 'json',
				success: function(resData) {
					
					$('#comment_list').empty();
					$.each(resData.commentList, function(i, comment) {
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
							div += '<input type="hidden" name="studNo" value="' +  comment.studNo + '">';
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
						div += '<input type="hidden" name="studNo" value="' +  comment.studNo + '">';
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
		// 12.20 18시
		
		// 내가 "좋아요"를 누른 게시글인가?(좋아요 테이블에 사용자와 게시글 정보가 있는지 확인, 눌렀으면 빨간하트, 안 눌렀으면 빈하트)
		function fn_ZCheck() { 
			$.ajax({
				url: '/study/getZCheck',
				type: 'get',
				data: 'studNo=${study.studNo}&nickname=${loginUser.nickname}',
				dataType: 'json',
				success: function(resData){
					if (resData.count == 0) {
						$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
						$('#z').removeClass("z_checked");
					} else {
						$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
						$('#z').addClass("z_checked");
					}
				}
			});
		}
		
		// "좋아요" 개수 표시하기
		function fn_ZCount(){
			$.ajax({
				url: '/study/getZCount',
				type: 'get',
				data: 'studNo=${study.studNo}',
				dataType: 'json',
				success: function(resData){
					$('#z_count').empty();
					$('#z_count').text(resData.count + '개');
				}
			});
		}
		
		// "좋아요" 누른 경우
		function fn_pressZ(){
			$('#lnk_Z').click(function(){
				// 로그인을 해야 "좋아요"를 누를 수 있다.
				if('${loginUser.nickname}' == ''){
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				}
				
				// 셀프 좋아요 방지
				if('${loginUser.nickname}' == '${study.nickname}'){
					alert('본인의 게시글에서는 "좋아요"를 누를 수 없습니다.');
					return;
				}
				
				// "좋아요" 선택/해제 상태에 따른 하트 변경
				$('#z').toggleClass("z_checked");
				if ($('#z').hasClass("z_checked")) {
					$('#heart').html('<img src="../resources/images/redheart.png" width="15px">');
				} else {
					$('#heart').html('<img src="../resources/images/whiteheart.png" width="15px">');
				}
				
				// "좋아요" 처리
				$.ajax({
					url: '/study/mark',
					type: 'get',
					data: 'studNo=${study.studNo}&nickname=${loginUser.nickname}',
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess) {
							fn_ZCount();							
						}
					}
				});
			});
		}
		
		// 12.22 신고하기
		function fn_pressRed() {
			$('#btn_red_study').click(function(){
				// 로그인을 해야 "신고하기"를 누를 수 있다.
				if('${loginUser.nickname}' == ''){
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				}
				// 자기신고 불가
				if('${loginUser.nickname}' == '${study.nickname}'){
					alert('본인을 신고 할 수 없습니다.');
					return;
				} else {
					window.open("<%=request.getContextPath()%>/red/write", "신고창", "width=800, height=600, left=100, top=50"); 
				}
			});

		}
		// 지도
	    function initMap() {
	        var location = { lat: ${study.wido} ,lng: ${study.gdo} };
	        var map = new google.maps.Map(
	          document.getElementById('map'), {
	            zoom: 12,
	            center: location
	          });
	        
	      }
	</script>

	
</div>
<body>

</body>
</html>