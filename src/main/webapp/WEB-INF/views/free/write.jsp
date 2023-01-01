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
<link rel="stylesheet" type="text/css" href="../../../resources/css/free/write.css">

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
					for(let i = 0; i < files.length; i++) {
						var formData = new FormData();
						formData.append('file', files[i]);
						
						$.ajax({
							type: 'post',
							url: '/free/uploadImage',
							data: formData,
							contentType: false,
							processData: false,
							dataType: 'json',
							success: function(resData) {
								$('#content').summernote('insertImage', resData.src);
								$('#sumnote_image_list').append($('<input type="hidden" name="fImageNames" value="' + resData.filesystem + '">'));
								console.log(resData);
							}
						})	// ajax
					} // for
				} // onImageUpload
			} // callbacks
		});
		
		$('#btn_list').click(function(){
			location.href='/free/list';	
		});
		
		$('#btn_cancel').click(function(){
			history.back();
		});
		
		
		
		$('#frm_write').submit(function(ev){
			if($('.title').val() == '') {
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
	
	<div class="wr-wrapper">
		<div class="div-write">
			<form id="frm_write" action="/free/save" method="post">
				
				<input type="hidden" name="nickname" value="${loginUser.nickname}">
	
				<div class="wr-title">
					<input type="text" class="title" name="title" placeholder="제목을 입력하세요.">
				</div>
			
				<div class="wr-content">
					<label for="content">내용</label>
					<textarea id="content" name="content"></textarea>
				</div>
				
				<div id="sumnote_image_list"></div>
				
				<div>

					<div id="btn_group">
 						<input type="button" id="btn_cancel" value="취소">
						<input type="button" id="btn_list" value="목록">
<!-- 						<button id="btn_cancel">취소</button>
						<button id="btn_list">목록</button> -->
						<button id="btn_submit">등록</button>
					</div>

				</div>
			</form>
		</div>
	</div>
	
	
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

