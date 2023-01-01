<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link href="/resources/css/board/main.d10e25fd.chunk.css"
	rel="stylesheet">
<link href="/resources/css/board/5.349538bf.chunk.css"
	rel="stylesheet">
<jsp:include page="../layout/header.jsp">
	<jsp:param value="코드게시판" name="title" />
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>

<script>
	$(document)
			.ready(
					function() {

						// 게시글 삭제
						$('.btn_remove').click(function() {
							if (confirm('게시글을 삭제하시겠습니까?')) {
								$('#frm_btn').attr('action', '/code/remove');
								$('#frm_btn').submit();
							}
						})

						// 게시글 수정
						$('.btn_modify').click(function() {
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
								type : 'get',
								url : '/code/comment/getcnt',
								data : 'coNo=${code.coNo}',
								dataType : 'json',
								success : function(resData) {
									$('.cmt_cnt').text(resData.commentCnt);
								}
							})
						}

						function fn_switchCmtList() {
							$('#btn_cmtlist').click(function() {
								$('#cmt_area').toggleClass('blind');
							});
						}

						// 댓글 삽입
						function fn_addComment() {
							$('#btn_addcmt').click(function() {
								if ($('#content').val() == '') {
									alert('댓글 내용을 입력해주세요.');
									return;
								}
								$.ajax({
									type : 'post',
									url : '/code/comment/add',
									data : $('#frm_addcmt').serialize(),
									dataType : 'json',
									success : function(resData) {
										if (resData.isSave) {
											alert('댓글이 등록되었습니다.');
											$('#content').val('');
											fn_cmtList();
											fn_commentCnt();
										}
									},
									error : function() {
										alert('다시 로그인 해 주세요.');
										location.href = '/user/login/form';
									}
								})
							})
						}

						// 댓글 리스트
						function fn_cmtList() {
							$
									.ajax({
										type : 'get',
										url : '/code/comment/list',
										data : 'coNo=${code.coNo}&page='
												+ $('#page').val(),
										dataType : 'json',
										success : function(resData) {

											$('#cmt_list').empty();
											$.each(
															resData.cmtList,
															function(i, comment) {
																var div = '';
																
																if (comment.depth == 0) { // 댓글
																	div += '<div>';
																} else {
																	div += '<div style="margin-left: 40px;">';
																}
																if (comment.state == 1) { // 정상(삭제한 상태가 아니면)
																	div += '<li class="commentItem_commentContainer__3eMR4">';
																	div += '<section class="commentItem_commentHeader__3-Wux">';
																	div += '<div class="commentItem_avatarWrapper__2J4nR">';
																	div += '<img class="commentItem_userImg__jWpVc" src="../../resources/images/monster.png" alt="사용자 이미지">';
																	div += '<div class="commentItem_commentInfo__5KL0S">';
																	div += '<div class="commentItem_title__36t1w">';
																	div += '<div class="commentItem_userNickname__PQ8kV">'+ comment.nickname
																		+ '</div>';
																	div += '<div class="commentItem_registeredDate__2TPJZ">'+moment(comment.createDate).format('YYYY. MM. DD hh:mm')+'</div>';
																	div += '</div></div></section><section class="commentItem_commentContent__1yK7o">';
																	div += '<p class="commentItem_commentContent__1yK7o">'+ comment.cmtContent +'</p>';
																	div += '<input type="hidden" name="cmtNo" value="' + comment.cmtNo +'">';
																	div += '<ul class="LanguageBar_languages__2Ilqf">';
																	if ('${loginUser.nickname}' == comment.nickname
																			|| '${loginUser.nickname}' == '관리자') {
																		div += '<li class="LanguageBar_languageIcon__Um7GQ LanguageBar_full__3qQet btn_removecmt">';
																		div += '<svg width="24" height="24" viewBox="0 0 32 33" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1 9.51447L15.7458 1.25732L31 9.51447L15.7458 18.2573L1 9.51447Z" stroke="#858E86" stroke-width="2" stroke-linejoin="round"></path><path d="M1 16.2573L15.7458 25.0002L31 16.2573" stroke="#858E86" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M1 23L15.7458 31.7429L31 23" stroke="#858E86" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path></svg>';
																		div += '<span data-comment_no="' + comment.cmtNo + '">삭제</span>';
																		div += '</li>';
																		div += '<li class="LanguageBar_languageIcon__Um7GQ LanguageBar_full__3qQet btn_editcmt_area">';
																		div += '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11 21H21" stroke="#333333" stroke-width="1.5" stroke-linecap="round"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M16.8845 4.82378C15.5155 3.62383 13.4241 3.74942 12.2122 5.10499C12.2122 5.10499 6.18886 11.8419 4.10018 14.1803C2.00875 16.5174 3.54182 19.746 3.54182 19.746C3.54182 19.746 6.994 20.8285 9.05372 18.5242C11.1148 16.2198 17.1685 9.45019 17.1685 9.45019C18.3804 8.09462 18.2522 6.02372 16.8845 4.82378Z" stroke="#333333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path><path d="M10.3604 7.29248L14.9255 11.2792" stroke="#333333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path></svg>';
																		div += '<span data-comment_no="' + comment.cmtNo + '">수정</span>';
																		div += '</li>';
																	}
																	if (comment.depth == 0) {
																		div += '<li class="LanguageBar_languageIcon__Um7GQ LanguageBar_full__3qQet btn_recomment_area">';
																		div += '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><mask id="mask0_859_3602" maskUnits="userSpaceOnUse" x="2" y="3" width="20" height="17"><path fill-rule="evenodd" clip-rule="evenodd" d="M13.1 4.5C12.5982 3.57562 11.6307 3 10.5789 3H5C3.34315 3 2 4.34315 2 6V8V14C2 16.8284 2 18.2426 2.87868 19.1213C3.75736 20 5.17157 20 8 20H16C18.8284 20 20.2426 20 21.1213 19.1213C22 18.2426 22 16.8284 22 14V11.0694C22 9.13438 22 8.16685 21.5704 7.45301C21.3179 7.03348 20.9665 6.68212 20.547 6.42962C19.8332 6 18.8656 6 16.9306 6H15.6211C14.5693 6 13.6018 5.42438 13.1 4.5Z" fill="white"></path></mask><g mask="url(#mask0_859_3602)"><path d="M2.87869 19.1213L3.93935 18.0607L2.87869 19.1213ZM21.5704 7.45301L20.2852 8.22651L21.5704 7.45301ZM20.547 6.42962L19.7735 7.71481L20.547 6.42962ZM21.1213 19.1213L20.0607 18.0607L21.1213 19.1213ZM5.00001 4.5H10.5789V1.5H5.00001V4.5ZM3.50001 8V6H0.500007V8H3.50001ZM3.50001 14V8H0.500007V14H3.50001ZM16 18.5H8.00001V21.5H16V18.5ZM20.5 11.0694V14H23.5V11.0694H20.5ZM15.6211 7.5H16.9306V4.5H15.6211V7.5ZM15.6211 4.5C15.1193 4.5 14.6577 4.22537 14.4183 3.78436L11.7817 5.21564C12.5459 6.62338 14.0193 7.5 15.6211 7.5V4.5ZM0.500007 14C0.500007 15.3718 0.496821 16.5516 0.623218 17.4917C0.755416 18.475 1.05354 19.4175 1.81803 20.182L3.93935 18.0607C3.82516 17.9465 3.68394 17.7426 3.59647 17.0919C3.5032 16.3982 3.50001 15.4566 3.50001 14H0.500007ZM8.00001 18.5C6.54339 18.5 5.60183 18.4968 4.90807 18.4035C4.25746 18.3161 4.05354 18.1748 3.93935 18.0607L1.81803 20.182C2.58252 20.9465 3.52505 21.2446 4.50832 21.3768C5.44845 21.5032 6.6282 21.5 8.00001 21.5V18.5ZM23.5 11.0694C23.5 10.1305 23.5015 9.32253 23.4398 8.6633C23.3759 7.98227 23.2345 7.30907 22.8556 6.67952L20.2852 8.22651C20.3359 8.3108 20.4093 8.47827 20.4528 8.94324C20.4985 9.43 20.5 10.0733 20.5 11.0694H23.5ZM16.9306 7.5C17.9267 7.5 18.57 7.50154 19.0568 7.54716C19.5217 7.59074 19.6892 7.66408 19.7735 7.71481L21.3205 5.14444C20.6909 4.76554 20.0177 4.62408 19.3367 4.56025C18.6775 4.49846 17.8695 4.5 16.9306 4.5V7.5ZM22.8556 6.67952C22.4768 6.05022 21.9498 5.52318 21.3205 5.14444L19.7735 7.71481C19.9833 7.84106 20.1589 8.01674 20.2852 8.22651L22.8556 6.67952ZM10.5789 4.5C11.0807 4.5 11.5423 4.77463 11.7817 5.21564L14.4183 3.78436C13.6541 2.37662 12.1807 1.5 10.5789 1.5V4.5ZM16 21.5C17.3718 21.5 18.5516 21.5032 19.4917 21.3768C20.475 21.2446 21.4175 20.9465 22.182 20.182L20.0607 18.0607C19.9465 18.1748 19.7426 18.3161 19.0919 18.4035C18.3982 18.4968 17.4566 18.5 16 18.5V21.5ZM20.5 14C20.5 15.4566 20.4968 16.3982 20.4035 17.0919C20.3161 17.7426 20.1748 17.9465 20.0607 18.0607L22.182 20.182C22.9465 19.4175 23.2446 18.475 23.3768 17.4917C23.5032 16.5516 23.5 15.3718 23.5 14H20.5ZM5.00001 1.5C2.51473 1.5 0.500007 3.51472 0.500007 6H3.50001C3.50001 5.17157 4.17158 4.5 5.00001 4.5V1.5Z" fill="#858E86"></path><path d="M8.75 14.25H15.25" stroke="#858E86" stroke-width="1.5" stroke-linecap="round"></path></g></svg>';
																		div += '<span>답글</span>' // 대댓존
																		div += '</li>';
																	}
																	div += '</ul>';
																	div += '</section></li>';
																	div += '</div>';
																} else {
																	if (comment.depth == 0) {
																		div += '<li class="commentItem_commentContainer__3eMR4">삭제된 댓글입니다.</li>';
																	} else {
																		div += '<li class="commentItem_commentContainer__3eMR4">삭제된 댓글입니다.</li>'; // 대댓 삭제
																	}
																}
																

																/********************************** 대댓 ****************************************/
																if (comment.state == 1) {
																	div += '<div style="margin-left; 40px" class="recomment_area blind">';
																	div += '<form class="frm_recomment">';
																	div += '<input type="hidden" name="coNo" value="' +  comment.coNo + '">';
																	div += '<input type="hidden" name="groupNo" value="' +  comment.groupNo + '">';
																	div += '<input type="hidden" name="depth" value="' +  comment.depth + '">';
																	div += '<input type="hidden" name="ip" value="' +  comment.ip + '">';
																	if ('${loginUser.nickname}' != '') {
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
																if ('${loginUser.nickname}' == comment.nickname) {
																	div += '<textarea name="cmtContent">'
																			+ comment.cmtContent
																			+ '</textarea>';
																	div += '<input type="button" value="등록" class="btn_editcmt">';
																}
																div += '</form>';
																div += '</div>';
																/****************************************************************************/

																div += '</div>';
																$('#cmt_list')
																		.append(
																				div);
																
															});

											// 페이징
											$('#paging').empty();
											var pageUtil = resData.pageUtil;
											var paging = '';
											// 이전블록
											if (pageUtil.beginPage != 1) {
												paging += '<span class="enable_link" data-page="'
														+ (pageUtil.beginPage - 1)
														+ '">prev</sapn>';
											}
											// 페이지 번호
											for (let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
												if (p == $('#page').val()) {
													paging += '<strong>' + p
															+ '</strong>';
												} else {
													paging += '<span class="enable_link" data-page="' + p + '">'
															+ p + '</span>';
												}
											}
											// 다음블록
											if (pageUtil.endPage != pageUtil.totalPage) {
												paging += '<span class="enable_link" data-page="'
														+ (pageUtil.endPage + 1)
														+ '">next</span>';
											}
											$('#paging').append(paging);
										}
									})
						}

						function fn_changePage() {
							$(document).on('click', '.enable_link', function() {
								$('#page').val($(this).data('page'));
								fn_cmtList();
							});
						}

						function fn_removeComment() {
							$(document).on(
									'click',
									'.btn_removecmt',
									function() {
										if (confirm('댓글을 삭제할까요?')) {
											$.ajax({
												type : 'post',
												url : '/code/comment/remove',
												data : 'cmtNo='
														+ $(this).data(
																'comment_no'),
												dataType : 'json',
												success : function(resData) {
													if (resData.isRemove) {
														alert('댓글이 삭제되었습니다.');
														fn_cmtList();
														fn_commentCnt();
													}
												}
											})
										}
									})
						}

						function fn_switchRecmtArea() {
							$(document).on(
									'click',
									'.btn_recomment_area',
									function() {
										$(this).parent().parent().parent().parent().next().toggleClass('blind')
									});
						}

						function fn_addRecomment() {
							$(document).on(
									'click',
									'.btn_addrecmt',
									function() {
										if ($(this).prev().val() == '') {
											alert('내용을 입력해주세요.');
											return;
										}
										$.ajax({
											type : 'post',
											url : '/code/comment/reply/save',
											data : $(this).closest(
													'.frm_recomment')
													.serialize(),
											dataType : 'json',
											success : function(resData) {
												if (resData.isSaveRe) {
													alert('대댓글이 등록되었습니다.');
													fn_cmtList();
													fn_commentCnt();
												}
											}
										})
									})
						}

						function fn_switchEditcmtArea() {
							$(document).on(
									'click',
									'.btn_editcmt_area',
									function() {
										$(this).parent().parent().parent().parent().next().next()
												.toggleClass('blind');
									});
						}

						function fn_editComment() {
							$(document)
									.on(
											'click',
											'.btn_editcmt',
											function() {
												if ($(this).prev().val() == '') {
													alert('내용을 입력해주세요.');
													return;
												}
												$
														.ajax({
															type : 'post',
															url : '/code/comment/edit',
															data : $(this)
																	.closest(
																			'.frm_editcmt')
																	.serialize(),
															dataType : 'json',
															success : function(
																	resData) {
																if (resData.isEdit) {
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
							$
									.ajax({
										type : 'get',
										url : '/code/likeCheck',
										data : 'coNo=${code.coNo}&nickname=${loginUser.nickname}',
										dataType : 'json',
										success : function(resData) {
											if (resData.count == 0) {
												$('#heart')
														.html(
																'<img src="../resources/images/whiteheart.png" width="15px">');
												$('#like').removeClass(
														"like_checked");
											} else {
												$('#heart')
														.html(
																'<img src="../resources/images/redheart.png" width="15px">');
												$('#like').addClass(
														"like_checked");
											}
										}
									})
						}

						// 좋아유 개수
						function fn_likeCount() {
							$.ajax({
								type : 'get',
								url : '/code/likeCnt',
								data : 'coNo=${code.coNo}',
								dataType : 'json',
								success : function(resData) {
									$('#like_count').empty();
									$('#like_count').text(resData.count);
								}
							})
						}

						// 좋아요 누른 경우
						function fn_pressLike() {
							$('#lnk_like')
									.click(
											function() {
												// 로그인 해야 누를 수 있음
												if ('${loginUser.nickname}' == '') {
													alert('해당 기능은 로그인이 필요합니다.');
													return;
												}
												// 셀프 좋아요 방지
												if ('${loginUser.nickname}' == '${code.nickname}') {
													alert('작성자의 게시글에서는 좋아요를 누를 수 없습니다.');
													return;
												}
												// 좋아요 선택/해제 상태에 따른 하트 상태 변경
												$('#like').toggleClass(
														"like_checked");
												if ($('#like').hasClass(
														"like_checked")) {
													$('#heart')
															.html(
																	'<img src="../resources/images/redheart.png" width="15px">');
												} else {
													$('#heart')
															.html(
																	'<img src="../resources/images/whiteheart.png" width="15px">');
												}

												// 좋아요 처리
												$
														.ajax({
															type : 'get',
															url : '/code/mark',
															data : 'coNo=${code.coNo}&nickname=${loginUser.nickname}',
															dataType : 'json',
															success : function(
																	resData) {
																if (resData.isSuccess) {
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
	<div id="root">
		<div class="studyContent_wrapper__VVyNH">
			<section class="studyContent_postHeader__2Qu_y">
				<div class="studyContent_title__3680o">${code.title}</div>
				<div class="studyContent_userAndDate__1iYDv">
					<div class="studyContent_user__1XYmH">
						<img class="studyContent_userImg__3gyI-"
							src="../../resources/images/monster.png" alt="userImg">
						<div class="studyContent_userName__1GBr8">${code.nickname}</div>
					</div>
					<div class="studyContent_registeredDate__3lybC">
						<fmt:formatDate value="${code.createDate}"
							pattern="yyyy.M.d a hh:m" />
					</div>
					<div class="studyContent_registeredDate__3lybC">조회
						${code.hit}</div>
				</div>
				<ul class="studyInfo_studyGrid__38Lfj">
					<li class="studyInfo_contentWrapper__KkSUP"><span
						class="studyInfo_title__3jXRE">다운로드</span>
						<div class="contactPoint_email__1a-aY">
							<a href="/upload/downloadAll?coNo=${upload.coNo}">ZIP 다운로드</a>
						</div></li>
					<li class="studyInfo_contentWrapper__KkSUP"><span
						class="studyInfo_title__3jXRE"></span>
						<div class="contactPoint_email__1a-aY"></div></li>
					<c:forEach items="${attachList}" var="attach" varStatus="status">
						<li class="studyInfo_contentWrapper__KkSUP"><span
							class="studyInfo_title__3jXRE">첨부파일${status.count}</span><span
							class="studyInfo_content__eqtqC"><a
								href="/upload/download?attachNo=${attach.attachNo}">${attach.origin}</a></span></li>
					</c:forEach>
				</ul>
				<div class="studyContent_postContentWrapper__187Zh">
					<div class="studyContent_postContent__2c-FO">${code.content}
					</div>
				</div>
			</section>

			<section class="studyContent_commentAndViews__LrV6X">
				<div class="studyContent_postComment__2lpJV">
					<div class="commentInput_commentInput__39H41">
						<div class="commentInput_buttonWrapper__2f_l10">
							<div class="navbar_loginElementWrapper__11CeH">
								<form id="frm_btn" method="post">
								<input type="hidden" name="coNo" value="${code.coNo}">
								<c:if test="${loginUser.nickname eq  code.nickname}">
										<button type="button"
											class="commentInput_buttonComplete__24z4B btn_remove"
											onclick="goPage(${question.qaNo},'del');">삭제</button>
										<button type="button"
											class="commentInput_buttonComplete__24z4B btn_modify"
											onclick="goPage(${question.qaNo}, 'mod');">수정</button>
								</c:if>
								</form>
							</div>
							<div class="navbar_loginElementWrapper__11CeH">
								<button type="button" class="commentInput_buttonComplete__24z4R"
									onclick="location.href='/code/list'">목록</button>
							</div>
						</div>
						
						<div class="commentInput_buttonWrapper__2f_l9"></div>
					</div>
					<ul class="commentList_CommentList__30HUh"></ul>
				</div>
			</section>
			<div class="commentInput_commentInput__39H41">
				<h1 class="commentInput_commentCount__2dHvH" id="btn_cmtlist">
					<span class="cmt_cnt"></span>개의 댓글이 있습니다.
				</h1>
				<a id="lnk_like" style="margin-bottom: 10px;"><span id="heart"></span><span id="like">좋아요
				</span><span id="like_count"></span>
				</a>
				<form id="frm_addcmt">
					<textarea class="commentInput_commentText__2er8t" name="cmtContent"
						id="content" placeholder="댓글을 입력하세요."></textarea>
					<div class="commentInput_buttonWrapper__2f_l9">
						<button class="commentInput_buttonComplete__24z4R" id="btn_addcmt">댓글
							등록</button>

					</div>
					<input type="hidden" name="coNo" value="${code.coNo}"> <input
						type="hidden" name="ip" value="${cmtList.ip}"> <input
						type="hidden" name="groupNo" value="0"> <input
						type="hidden" name="nickname" value="${loginUser.nickname}">
				</form>
			</div>
			<div id="cmt_area">
				<ul class="commentList_CommentList__30HUh" id="cmt_list">
				</ul>
				<div id="paging"></div>
			</div>
			
		</div>
		<div class="Toastify"></div>
	</div>

	<input type="hidden" id="page" value="1">
</body>
</html>