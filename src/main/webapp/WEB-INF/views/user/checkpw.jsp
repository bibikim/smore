<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="비밀번호 변경하기" name="title"/>
</jsp:include>
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
		width: 65%;
		margin-left: 200px;
	}
	#all{
		margin-top: 200px;
		margin-right: 50px;
	}
	#content{
		margin-left: 80px;
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
	
	<div id="container">
		<div id="all">
			<h2 class="login" style="letter-spacing:-1px; text-align: center;">Check Pw</h2>
			<hr>
				<div id="content">
					<!-- <div>개인정보 보호를 위해서 비밀번호를 입력해주세요</div> -->
				
				    <label>
				        <!-- <span>ID</span> -->
				        <p style="text-align: left; font-size:15px; color:#666">비밀번호</p>
				        <input type="password" placeholder="비밀번호를 입력"  id="pw" class="size">
				        <!-- <input type="submit" value="확인"> -->
				        <p></p>
				    </label>
				
					
						
				
					<div>
						<input type="button" value="확인" id="btn_check_pw" class="btn btn-outline-secondary">



				</div>	
				    
				
				<!-- <input type="button" value="취소" onclick="history.back()"> -->

			</div>
							<hr>
				   <p class="find">
        					<span><a href="/" >메인 페이지로 이동</a></span>
 				   </p>
		</div>
	</div>
</body>
</html>