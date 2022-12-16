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
		$('#qContent').summernote({
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
					for(let i = 0; i < files.length; i++) {
						var formData = new FormData();
						formData.append('file', files[i]);
						
						$.ajax({
							type: 'post',
							url: '/qna/uploadImage',
							data: formData,
							contentType: false,
							processData: false,
							dataType: 'json',
							success: function(resData) {
								$('#content').summernote('insertImage', resData.src);
								$('#sumnote_image_list').append($('<input type="hidden" name="qImageNames" value="' + resData.filesystem + '">'));
							}
						})	// ajax
					} // for
				} // onImageUpload
			} // callbacks
		});
		
		$('#btn_list').click(function(){
			location.href='/qna/list';	
		});
		
		$('#btn_cancel').click(function(){
			history.back();
		});
		
		
		
		$('#frm_write').submit(function(ev){
			if($('#qTitle').val() == '') {
				alert('제목을 입력해주세요.')
				ev.preventDefault();
				return;
			} else
			if($('#qContent').val() == '') {
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
		<form id="frm_write" action="/qna/save" method="post">
			
			<input type="hidden" name="nickname" value="${loginUser.nickname}">

		
			<div>
				<div>
					<label for="qTitle">제목</label>
				</div>
				<input type="text" id="qTitle" name="qTitle" placeholder="제목을 입력하세요.">
			</div>
		
			<div>
				<label for="qContent">내용</label>
				<textarea id="qContent" name="qContent"></textarea>
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