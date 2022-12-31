<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="../../resources/css/index.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/userinfo.css">
<script>

$(function() {
	// 비밀번호 수정
	fn_pwCheck();
	fn_pwCheckAgain();
	fn_pwSubmit();
});

// 비밀번호 수정
var pwPass = true;
var rePwPass = true;


function fn_init(){
	$('#pw').val('');
	$('#re_pw').val('');
	$('#msg_pw').text('');
	$('#msg_re_pw').text('');
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

function fn_pwSubmit(){
	$('#frm_edit_pw').submit(function(event){
		if(pwPass == false || rePwPass == false){
			alert('비밀번호 입력을 확인하세요.');
			event.preventDefault();
			return;
		}
	});
}
</script>

<style>
	.w-btn {
	    position: relative;
	    border: none;
	    display: inline-block;
	    padding: 15px 30px;
	    border-radius: 15px;
	    font-family: "paybooc-Light", sans-serif;
	    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	    text-decoration: none;
	    font-weight: 600;
	    transition: 0.25s;
	}
	.w-btn-blue {
	    background-color: #6aafe6;
	    color: #d4dfe6;
	}
	
	#container{
		background: #f9fafb;
	}

	.wrap.palm-leaf {
		background: #faf3eb; 
	}

	.wrap {
	    position: relative;
	    z-index: 0;
	    width: 100%;
	    background: #fff;
	}
	.main_register_wrap__2Rm-j {
	    display: flex;
	    width: 100%;
	    height: 100vh;
	    align-items: center;
	    justify-content: center;
	}

	.right_right_area_register__1xzTV, .right_right_area_register_entry__2SYIe, .right_right_area_send__3UENH {
	    position: relative;
	    background-color: #fff;
	    border-radius: 32px;
	    align-items: center;
	    display: flex;
	    flex-direction: column;
	    box-sizing: border-box;
	    box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
	}

	.right_right_area__3O18C .right_join_wrap__2w-MC, .right_right_area_register__1xzTV .right_join_wrap__2w-MC, .right_right_area_register_entry__2SYIe .right_join_wrap__2w-MC, .right_right_area_send__3UENH .right_join_wrap__2w-MC {
	    width: 100%;
	    max-width: 400px;
	    padding-top: 24px;
	}

</style>
<title>Smore</title>
<body>

	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
			    <h3 class="login" style="letter-spacing:-1px; padding-top: 50px; font-size: 23px;">Change Pw</h3>		    
						<form id="frm_edit_pw" action="/user/modify/pw" method="post">
							
						 	<label>
							    <p style="text-align: left; font-size:15px; color:#666">Password</p>
							    <input type="password" id="pw" name="pw" placeholder="비밀번호" class="size" >
						    </label><br>
							<span id="msg_pw"></span>
		
						 	<label>
							    <p style="text-align: left; font-size:15px; color:#666">Re-Password</p>
							    <input type="password" id="pw" name="re_pw" id="re_pw" placeholder="비밀번호" class="size" >
						    </label><br>
							<span id="msg_re_pw"></span>
							
							<div>
								<button class="btn btn-outline-secondary" >변경</button>
								<input type="button" value="취소" id="btn_edit_pw_cancel" class="btn btn-outline-secondary" >
							</div>
						</form>
			    </div> 
		    </div>
	    </div>
	</div>





	
</body>

</html>