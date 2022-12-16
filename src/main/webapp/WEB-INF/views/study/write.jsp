<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<script>
	
	// contextPath를 반환하는 자바스크립트 함수수수수수
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		 return location.href.substring(begin, end);
	}
	
	$(document).ready(function(){
		
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
			    ['insert', ['link', 'picture', 'video']]
			],
			callbacks: {
				// summernote 편집기에 이미지를 로드할 때 이미지는 function의 매개변수 files로 전달됨 
				onImageUpload: function(files){
					// 동시에 여러 이미지를 올릴 수 있음
					for(let i = 0; i < files.length; i++) {
						// 이미지를 ajax를 이용해서 서버로 보낼 때 가상 form 데이터 사용 
						var formData = new FormData();
						formData.append('file', files[i]);  // 파라미터 file, summernote 편집기에 추가된 이미지가 files[i]임						
						// 이미지를 HDD에 저장하고 경로를 받아오는 ajax
						$.ajax({
							type: 'post',
							url: getContextPath() + '/blog/uploadImage',
							data: formData,
							contentType: false,  // ajax 이미지 첨부용
							processData: false,  // ajax 이미지 첨부용
							dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
							success: function(resData){
								
								/*
									resData의 src 속성값이 ${contextPath}/load/image/aaa.jpg인 경우
									<img src="${contextPath}/load/image/aaa.jpg"> 태그가 만들어진다.
									
									mapping=${contextPath}/load/image/aaa.jpg인 이미지의 실제 위치는
									location=C:\\upload\\aaa.jpg이므로 이 내용을
									servlet-context.xml에서 resource의 mapping값과 location값으로 등록해 준다.
									(스프링에서 정적 자원 표시하는 방법은 servlet-context.xml에 있다.)
								*/
								$('#content').summernote('insertImage', resData.src);
								
								/*
									어떤 파일이 HDD에 저장되어 있는지 목록을 저장해 둔다.
									블로그를 등록할 때 써머노트에서 사용한 파일명도 함께 등록한다.
								*/
								$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.filesystem + '">'))
								
							}
						});  // ajax
					}  // for
				}  // onImageUpload
			}  // callbacks
		});
		

		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/study/list';
		});

		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});
		
	});

	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_write" action="/study/add" method="post">
	
		<div>
			작성자 ▷ ${loginUser.name}
			<input type="hidden" name="studyNo" value="${loginUser.userNo}">
		</div>
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"></textarea>				
		</div>
		
		<div>
			<label for="gender">성별</label>
			   <input type="radio" name="gender" id="male" value="M">
               <label for="male">남자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="female" value="F">
               <label for="female">여자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="both" value="B">
               <label for="both">상관없음</label>
		</div>
		
		<div>
			<label for="region">지역</label>
			<select name="region" id="region">
				<option value = "경기" selected>경기</option>
				<option value = "부산" >부산</option>
				<option value = "대구" >대구</option>
				<option value = "광주" >광주</option>
			</select>
		</div>
		
		<div>
			<label for="wido">위도</label>
			<input type="text" name="wido" id="wido">	
		</div>
		
		<div>
			<label for="gdo">경도</label>
			<input type="text" name="gdo" id="gdo">
		</div>
		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) 
		<div id="summernote_image_list"></div>
		-->
		<div>
			<label for="lang">개발언어</label>
			<select name="lang" id="lang">
				<option value = "자바" selected>JAVA</option>
				<option value = "파이썬" >PYTHON</option>
				<option value = "C" >C</option>
			</select>
		</div>
		
		<div>
			<label for="people">정원</label>
			<select name="people" id="people">
				<option value = "2" selected>2</option>
				<option value = "3" >3</option>
				<option value = "4" >4</option>
			</select>
		</div>
		
		<div>
			<label for="contact">연락방법</label>
			<input type="text" name="contact" id="contact">
		</div>
		
		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list" onclick="location.href='/study/list';">
		</div>
		
	</form>
	
</div>

</body>
</html>