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
		$('#btn_check_pw').click(function(){
			
			$.ajax({
				type: 'post',
				url: '${contextPath}/user/check/pw',
				data: 'pw=' + $('#pw').val(),
				
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						location.href = '${contextPath}/user/info';
					} else {
						alert('비밀번호를 확인하세요.');
					}
				}
			});
		});
	});
	
</script>

</head>
<body>
	
	<div>개인정보 보호를 위해서 비밀번호를 입력해주세요</div>
	
	<div>
		<label for="pw">비밀번호</label>
		<input type="password" id="pw">
	</div>

	<div>
		<input type="button" value="확인" id="btn_check_pw">
		<input type="button" value="취소" onclick="history.back()">
	</div>

</body>
</html>