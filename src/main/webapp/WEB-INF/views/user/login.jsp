<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	$(function(){
		
		fn_login();
		fn_displayRememberId();
		
	});
	
	function fn_login(){
		
		$('#frm_login').submit(function(event){
			
			// 아이디, 비밀번호 공백 검사
			if($('#id').val() == '' || $('#pw').val() == ''){
				alert('아이디와 비밀번호를 모두 입력하세요.');
				event.preventDefault();
				return;
			}
			
			// 아이디 기억을 체크하면 rememberId 쿠키에 입력된 아이디를 저장
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId', $('#id').val());
			} else {
				$.cookie('rememberId', '');
			}
			
		});
		
	}
	
	function fn_displayRememberId(){
		
		// rememberId 쿠키에 저장된 아이디를 가져와서 표시
		
		let rememberId = $.cookie('rememberId');
		if(rememberId == ''){
			$('#id').val('');
			$('#rememberId').prop('checked', false);
		} else {
			$('#id').val(rememberId);
			$('#rememberId').prop('checked', true);
		}
		
	}
	
</script>
<style>
.join_cont {
    width: 390px;
    padding: 60px 50px 51px;
    margin: 110px auto 0;
    border: 1px solid #f2f4f5;
}
#userid:focus {
        border: 1px solid #ff5000;
    }
#pwd:focus {
        border: 1px solid #ff5000;
    }
.login_ipt_box {
    display: block;     
    height: 48px;
    border: 1px solid #d7d7d7;
    margin-bottom: 6px;
    position: relative;  
    }
.login_ipt_box > strong {
    position: absolute; 
    top: 16px;
    left: 19px;
    height: 17px; 
    font-size: 14px;
    color: #aaa;
   
}
.login_ipt_box > input {
    width: 350px;
    height: 17px;
    padding: 16px 19px 15px 19px; 
    border: none; 
    outline: none; 
    font-weight: bold;
    font-size: 14px;
    color: #aaa;
}
.chk_choice {
    margin: 10px 0 40px;
    position: relative;
}
.uio_check_box {
    display: inline-block; 
    padding: 0 20px 0 30px;
    height: 20px;
    font-size: 12px;
    font-weight: normal;
    color: #555;
    line-height: 22px;
    letter-spacing: -0.5px;
    position: relative
}

.check_style { 
    
    position: absolute;
    top: 0;
    left: 0;
    width: 18px;
    height: 18px;
    border: 1px solid #707070; 
}


.btn_login {
	width : 390px;
	display: block;
    height: 50px;
    background-color: #6495ed;
    color: #fff;
    font-size: 14px;
    font-weight: bold;
    letter-spacing: -0.5px; 
    text-align: center;
    line-height: 51px;
}
a {
	text-decoration-line: none;
	cursor: pointer;
	color: black;
}
.div_user {
	margin: 10px 0 10px 50px;
}
.div_naver {
	margin: 0 0 0 110px; 
}

</style>
</head>
<body>
	
   <div class="join_cont">
   <%-- <c:if test="${loginUser.id == 'admin'}">
       <c:redirect url="/admin/admin" />
      
   </c:if> --%>

		<div>
		
			<h1>로그인</h1>
			
			<form id="frm_login" action="${contextPath}/user/login" method="post">
				
				<!-- 컨트롤러에서 넘겨준 값 : 로그인 후 이동할 주소가 있음 -->
				<input type="hidden" name="url" value="${url}">
				
				<div>
					<label for="id" class="login_ipt_box">
						<input type="text" name="id" id="id" placeholder="아이디">
					</label>
				</div>
				
				<div>
					<label for="pw" class="login_ipt_box">
						<input type="password" name="pw" id="pw" placeholder="비밀번호">
					</label>
				</div>
				
				<div>			
					<button class="btn_login">로그인</button>
				</div>
				
				<div class="div_user">
					<label for="rememberId" class="uio_check_box">
						<input type="checkbox" id="rememberId">
						아이디 기억
					</label>
					<label for="keepLogin" class="uio_check_box">
						<input type="checkbox" name="keepLogin" id="keepLogin">
						로그인 유지
					</label>
				</div>
			
			</form>
			</div>
			
			<div class="div_user">
				<div>
					<a href="${contextPath}/user/join">회원가입</a> |
					<a href="${contextPath}/user/findId">아이디 찾기</a> | 
					<a href="${contextPath}/user/findPw">비밀번호 찾기</a>
				</div>
			</div>
			
			<hr>
			
			<div class="div_naver">
				<a href="${apiURL}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
			</div>
		
		
		</div>

<%-- 	<c:if test="${loginUser != null}">
		<div>
			${loginUser.name} 님 반갑습니다.
		</div>
		<hr>
		<div>
			<div>
				<a href="${contextPath}/board/list">자유게시판</a>
				<a href="${contextPath}/gallery/list">갤러리게시판</a>
				<a href="${contextPath}/upload/list">업로드게시판</a>
			</div>
		</div>

		<br>
		<br>
		
		<a href="${contextPath}/user/logout">로그아웃 | </a>
		<a href="javascript:fn_abc()">회원탈퇴</a>
		<form id="lnk_retire" action="${contextPath}/user/retire" method="post"></form>
		<script>
			function fn_abc(){
				if(confirm('탈퇴하시겠습니까?')){
					$('#lnk_retire').submit();
				}
			}
		</script>
	</c:if> --%> 
	

</body>
</html>