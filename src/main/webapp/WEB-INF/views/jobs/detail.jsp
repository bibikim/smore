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

	$(function(){
		
		// 게시글 수정
		$('.btn_modify').click(function(){
			$('#frm_btn').attr('action', '/job/edit');
			$('#frm_btn').submit();
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
				
				<div class="main-column">
					<span>${job.companyName}</span>
					<div class="share-link">
						<img src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/26/null/external-share-user-interface-basic-anggara-outline-color-anggara-putra.png"/>
						<button>공유하기</button>
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
						<img src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/25/null/external-link-social-media-interface-anggara-outline-color-anggara-putra.png"/>
						<button>url복사</button>
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
				
			<div class="content-wrapper">
				<div class="block">
					기술 스택
				</div>
				
				<div class="job-content">
					<div class="in-content">
						<div>채용 공고</div>
						<div>
							<div>${job.content}</div>
						</div>
					</div>
				</div>
			</div>	
		
		
		
		<div id="gubun"></div>
		
		<!-- 회사 profile 존 -->
		<br>
		
		<div class="hr_info">
			<div>담당자</div>
			<div>
				<div><img src="https://img.icons8.com/external-anggara-outline-color-anggara-putra/32/null/external-user-basic-user-interface-anggara-outline-color-anggara-putra.png"/>${job.hrName}</div>
				<div><img src="https://img.icons8.com/ios/30/null/phone--v1.png"/>${job.hrContact}</div>
				<div><img src="https://img.icons8.com/cotton/30/null/secured-letter--v2.png"/>${job.hrEmail}</div>
			</div>
		</div>
		
		<br>
		
		
		<div style="width: 200px; display: inline-block;">
			<form id="frm_btn" method="post">
				<input type="hidden" name="jobNo" value="${job.jobNo}">
				<input type="button" value="수정" class="btn_modify">
			</form>
		</div>
		
		
	</div>	

</body>
</html>