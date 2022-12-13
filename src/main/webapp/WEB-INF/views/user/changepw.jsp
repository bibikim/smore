<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="비밀번호 변경하기" name="title"/>
</jsp:include>

<style>


</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function() {
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
	});
	
	var pwPass = false;
	var rePwPass = false;
	
	function fn_init() {
		$('#pw').val('');
		$('#re_pw').val('');
		$('#msg_pw').val('');
		$('#msg_re_pw').val('');
	}
	
	function fn_pwCheck() {
		$('#pw').keyup(function() {
			let pwValue = $(this).val();
			let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
			let validatePw = /[0-9]/.test(pwValue) 
            + /[a-z]/.test(pwValue) 
            + /[A-Z]/.test(pwValue) 
            + /[!@#$%^&*]/.test(pwValue);
			
			if(regPw.test(pwValue) == false || validatePw < 3) {
				$('#msg_pw').text('8~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
				pwPass = false;
			} else {
				$('#msg_pw').text('사용 가능한 비밀번호입니다.');
				pwPass = true;
			}
		});
	}
	
	function fn_pwCheckAgain() {
		$('#re_pw').keyup(function() {
			let rePwValue = $(this).val();
			
			if(rePwValue != '' && rePwValue != $('#pw').val()) {
				$('#msg_re_pw').text('비밀번호를 확인하세요.');
				repwPass = false;
			} else {
				$('#msg_re_pw').text('');
				repwPass = true;
			}
		});
	}
</script>

</head>
<body>
	
	<div id="modify_pw_area">
		<form id="frm_edit_pw" action="${contextPath}/user/modify/pw" method="post">
			<div>
				<label for="pw">변경 비밀번호</label>
				<input type="password" name="pw" id="pw">
				<span id="msg_pw"></span>
			</div>
			<div>
				<label for="re_pw">변경 비밀번호 확인</label>
				<input type="password" id="re_pw">
				<span id="msg_re_pw"></span>
			</div>
			<div>
				<input type="button" value="변경">
				<input type="button" value="취소" onclick="history.go(-2)">
			</div>
		</form>
	</div>
	
	


</body>
</html>