<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${loginUser.nickname}님 마이페이지" name="title"/>
</jsp:include>

<style>

	li {
		list-style: none;
	}
	
	a {
		text-decoration-line: none;
		cursor: pointer;
      	color: black;
	}
	a:visited { text-decoration: none; }
	a:hover { text-decoration: none; }
	a:focus { text-decoration: none; }
	a:hover, a:active { text-decoration: none; }

	.my_box_area {
		width:70%; 
		border:1px solid #000;
		text-align: left;
		margin: 0 auto;
	}
	
	.my_boxs { 
		display:inline-block; 
		width:48%;
	}
	
</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function() {
		fn_retire();
	});
	
	function fn_retire(){
		$('#btn_retire').click(function(event){
			if(confirm('동일한 아이디로 재가입이 불가능합니다. 회원 탈퇴하시겠습니까?')) {
				location.href="${contextPath}/user/retire";
			} else{
				event.preventDefault();
				return;
			}
		});
	}

</script>

</head>
<body>

	<div class="my_box_area">
		<div class="my_boxs">
			<ul>
				<li><h3>My 스터디</h3></li>
				<li><a href="${contextPath}/user/studylist">My 스터디 목록</a></li>
				<li><a href="${contextPath}/user/zzimlist">찜 스터디 목록</a></li>
				<li><a href="${contextPath}/user/openlist">스터디 개설 목록</a></li>
			</ul>
		</div>
		
		<div class="my_boxs">
			<ul>
				<li><h3>My 정보</h3></li>
				<li><a href="${contextPath}/user/checkpw">개인정보확인/수정</a></li>
				<li><a id="btn_retire" href="${contextPath}/user/retire">탈퇴하기</a></li>
			</ul>
		</div>
	</div>

</body>
</html>