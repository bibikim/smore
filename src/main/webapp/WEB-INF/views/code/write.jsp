<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="새 글 작성" name="title"/>
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.css">

<script>
	
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
				onImageUpload: function(files) {
					
					// 1. 파일 여러개일경우도 있으니 for문을 돌린다
					for(let i = 0; i < files.length; i++) {
						// 2. 파일을 form에 담아준다. 왜냐하면 post 전송시 form이 필요하기 떄문에 
						var formData = new FormData();
						// 3. form에 file이라는 이름으로 데이터를 담는다.
						// ex) 이런식으로 생김 저 영어 두줄로 
						//	  <form> 
						//     <input type="hidden" name="file" value=""/>
						//	  </form>
						formData.append('file', files[i]);
						
						// 4. 데이터를 컨트롤러로 보내기 위한 행위 
						$.ajax({
							// 2번 참조 
							type: 'post',
							// 등록할떄 테이블 두곳에 데이터 넣어야 할듯 지금 몇개 넣어 몇개 넣었냐고 몇개넣으라고? ㄴㄴ 너가 등록 했짜나 ㅇㅇ 어느테이블에 들어감 ? 여긴가 
							url: '/code/uploadImage',
							// 위에서 생성한 formData 를 /code/uploadImage 컨트롤러에 전달 
							data: formData,
							contentType: false,
							processData: false,
							dataType: 'json',
							success: function(resData) {
								// 아나는 저기 리소스에 폴더따로 만들자고 한줄 임플쪾 소스만 바꾸면됨 
								$('#content').summernote('insertImage', resData.src);
								$('#sumnote_image_list').append($('<input type="hidden" name="cImageNames" value="' + resData.filesystem + '">'));
								//console.log(resData);
							}
						})	// ajax
					} // for
				} // onImageUpload
			} // callbacks
		});
		
		$('#btn_list').click(function(){
			location.href='/code/list';	
		});
		
		$('#btn_cancel').click(function(){
			history.back();
		});
		
		
		
		$('#frm_write').submit(function(ev){
			if($('#title').val() == '') {
				alert('제목을 입력해주세요.')
				ev.preventDefault();
				return;
			} else
			if($('#content').val() == '') {
				alert('본문을 입력해주세요.')
				ev.preventDefault();
				return;
			}
			
		});
		
	});

</script>
</head>
<body>
	
	<div>
		<form id="frm_write" action="/code/save" method="post">
			
			<input type="hidden" name="nickname" value="${loginUser.nickname}">

		
			<div>
				<div>
					<label for="title">제목</label>
				</div>
				<input type="text" id="title" name="title" placeholder="제목을 입력하세요.">
			</div>
		
			<div>
				<label for="content">내용</label>
				<textarea id="content" name="content"></textarea>
			</div>
			
			<div id="sumnote_image_list"></div>
			
			<div>
				<div>
					<input type="button" id="btn_cancel" value="취소">
					<input type="button" id="btn_list" value="목록">
					<button>등록</button>
				</div>
			</div>
		</form>
	</div>
	
</body>
</html>