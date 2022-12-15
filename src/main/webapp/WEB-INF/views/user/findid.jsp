<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="아이디 찾기" name="title"/>
</jsp:include>

<style>



</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script>
<script>

	$(document).ready(function(){
		fn_findId();
	});
	
	function fn_findId(){
		$('#btn_findId').click(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			if (regEmail.test($('#email').val()) == false) {
				alert('이메일 형식을 확인하세요.');
				$('#msg_result').text('');
				return;
			}
			$.ajax({
				url: '${contextPath}/user/findId',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					name: $('#name').val(),
					email: $('#email').val()
				}),
				dataType: 'json',
				success: function(resData) {
					if (resData.findUser != null) {
						let id = resData.findUser.id;
						id = id.substring(0, 3) + '*****';
						moment.locale('ko-KR');
						$('#msg_result').html('회원님의 아이디는 ' + id + '입니다.<br>(가입일 : ' + moment(resData.findUser.joinDate).format("YYYY년 MM월 DD일 a h:mm:ss") + ')');
					} else {
						$('#msg_result').html('일치하는 회원이 없습니다. 입력 정보를 확인하세요.');
					}
				}
			});
		});
	}

</script>

</head>
<body>

	<h1>아이디 찾기</h1>
	<hr>
	<div>
		<label for="name">
			*이름<br>
			<input type="text" name="name" id="name">
		</label>
	</div>
	
	<div>
		<label for="email">
			*이메일<br>
			<input type="text" name="email" id="email">
		</label>
	</div>
	
	<div>
		<input type="button" value="아이디찾기" id="btn_findId">
	</div>
	
	<div>
		<a href="${contextPath}/user/login/form">로그인</a> | 
		<a href="${contextPath}/user/findPw/form">비밀번호 찾기</a> |
		<a href="${contextPath}/user/agree/form">회원가입</a>
	</div>
	<hr>
	<div id="msg_result"></div>

</body>
</html>