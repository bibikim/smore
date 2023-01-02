<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smore</title>
<link rel="stylesheet" href="/resources/css/userinfo.css">
<style>
	#lists{
		text-decoration: none; 
		color:#333;
	}
	#lists:hover{
		color: #707070;
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
	
	.fonts{
		font-weight: 700;
	    font-size: 14px;
	    line-height: 140%;
	    display: flex;
	    align-items: center;
	    letter-spacing: -.5px;
	    color: #0d0d0d;
	}
</style>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	$(function(){
		fn_login();
		fn_displayRememberId();
	});
	
	function fn_login(){
		
		$('#frm_login').submit(function(event){
			
			if($('#id').val() == '' || $('#pw').val() == ''){
				alert('아이디와 비밀번호를 모두 입력하세요.');
				event.preventDefault();
				return;
			}
			
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId', $('#id').val());
			} else {
				$.cookie('rememberId', '');
			}
		});
	}
	
	function fn_displayRememberId(){
		
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

</head>
<body>
	
	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC">
					<form id="frm_login" action="/user/login" method="post">
						<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
						<input type="hidden" name="url" value="${url}">		
				 		<label>
						    <p class="fonts" style="text-align: left; font-size:15px; color:#666">ID</p>
						    <input type="text" name="id" id="id" placeholder="아이디" class="size" >
				    	</label><br>
											
					 	<label>
						    <p class="fonts" style="text-align: left; font-size:15px; color:#666">Password</p>
						    <input type="password" id="pw" name="pw" placeholder="비밀번호" class="size" >
					    </label>
					    <br><br>
						<div>			
							<button class="btn btn-outline-secondary">로그인</button>
						</div>
						
						<div class="div_user" style="margin-top: 20px;">
							<label for="rememberId" class="uio_check_box ">
								<input type="checkbox" id="rememberId">
								아이디 기억
							</label>
							<label for="keepLogin" class="uio_check_box">
								<input type="checkbox" name="keepLogin" id="keepLogin">
								로그인 유지
							</label>
						    <hr>
						    <p class="find">
						        <span><a id="lists" href="/user/findId/form" >아이디 찾기</a></span>
						        <span><a id="lists" href="/user/findPw/form" >비밀번호 찾기</a></span>
						        <span><a id="lists" href="/user/agree/form" >회원가입</a></span>
						    </p>							
						</div>	
						<div class="div_naver">
							<a href="${apiURL}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
						</div>		
					</form>				
			    </div> 
		    </div>
	    </div>
	</div>
</body>
</html>
