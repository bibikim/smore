<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/css/userinfo.css">
<style>

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
	
	.register_registerArea__bOcTZ .register_txt__34D08 {
    margin-top: 16px;
    font-weight: 400;
    font-size: 14px;
    line-height: 140%;
    text-align: center;
    letter-spacing: -.5px;
    color: #4b4b4b;
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

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(document).ready(function(){
		fn_findPw();
	});
	
	function fn_findPw(){
		$('#btn_findPw').click(function(){
			new Promise(function(resolve, reject){
				if($('#id').val() == '' || $('#email').val() == ''){
					reject('아이디와 이메일을 입력하세요.');
					return;
				}
				$.ajax({
					url: '/user/findPw',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify({
						'id': $('#id').val(),
						'email': $('#email').val()
					}),
					dataType: 'json',
					success: function(resData){
						if(resData.findId != null){
							resolve(resData.findId);
						} else {
							reject('일치하는 회원 정보가 없습니다.');
						}
					}
				});		
			}).then(function(findId){
				$.ajax({
					url: '/user/sendTemporaryPassword',
					type: 'post',
					data: 'userNo=' + findId.userNo + '&email=' + findId.email,
					dataType: 'json',
					success: function(resData){
						if(resData.isSuccess){
							alert('등록된 이메일로 임시 비밀번호가 발송되었습니다.');
							location.href = '/user/login/form';
						}
					}
				});
			}).catch(function(msg){
				alert(msg);
			});
		});
	}

</script>

</head>
<body>

 	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
			    <h3 class="login" style="letter-spacing:-1px; padding-top: 10px; font-size: 23px;">Find Pw</h3>	
			     <p class="register_txt__34D08" style="padding-bottom: 15px; font-size: 12px;">
					    가입 시 등록했던 이메일로
					    <br>
					    임시 비밀번호를 보내드릴게요.
					    </p>
			    <p class="fonts" style="text-align: left; font-size:15px; color:#666">Id</p>			
				 	<label>				   
					    <input type="text" name="id" id="id" placeholder="아이디" class="size" >
				    </label><br>
				
					<label>
					    <p class="fonts" style="text-align: left; font-size:15px; color:#666">Email</p>
					    <input type="text" name="email" id="email" placeholder="이메일" class="size" >
				    </label><br>
					<br>
					<div>
						<input type="button" value="비밀번호 찾기" id="btn_findPw">
					</div>
					<br>
					<div id="msg_result" style="text-align: left; font-size:15px; color:#666"></div>
				    <hr>
				    <p class="find">
				        <span><a href="/user/findId/form">아이디 찾기</a></span>
				        <span><a href="/user/agree/form" >회원가입</a></span>
				    </p>	  
			    </div> 
		    </div>
	    </div>
	</div>

</body>
</html>