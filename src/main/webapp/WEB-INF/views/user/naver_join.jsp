<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="네이버 회원가입" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/resources/css/userinfo.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<style>

	.blind {
		display: none;
	}
	
	.lbl_all, .lbl_one {
		padding-left: 20px;
		background-image: url(../../resources/images/uncheck.png);
		background-size: 18px 18px;
		background-repeat: no-repeat;
	}
	
	.lbl_checked {
		background-image: url(../../resources/images/check.png);
	}
	
</style>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<title>Smore</title>
<script>
	
	$(function(){
		fn_emailCheck();
		fn_join();
		fn_checkAll();
		fn_checkOne();
		fn_toggleCheck();
		fn_submit();
	});
	
var emailPass = false;
	
	// 이메일 중복 체크
	function fn_emailCheck(){	
		$('#btn_check').click(function(){
			$.ajax({
				/* 요청 */
				type: 'get',
				url: '/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				/* 응답 */
				dataType: 'json',
				success: function(resData){
					// 기존 회원 정보에 등록된 이메일이라면 실패 처리
					if(resData.isUser){
						$('#msg_email').text('이미 사용중인 이메일입니다.');
						emailPass = false;
					} else {
						$('#msg_email').text('사용 가능한 이메일입니다.');
						emailPass = true;
					}
				}
			});
		});
	}
	
	function fn_join(){
		$('#frm_join').submit(function(event){
			if(emailPass == false){
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return;
			}
			if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false){
				alert('필수 약관에 동의하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	// 모두 동의 (모두 동의의 체크 상태 = 개별 선택들의 체크 상태)
	function fn_checkAll(){
		$('#check_all').click(function(){
			// 체크 상태 변경
			$('.check_one').prop('checked', $(this).prop('checked'));
			// 체크 이미지 변경
			if($(this).is(':checked')){  // 모두 동의가 체크되었다면
				$('.lbl_one').addClass('lbl_checked');
			} else {
				$('.lbl_one').removeClass('lbl_checked');
			}
		});
	}
	
	// 개별 선택 (항상 개별 선택 4개롤 모두 순회하면서 어떤 상태인지 체크해야 함)
	function fn_checkOne(){
		$('.check_one').click(function(){
			// 체크 상태 변경
			let checkCount = 0;
			for(let i = 0; i < $('.check_one').length; i++){
				checkCount += $($('.check_one')[i]).prop('checked');
			}
			// 체크박스개수 vs 체크된박스개수
			$('#check_all').prop('checked', $('.check_one').length == checkCount);
			// 체크 이미지 변경
			if($('#check_all').is(':checked')){
				$('.lbl_all').addClass('lbl_checked');
			} else {
				$('.lbl_all').removeClass('lbl_checked');
			}
		});
	}
	
	// 체크할때마다 lbl_checked 클래스를 줬다 뺐었다 하기
	function fn_toggleCheck(){
		$('.lbl_all, .lbl_one').click(function(){
			$(this).toggleClass('lbl_checked');
		});
	}
	
	// 서브밋 (필수 체크 여부 확인)
	function fn_submit(){
		$('#frm_agree').submit(function(event){
			if($('#service').is(':checked') == false || $('#privacy').is(':checked') == false){
				alert('필수 약관에 동의하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
</script>
</head>
<body>

	<div id="container">
		
		<h2 class="login" style="letter-spacing:-1px; text-align: center;">Naver Join</h2>
		<!-- <h1>네이버 간편 가입</h1> -->
	
	
		
		<hr>
		<div style="text-align: center">* 표시는 필수 입력사항입니다.</div>
		<form id="frm_join" action="/user/naver/join" method="post">
		
			<input type="hidden" name="id" id="id" value="${profile.id}" style="width:250px">
			
<%-- 			<div>
				<label for="name">이름*</label>
				<input type="text" name="name" id="name" value="${profile.name}">
			</div> --%>
			
	         <!-- 이름 -->        
	        <div> 
	        <label>
		        <p style="text-align: left; font-size:15px; color:#666">이름*</p>
		        <input type="text" name="name" id="name" placeholder="이름" class="size" value="${profile.name}" style="width:250px">
	        </label>
			</div>
			
	         <!-- 이름 -->        
	        <div> 
	        <label>
		        <p style="text-align: left; font-size:15px; color:#666">별명*</p>
		        <input type="text" name="nickname" id="nickname" placeholder="이름" class="size" style="width:250px">
	        </label>
			</div>
			
<!-- 			
	        <div>
	            <label for="name">별명*</label>
	            <input type="text" name="nickname" id="nickname">
	        </div> -->
			
			<div>
				<span><p style="text-align: left; font-size:15px; color:#666">성별*</p></span>
				<input type="radio" name="gender" id="male" value="M">
				<label for="male">남자</label>
				<input type="radio" name="gender" id="female" value="F">
				<label for="female">여자</label>
				<script>
					$(':radio[name="gender"][value="${profile.gender}"]').prop('checked', true);
				</script>
			</div>
		
<%-- 			<div>
				<label for="mobile">휴대전화*</label>
				<input type="text" name="mobile" id="mobile" value="${profile.mobile}">
			</div> --%>
		
		
			<!-- 휴대전화 -->
	        <div> 
		       <label>
		        <p style="text-align: left; font-size:15px; color:#666">휴대전화*</p>
		        <input type="text" name="mobile" id="mobile" placeholder="휴대전화" class="size" value="${profile.mobile}" style="width:250px">
		       </label>
			</div>
		
			<div>
				<label for="birthyear">생년월일*</label>
				<input type="text" name="birthyear"  class="size num1" id="birthyear" value="${profile.birthyear}" style="width:100px">
				<input type="text" name="birthmonth"  class="size num1" id="birthmonth" value="${profile.birthday.substring(0,2)}" style="width:100px">
				<input type="text" name="birthdate" class="size num1" id="birthdate" value="${profile.birthday.substring(2)}" style="width:100px">
			</div>
			
			
	        <div> 
		        <label>
		        	<p style="text-align: left; font-size:15px; color:#666">이메일*</p>
			        <input type="text" name="email" id="email" placeholder="이메일" class="size" style="width:250px" value="${profile.email}">	
			        <input type="button" value="중복체크" id="btn_check" class="btn btn-outline-secondary"> 
			        <span id="msg_email"></span>       
				</label>
			</div>
						
			
			<div>
				<input type="checkbox" id="check_all" class="blind">
				<label for="check_all" class="lbl_all">모두 동의</label>
			</div>
			
			<hr>
			
			<div>
				<input type="checkbox" id="service" class="check_one blind">
				<label for="service" class="lbl_one">이용약관 동의(필수)</label>
				<div>
					<textarea style="width: 500px; height: 100px;" class="form-control">여러분을 환영합니다.
						S'more 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 S'more 서비스의 이용과 관련하여 S'more 서비스를 제공하는 S'more 주식회사(이하 ‘S'more’)와 이를 이용하는 S'more 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 S'more 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
					</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="privacy" class="check_one blind">
				<label for="privacy" class="lbl_one">개인정보수집 동의(필수)</label>
				<div>
					<textarea style="width: 500px; height: 100px;" class="form-control">개인정보보호법에 따라 S'more에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
					</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="location" name="location" class="check_one blind">
				<label for="location" class="lbl_one">위치정보수집 동의(선택)</label>
				<div>
					<textarea style="width: 500px; height: 100px;" class="form-control">위치기반서비스 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.
						제 1 조 (목적)
						이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치기반서비스와 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
						
						제 2 조 (약관 외 준칙)
						이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보처리방침, 회사가 별도로 정한 지침 등에 의합니다.
					</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="promotion" name="promotion" class="check_one blind">
				<label for="promotion" class="lbl_one">마케팅 동의(선택)</label>
				<div>
					<textarea style="width: 500px; height: 100px;" class="form-control">S'more 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화, 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 S'more 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.</textarea>
				</div>
			</div>
			
			<div>
				<button class="button" style="background-color:#217Af0; width: 100x; margin-top: 30px;">가입하기</button>
				<input type="button" value="취소하기" onclick="location.href='/'" class="btn btn-outline-secondary" tyle="margin-bottom: 4px;">
			</div>
		
		</form>
	
	</div>

</body>
</html>