<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="/resources/css/base.css">


<jsp:include page="../layout/header.jsp">
   <jsp:param value="JOBS" name="title"/>
</jsp:include>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../../resources/css/job/detail.css">


<script>

	function fn_shareTwitter() {
		
		var sendText = "s'more JOBS 게시판 채용 공고";
		var sendUrl = document.URL;
		window.open("http://www.twitter.com/share?url=" +  encodeURIComponent(sendUrl) + "&text=" + sendText);
		
	}
	
	function fn_shareFacebook() {
		
		var sendUrl = document.URL;
		window.open("http://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(sendUrl));
	}
	
	function fn_shareKakao() {
		
		if(!Kakao.isInitialized()) {
			Kakao.init('3498d28228382193033c95aa189bdaa2');
		}
		//console.log(Kakao.isInitialized());
		
		Kakao.Link.createDefaultButton({
			container: '#btnKakao',
			objectType: 'feed',
			content: {
				title : "s'more JOBS 게시판 채용 공고",
				imageUrl: "https://ifh.cc/g/x8J2dp.png",
				link: {
					webUrl: document.URL,
				}
			}
		})
	}
	
	function fn_linkCopy() {
		
		var url = '';
		var linkURL = document.createElement("input");
		
		document.body.appendChild(linkURL);
		url = window.document.location.href;
		linkURL.value = url;
		linkURL.select();
		document.execCommand("copy"); 
		document.body.removeChild(linkURL);
		
		alert("Copy!");
	}

	
	$(function(){
		
		// 게시글 수정
		$('.btn_modify').click(function(){
			$('#frm_btn').attr('action', '/job/edit');
			$('#frm_btn').submit();
		})
		
		$('.btn_modify').click(function(ev){
			if('${loginUser.grade}' != 3) {
				alert('기업회원만 수정 가능합니다.');
				ev.preventDefault();
				return;
			}
		})
		
		$('.btn_remv').click(function(){
			if('${loginUser.grade}' != 0) {
				alert('관리자만 삭제 가능합니다.');
			}
		})
		
		$('.btn_remv').click(function(){
			if(confirm('해당 게시글을 정말 삭제하시겠습니까?')) {
				$('#frm_btn').attr('action', '/job/remv');
				$('#frm_btn').submit();
			}
		})
		
		$('.btn_expire').click(function() {
			if(confirm('해당 공고를 마감하시겠습니까?')) {
				location.href = '/job/change/status?jobNo=' + ${job.jobNo} ;
			}
		})
		
		
		// 링크 공유
		$('#btnFacebook').click(function() {
			fn_shareFacebook();
		})
		
		$('#btnTwitter').click(function() {
			fn_shareTwitter();
		})
		
		$('#btnKakao').click(function() {
			fn_shareKakao();
		})
		
		
		// 스크랩 함수 호출
		fn_scrapCheck();
		fn_list();
/* 		fn_scrapCount(); */
		fn_pressScrap(); 
		
		function fn_scrapCheck() {
			
			$.ajax ({
				type: 'get',
				url: '/job/scrapCheck',
				data: 'jobNo=${job.jobNo}&nickname=${loginUser.nickname}',
				dataType: 'json',
				success: function(resData) {
					if(resData.count == 0) {
						$('#scrap').html('<img src="../resources/images/b-bookmark.png" width="20px">');
						$('#scrap').removeClass("zzim_checked");
					} else {
						$('#scrap').html('<img src="../resources/images/f-bookmark.png" width="20px">');
						$('#scrap').addClass("zzim_checked");
					}
				}
			})
		}
		
		function fn_list() {
			
			$('.share-link').click(function(){
				if($('.sns').is(':visible')) {
					$('.sns').slideUp();
				} else {
					$('.sns').slideDown();
				}
			})
			
		}
		
		
		// 스크랩을 누른 경우
		function fn_pressScrap() {

			$('#lnk_scrap').click(function(){
				if('${loginUser.nickname}' == '') {
					alert('해당 기능은 로그인이 필요합니다.');
					return;
				} 
				// 셀프 스크랩 방지
				if('${loginUser.nickname}' == '${job.nickname}') {
					alert('작성자의 게시글에서는 스크랩이 불가합니다.');
					return;
				}
				// 스크랩 선택/해제 상태 변경
				$('#zzim').toggleClass("zzim_checked");
				if($('#zzim').hasClass("zzim_checked")) {
					$('#scrap').html('<img src="../resources/images/f-bookmark.png" width="20px">');
				} else {
					$('#scrap').html('<img src="../resources/images/b-bookmark.png" width="20px">');
				}
			
				// 스크랩 처리
				$.ajax({
					type: 'get',
					url: '/job/scrap',
					data: 'jobNo=${job.jobNo}&nickname=${loginUser.nickname}',
					dataType: 'json',
					success: function(resData) {
						if(resData.isScrap) {
							alert('스크랩 되었습니다.');

						}
					}
				}); // ajax
			})
		}
		
		
	});
	

	
</script>

</head>
<body>

	<div class="detail-main">
		
		<hr>
		
			<div class="div-line">
				<span><a href="/job/list"> JOB </a></span>
			</div>

			<div class="detail-wrapper">
			
				<input type="hidden" name="${job.status}">
				<div class="main-column" >
					<div style="float: left;"><h5>⊹&nbsp;${job.companyName}</h5></div>
					<div class="sns-wrapper">
						<div class="share" style="text-align: right;">
							<div class="share-link">
								<img src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/26/null/external-share-user-interface-basic-anggara-outline-color-anggara-putra.png"/>
							</div>
	
							<div class="share-sns">
								<ul class="sns">
									<li class="facebook">
										<a id="btnFacebook"><img src="https://img.icons8.com/ios-glyphs/25/null/facebook-new.png"/>&nbsp;&nbsp;facebook</a> 
									</li>
									<li class="twitter">
										<a id="btnTwitter" style="padding-left: 27px;"><img src="https://img.icons8.com/ios-filled/25/null/twitter.png"/>&nbsp;&nbsp;twitter</a>
									</li>
									<li class="kakao">
										<a id="btnKakao" style="padding-left: 27px;"><img src="https://img.icons8.com/ios/25/null/kakao-talk.png"/>&nbsp;&nbsp;kakao</a>
									</li>
								</ul>
							</div>
	
							<div class="btn_copy">
								<a href="#" onclick="fn_linkCopy()">
								<img src="https://img.icons8.com/windows/25/null/clone-figure.png"/></a>
							</div>
						</div>
<!-- 							<div class="btn_scrap">
								스크랩 버튼
								<a id="lnk_scrap">
									<span id="scrap"></span><span id="zzim">스크랩</span>
								</a>
							</div> -->
					</div> <!-- main-column -->
				</div>
		
				<div style="clear: both;"></div>
				<div class="job-title">${job.title}</div>
				
				<div class="divbg-gray first div-pd">
					<div class="padd-div">포지션</div>
					<div>
						<img style="margin-top: 8px;" src="https://img.icons8.com/material-two-tone/18/null/source-code.png"/>
						<span>${job.position}</span>
					</div>
				</div>
				
				<div class="divbg-gray second div-pd">
					<div>필요 경력</div>
					<div>
						<img style="margin-top: 8px;" src="https://img.icons8.com/external-flatart-icons-lineal-color-flatarticons/18/null/external-career-achievements-and-badges-flatart-icons-lineal-color-flatarticons.png"/>
						<span>${job.career}</span>
					</div>
				</div>
				
				<div class="divbg-gray third div-pd">
					<div>근무지역</div>
					<div>
						<img style="margin-top: 8px;" src="https://img.icons8.com/fluency-systems-regular/18/null/place-marker--v1.png"/>
						<span>${job.location}</span>
					</div>
				</div>
			</div>  <!-- detail-wrapper -->

			<div style="clear:both;" ></div>	<!-- div에 float 속성을 준게 있으면 하위 div들이 그 아래로 딸려 들어가기 때문에 clear 속성으로 초기화?해야 한다 -->
				
			<div class="content-wrapper">
				<div class="block">
					<div id="div-skill">
						<div style="float: left; margin-right: 50px;">기술 스택</div>
						<div style="color: #039BE5">${job.skillStack}</div>
					</div>
				</div>

			<div style="background: #bdbdbd; height: 1px; margin: 10px 15px 10px 15px;"></div> 
				
				
				<div style="clear:both;" ></div>	
				
				<div class="job-content">
					<div class="in-content">
						<div class="opening">채용 공고</div>
						
						<div class="btn_scrap" style="text-align: right; margin-right: 30px;">
							<!-- 스크랩 버튼 -->
							<a id="lnk_scrap">
								<span id="scrap"></span><span id="zzim" style="font-size: 14px;">스크랩</span>
							</a>
						</div>
						
						<div>
							<div style="margin: 20px 0 0 20px;">${job.content}</div>
						</div>
					</div>
				</div>
			</div>	
		
		
		
		<div id="gubun"></div>
		
		<!-- 회사 profile 존 -->
		<br>
		
		<div class="hr_info">
			<div class="hr-div hr-co">담당자</div>
				<div class="hr-sub">
					<div class="hr-div hr-name"><img class="hr-icon hr-icon1" src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/32/null/external-user-user-interface-basic-anggara-outline-color-anggara-putra.png"/>${job.hrName}</div>
					<div class="hr-div hr-contact" ><img class="hr-icon hr-icon2" src="https://img.icons8.com/ios/28/null/phone--v1.png"/>${job.hrContact}</div>
					<div class="hr-div hr-email" ><img class="hr-icon hr-icon2" src="https://img.icons8.com/cotton/30/null/secured-letter--v2.png"/>${job.hrEmail}</div>
				</div>
		</div>
		
		<br>
		
		<div class="div-profile">
			<div class="head-profile">
				<div style="font-size: 25px;">
					${job.companyName}				
				</div>
				<div style="font-size: 15px;">
					<img style="margin-bottom: 2px;" src="https://img.icons8.com/fluency-systems-regular/18/null/place-marker--v1.png"/>
					${job.location}
				</div>
			</div>
			<div class="sub-profile">
				회사 소개
				<div class="in-sub-profile">
					<p>${job.profile}</p>
				</div>
			</div>
			<div id="gubun"></div>
			<div id="hp-link">
				<img style="margin-top: 8px;" src="https://img.icons8.com/fluency-systems-regular/25/null/web-globe.png"/>
				<a href="${job.homepage}" style="color: #039BE5; font-size: 18px; font-weight: 600;">${job.homepage}</a>
			</div>
		</div>
		
		
		<div style="width: 200px; display: inline-block;">
			<form id="frm_btn" method="post">
				<c:if test="${loginUser.nickname == job.nickname}">
					<input type="hidden" name="jobNo" value="${job.jobNo}">
					<input type="hidden" name="nickname" value="${job.nickname}">
					<div style="float: left;">
						<input type="button" value="수정" class="btn_modify">
						<input type="button" value="채용 완료" class="btn_expire">
					</div>
				</c:if>
				<c:if test="${loginUser.grade == 0}">
					<input type="hidden" name="jobNo" value="${job.jobNo}">
					<input type="button" value="삭제" class="btn_remv">
				</c:if>
			</form>
			<div>
				<div style="clear: both;"></div>
				<c:if test="${loginUser.grade == 3}">
					<div style="font-size: 15px; width: 320px; margin-bottom: 30px;"> ✔ 채용 공고 삭제는 관리자에게 문의주세요. </div>
				</c:if>
			</div>
			
		</div>
		
		
	</div>	

<jsp:include page="../layout/footer.jsp">
   <jsp:param value="JOBS" name="title"/>
</jsp:include>