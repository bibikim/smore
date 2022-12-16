<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>

<script>
	
	$(document).ready(function(){
		
		
		$('#btn_list').click(function(){
			location.href='/free/list';	
		});
		
		$('#btn_cancel').click(function(){
			history.back();
		});

		
	});

</script>
</head>
<body>
	
	<div>
		<form id="frm_write" action="/free/save" method="post">
			
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