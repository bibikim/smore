<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

<style>

	a {
		text-decoration-line: none ;
		cursor: pointer;
		color: black;
	}
	
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
	
	.float {
		float:left; 
		margin-right: 70px;
	}
	
	input[type=text] {
		 width: 300px;
		 height: 32px;
		 ont-size: 15px;
		 border: 0;
		 border-radius: 7px;
		 outline: none;
		 padding-left: 10px;
		 background-color: rgb(233, 233, 233);   /* rgb(200, 225, 323); */
	}
	label {
		margin-top: 20px;
	}
	
	.h-div {
		margin-top: 50px;
	}
	select {
	    width: 300px;
	    border: 1px solid #C4C4C4;
	    box-sizing: border-box;
	    border-radius: 10px;
	    padding: 12px 13px;
	    font-family: 'Roboto';
	    font-style: normal;
	    font-weight: 400;
	    font-size: 14px;
	    line-height: 16px;
	}
	
	.profile {
		width: 800px; 
		height:300px;
		background-color: white; 
		border: 1px solid #C4C4C4;
		border-radius: 7px;
	}
	
	
</style>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.css">

<script>

	$(document).ready(function(){
		
		//https://quilljs.com/guides/how-to-customize-quill/
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['link']]
			]
		});
	});
	
 	$(document).ready(function(){
 		
 		var careerval = $('#careerval').val();
 		console.log(care);

		  $('#career').each(function(){

			  
			  
		    if($(this).val() == care){  // 값을 주고나서 

		      $(this).prop('selected', true); // attr적용안될경우 prop으로 

		    }

		  });

		}); 
/* 		
	$(function() {
		$('#career').val() == '${job.career}'
	}) */
	
</script>

</head>
<body>

	<div class="edit-main">
		
		<hr>
		
			<div class="div-line">
				<span><a href="/job/list"> JOB </a></span>
			</div>
			
				<form id="frm_edit" action="/job/modify" method="post">
				
				<div>

					<div class="part1">
						<input type="hidden" name="jobNo" value="${job.jobNo}">
						<div class="h-div">
							<h5> 회사 정보 </h5>
						</div>
						<div>
							<label for="name"> 회사명 </label>
							<div>
								<input type="text" id="name" name="companyName" value="${job.companyName}" readonly>
							</div>
						</div>
						<div class="float">
							<label for="contact"> 대표 연락처 </label>
							<div>
								<input type="text" id="contact" name="contact" value="${job.contact}">
							</div>
						</div>
						<div>
							<!-- detail => link로 바로 연결 되게 -->
							<label for="homepage"> 홈페이지 </label>
							<div>
								<input type="text" id="homepage" name="homepage" value="${job.homepage}">
							</div>
						</div>
					</div>
	
				<div class="part2">
					<div class="h-div">
						<h5> 채용 담당자 정보 </h5>
					</div>
					<div>
						<label for="hrName"> 담당자명 </label>
						<div>
							<input type="text" id="hrName" name="hrName" value="${job.hrName}">
						</div>
					</div>
					<div class="float">
						<label for="hrContact"> 담당자 연락처 </label>
						<div>
							<input type="text" id="hrContact" name="hrContact" value="${job.hrContact}">
						</div>
					</div>
					<div>
						<!-- 정규식 조건 걸어보기 -->
						<label for="hrEmail"> 담당자 이메일 </label>
						<div>
							<input type="text" id="hrEmail" name="hrEmail" value="${job.hrEmail}">
						</div>
					</div>
					<div class="float">
						<label for="position"> 채용 포지션 </label>
						<div>
							<input type="text" id="position" name="position" value="${job.position}">
						</div>
					</div>
					<div>
						<label for="jobType"> 고용 형태 </label>
						<div>
							<input type="text" id="jobType" name="jobType" value="${job.jobType}">
						</div>
					</div>
					<div>
						<label for="location"> 근무 지역 </label>
						<div></div>
							<span style="font-size: 9px;">'시, 구, 군' 까지만 적어주세요. 상세 주소는 하단의 본문에 적어주세요.</span>
						</div>
						<div>
							<input type="text" id="location" name="location" value="${job.location}">
						</div>
					</div>
					
					<div class="float">
						<label for="skillStack"> 기술 스택 </label>
						<div>
							<input type="text" id="skillStack" name="skillStack" value="${job.skillStack}">
						</div>
					</div>
					
					<div>
						<label for="career"> 요구 경력 </label>
						<div>
							<!-- <input type="text" id="career" name="career"> -->
							<select id="career" name="career" >
<%-- 									<option id="opt" value="경력 무관"
										<c:if test="${job.career == '경력 무관'}" selected</c:if>>경력 무관</option>
									<option id="opt" value="신입 ~ 2년 이하"
										<c:if test="${job.career == '신입 ~ 2년 이하'}"> selected</c:if>>신입 ~ 2년 이하</option>
									<option id="opt" value="2년 이상 ~ 4년 이하"
										<c:if test="${job.career == '2년 이상 ~ 4년 이하'}"> selected</c:if>>2년 이상 ~ 4년 이하</option>
									<option id="opt" value="6년 이상 ~ 무관"
										<c:if test="${job.career == '6년 이상 ~ 무관'}"> selected</c:if>>6년 이상 ~ 무관</option> --%>
										
 									<option id="opt" value="신입 ~ 2년 이하">신입 ~ 2년 이하</option>
									<option id="opt" value="2년 이상 ~ 4년 이하">2년 이상 ~ 4년 이하</option>
									<option id="opt" value="4년 이상 ~ 6년 이하">4년 이상 ~ 6년 이하</option>
									<option id="opt" value="6년 이상 ~ 무관">6년 이상 ~ 무관</option> 
							
<!-- 								<option id="opt" value="1">경력 무관</option>
								<option id="opt" value="2">신입 ~ 2년 이하</option>
								<option id="opt" value="3">2년 이상 ~ 4년 이하</option>
								<option id="opt" value="4">4년 이상 ~ 6년 이하</option>
								<option id="opt" value="6년 이상 ~ 무관">6년 이상 ~ 무관</option> -->
							</select>
						</div>
					</div>
				</div>

				<div style="margin: 10px 0 10px 0;">
					<label for="title">제목</label>
					<div>
						<input type="text" id="title" name="title" value="${job.title}" style="width: 800px; height:43px;background-color: white; border: 1px solid #C4C4C4;" >
					</div>
				</div>

				  <div>
					  <label for="content">채용 정보</label>
					  <textarea id="content" name="content">${job.content}</textarea>
			      </div>
			      <div style="margin-bottom: 30px;">
					  <label for="profile">회사 소개</label>
					  <div>
						  <textarea name="profile" id="profile" class="profile">${job.profile}</textarea>
					  </div>
			      </div>
				  <div class="float">
				  	  <input type="button" id="btn_cancel" value="작성 취소">
				  	  <input type="button" id="btn_list" value="목록">
				  </div>
				  <div>
				  	  <button style="margin-left: 540px;">수정 완료</button>
				  </div>

				
			</form>
			<input type="hidden" id="careerval" value="${job.career}">
	</div>	

</body>
</html>