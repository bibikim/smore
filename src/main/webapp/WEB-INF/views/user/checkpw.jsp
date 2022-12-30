
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

</style>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function() {
		$('#btn_check_pw').click(function(){			
			$.ajax({
				type: 'post',
				url: '/user/check/pw',
				data: 'pw=' + $('#pw').val(),
				
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						location.href = '/user/info';
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
	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
			    <h3 class="login" style="letter-spacing:-1px; padding-top: 50px; font-size: 23px;">Check Password</h3>
			
			 	<label>
				    <p style="text-align: left; font-size:15px; color:#666">Password</p>
				    <input type="password" id="pw" placeholder="비밀번호" class="size" >
			    </label><br>
				<input type="button" value="확인" id="btn_check_pw" class="btn btn-outline-secondary" style="margin-top: 20px; wid">
			    </div> 
		    </div>
	    </div>
	</div>
</body>
</html>
