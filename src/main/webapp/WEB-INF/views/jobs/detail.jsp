<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="JOBS" name="title"/>
</jsp:include>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>


<style>

	.div-line {
		display: flex;
		flex-basis: 100%;
		font-size: 18px;
		margin: 8px 0px;
		align-items: center;
	}
	
	.div-line::before {
		content: "";
		flex-grow: 1;
		margin: 0px 16px;
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		background: lightgray;
	}
	
	.div-line::after {
		content: "";
		flex-grow: 1;
		margin: 0px 16px;
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		background: lightgray;
	}
	
	.divbg-gray {
		background-color: #e0eeee;
		border-radius: 5px;
	}
	
	.first {
    	float: left;
    	width:30%;
    	box-sizing: border-box;
	}

	.second{
    	float: left;
    	margin-left: 5%;
    	width:30%;
    	box-sizing: border-box;
	}

	.third{
    	float: right;
   		width:30%;
    	box-sizing: border-box;
	}
	.div-pd {
		padding: 25px 20px 25px 20px;
	}

	.job-content {
		 position: relative;
	}
	.in-content {
		 /*position: absolute; top: 50%; transform: translateY(-50%);*/

	}
	#gubun {
		background: #bdbdbd; 
		height: 1px; 
		margin: 15px 15px 0 15px;
	}
	#div-skill {
  		margin: 20px 0 0 20px;
  		/* border-bottom: 1px solid black; */
	}
	.hr-info {
		width: 1000px;
        margin: 0 auto;
        text-align: center; 
	}
	
	.hr-div {
        display: inline-block; /*이부분에 성질을 inline-block로 바꿔줘서 가로배치를 해줬다.*/
        vertical-align: top; 
        margin: 20px 0 15px 0;
	}
	.hr-co {
		display: inline-block; 
		margin-right: 70px;
		margin-left: 20px;
		float: left;
	}
	.hr-name {
		margin-right: 70px;
	}
	.hr-contact {
		margin-right: 70px;
	}

	.hr-icon1 {
		margin: 3px 8px 7px 0;
	}
	.hr-icon2 {
		margin: 3px 8px 8px 0;
	}
	.hr-icon3 {
		margin: 2px 8px 8px 0;
	}
	
	.div-profile {
		border: 1px solid #bdbdbd;
		border-radius: 5px;
		margin: 36px 10px 0 10px; 
	}
	.head-profile {
		margin: 22px 0 0 20px;  
	}
	
	.sub-profile {
		margin-top: 32px;
		margin-left: 20px;  
		font-size: 15px; 
		font-weight: 600;
	}
	.in-sub-profile {
		margin-top: 18px; 
		font-size: 16px; 
		font-weight: 400;
	}
	#hp-link {
		margin: 16px 0 22px 20px;
	}
	
	.sns img {cursor:pointer;}
	.sns .hide {display:none;}
	
</style>
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
				<div class="main-column">
					<span>${job.companyName}</span>
					<div class="share-link">
						<div>
							<img src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/26/null/external-share-user-interface-basic-anggara-outline-color-anggara-putra.png"/>
						</div>
							<ul class="sns">
								<li class="facebook">
								<a id="btnFacebook"><img src="https://img.icons8.com/ios-glyphs/25/null/facebook-new.png"/>&nbsp;&nbsp;facebook</a> 
								</li>
								<li class="twitter">
								<a id="btnTwitter"><img src="https://img.icons8.com/ios-filled/25/null/twitter.png"/>&nbsp;&nbsp;twitter</a>
								</li>
								<li class="kakao">
								<a id="btnKakao"><img src="https://img.icons8.com/ios/25/null/kakao-talk.png"/>&nbsp;&nbsp;kakao</a>
								</li>
							</ul>
						<a href="#" onclick="fn_linkCopy()">
						<img src="https://img.icons8.com/windows/25/null/clone-figure.png"/>
						</a>
					</div>
				</div>
		
				<h2><span>${job.title}</span></h2>
				
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
						<div style="margin: 50px 0 0 20px; font-weight: bold;">채용 공고</div>
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
				<c:if test="${loginUSer.grade == 3}">
					<span style="font-size: 14px;">채용 공고 삭제는 관리자에게 문의주세요.</span>
				</c:if>
			</div>
			
		</div>
		
		
	</div>	

</body>
</html>