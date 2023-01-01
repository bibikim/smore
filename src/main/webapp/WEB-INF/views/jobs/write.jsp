<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="/resources/css/base.css">

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>


<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.css">
<link rel="stylesheet" type="text/css" href="../../../resources/css/job/write.css">


<script>

	$(document).ready(function(){
		
		//https://quilljs.com/guides/how-to-customize-quill/
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			toolbar: [
			    
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['link']]
			]
		});
	
		$('#btn_list').click(function(){
			location.href='/job/list';	
		});
		
		$('#btn_cancel').click(function(){
			history.back();
		});
	
	
	
	});
	
</script>

</head>
<body>

	<div class="write-main">
		
		<hr>
		
			<div class="div-line">
				<span><a href="/job/list">JOB</a></span>
			</div>
			
				<form id="frm_write" action="/job/save" method="post">
				<input type="hidden" name="nickname" value="${loginUser.nickname}">
				<div class="part-wrapper">

					<div class="part1">
	
						<div class="h-div">
							<input type="hidden" name="${job.status}" required>
							<h5> 회사 정보 </h5>
						</div>
						<div>
							<label for="name"> 회사명 </label>
							<div>
								<input type="text" id="name" name="companyName" required>
							</div>
						</div>
						<div class="float">
							<label for="contact"> 대표 연락처 </label>
							<div>
								<input type="text" id="contact" name="contact" required>
							</div>
						</div>
						<div>
							<!-- detail => link로 바로 연결 되게 -->
							<label for="homepage"> 홈페이지 </label>
							<div>
								<input type="text" id="homepage" name="homepage" required>
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
							<input type="text" id="hrName" name="hrName" required>
						</div>
					</div>
					<div class="float">
						<label for="hrContact"> 담당자 연락처 </label>
						<div>
							<input type="text" id="hrContact" name="hrContact" required>
						</div>
					</div>
					<div>
						<!-- 정규식 조건 걸어보기 -->
						<label for="hrEmail"> 담당자 이메일 </label>
						<div>
							<input type="text" id="hrEmail" name="hrEmail" required>
						</div>
					</div>
					<div class="float">
						<label for="position"> 채용 포지션 </label>
						<div>
							<input type="text" id="position" name="position" required>
						</div>
					</div>
					<div>
						<label for="jobType"> 고용 형태 </label>
						<div>
							<!-- <input type="text" id="jobType" name="jobType"> -->
							<select id="jobType" name="jobType" required>
								<option value="" selected>선택</option>
								<option value="정규직">정규직</option>
								<option value="계약직">계약직</option>
							</select>
						</div>
					</div>
					<div>
						<label for="location"> 근무 지역 </label>
						<div>
							<span style="font-size: 9px;">'시, 구, 군' 까지만 적어주세요. 상세 주소는 하단의 본문에 적어주세요.</span>
						</div>
						<div>
							<input type="text" id="location" name="location" required>
						</div>
					</div>
					
					<div class="float">
						<label for="skillStack"> 기술 스택 </label>
						<div>
							<input type="text" id="skillStack" name="skillStack" required>
						</div>
					</div>
					
					
					<div>
						<label for="career"> 요구 경력 </label>
						<div>
							<!-- <input type="text" id="career" name="career"> -->
							<select id="career" name="career" required>
<!-- 								<option value="0" selected>경력 무관</option>
								<option value="1">신입 ~ 2년 이하</option>
								<option value="2">2년 이상 ~ 4년 이하</option>
								<option value="3">4년 이상 ~ 6년 이하</option>
								<option value="4">6년 이상 ~ 무관</option> 								-->
 								<option value="경력 무관" selected>경력 무관</option>
								<option value="신입 ~ 2년 이하">신입 ~ 2년 이하</option>
								<option value="2년 이상 ~ 4년 이하">2년 이상 ~ 4년 이하</option>
								<option value="4년 이상 ~ 6년 이하">4년 이상 ~ 6년 이하</option>
								<option value="6년 이상 ~ 무관">6년 이상 ~ 무관</option>
							</select>
						</div>
					</div>
				</div>

				<div style="margin: 10px 0 30px 0;">
					<label for="title">제목</label>
					<div>
						<input type="text" id="title" name="title" required>
					</div>
				</div>

				  <div style="margin-bottom: 30px;">
					  <label for="content">채용 정보</label>
					  <textarea id="content" name="content" required></textarea>
			      </div>
				  <div style="margin-bottom: 30px;">
						<label for="profile">회사 소개</label>
						<div>
							<textarea name="profile" id="profile" class="profile" required></textarea>
						</div>
			      </div>
				  <div class="float">
				  	  <input type="button" id="btn_cancel" value="작성 취소">
				  	  <input type="button" id="btn_list" value="목록">
				  </div>
				  <div>
				  	  <button style="margin-left: 540px;">작성 완료</button>
				  </div>
					
			   </div>
			</form>
		
	</div>	

</body>
</html>