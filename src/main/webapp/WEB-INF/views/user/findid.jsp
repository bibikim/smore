<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/css/userinfo.css">
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
<script src="/resources/js/moment-with-locales.js"></script>
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
				url: '/user/findId',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					name: $('#name').val(),
					email: $('#email').val()
				}),
				dataType: 'json',
				success: function(resData) {
					if (resData.findId != null) {
						let id = resData.findId.id;
						id = id.substring(0, 3) + '*****';
						moment.locale('ko-KR');
						$('#msg_result').html('회원님의 아이디는 ' + id + '입니다.<br>(가입일 : ' + moment(resData.findId.joinDate).format("YYYY년 MM월 DD일 a h:mm:ss") + ')');
					} else {
						$('#msg_result').html('일치하는 회원이 없습니다. 입력 정보를 확인하세요.');
					}
				}
			});
		});
	}

</script>
<title>Smore</title>
</head>
<body>

 	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
			    <h3 class="login" style="letter-spacing:-1px; padding-top: 10px; font-size: 23px;">Find Id</h3>				
				 	<label>
					    <p class="fonts" style="text-align: left; font-size:15px; color:#666">Name</p>
					    <input type="text" id="name" name="name"placeholder="이름" class="size" >
				    </label><br>
				
					<label>
					    <p class="fonts" style="text-align: left; font-size:15px; color:#666">Email</p>
					    <input type="text" name="email" id="email" placeholder="이메일" class="size" >
				    </label><br>
					<br>
					<div>
						<input type="button" value="아이디찾기" id="btn_findId" style="margin-top: 3px;">
					</div>
					<br>
					<div id="msg_result" style="text-align: left; font-size:15px; color:#666"></div>
				    <hr>
				    <p class="find">
				        <span><a href="/user/findPw/form">비밀번호 찾기</a></span>
				        <span><a href="/user/agree/form" >회원가입</a></span>
				    </p>	  
			    </div> 
		    </div>
	    </div>
	</div>
	
</body>
</html>