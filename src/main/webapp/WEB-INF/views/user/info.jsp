<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="회원정보확인/수정" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/resources/css/userinfo.css">
<style>

		a {
		text-decoration-line: none;
		cursor: pointer;
		color: black;
	}
	
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
		// 비밀번호 수정
		fn_showHide();
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_pwSubmit();
		// 일반정보 수정
		fn_nameCheck();
		fn_mobileCheck();
		fn_birthyear();
		fn_birthmonth();
		fn_birthdate();
		fn_emailCheck();
		fn_modify();
		fn_cancel();
		// 탈퇴
		fn_retire();
	});
	
	// 비밀번호 수정
	var pwPass = true;
	var rePwPass = true;
	
	function fn_showHide(){
		$('#modify_pw_area').hide();
		$('#btn_edit_pw').click(function(){
			fn_init();
			$('#modify_pw_area').show();
		});
		$('#btn_edit_pw_cancel').click(function(){
			fn_init();
			$('#modify_pw_area').hide();
		});
	}
	
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
	
	// 정보 수정
	var namePass = true;
	var mobilePass = true;
	var emailPass = true;
	
	function fn_nameCheck(){
		$('#name').keyup(function(){
			let nameValue = $(this).val();
			namePass = (nameValue != '');
		});
	}
	
	function fn_mobileCheck(){
		$('#mobile').keyup(function(){
			let mobileValue = $(this).val();
			let regMobile = /^010[0-9]{7,8}$/;
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대전화를 확인하세요.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				mobilePass = true;
			}
		});
	}
	
	function fn_birthyear(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#birthyear').append(strYear);
		$('#birthyear').val('${loginUser.birthyear}').prop('selected', true);
	}
	
	function fn_birthmonth(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#birthmonth').append(strMonth);
		$('#birthmonth').val('${loginUser.birthday.substring(0,2)}').prop('selected', true);
	}
	
	function fn_birthdate(){
		$('#birthdate').empty();
		$('#birthdate').append('<option value="">일</option>');
		let endDay = 0;
		let strDay = '';
		switch($('#birthmonth').val()){
		case '02':
			endDay = 29; break;
		case '04':
		case '06':
		case '09':
		case '11':
			endDay = 30; break;
		default:
			endDay = 31; break;
		}
		for(let d = 1; d <= endDay; d++){
			if(d < 10){
				strDay += '<option value="0' + d + '">' + d + '일</option>';
			} else {
				strDay += '<option value="' + d + '">' + d + '일</option>';
			}
		}
		$('#birthdate').append(strDay);
		$('#birthdate').val('${loginUser.birthday.substring(2)}').prop('selected', true);
	}
	
	function fn_emailCheck(){
		$('#email').keyup(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			let emailValue = $(this).val();
			if(regEmail.test(emailValue) == false){
				$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
				emailPass = false;
				return;
			}
			$.ajax({
				type: 'get',
				url: '/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						$('#msg_email').text('이미 사용중인 이메일입니다.');
						emailPass = false;
					} else {
						$('#msg_email').text('');
						emailPass = true;
					}
				}
			});
		});
	}
	
	function fn_modify(){
		$('#frm_edit').submit(function(event){
			if(namePass == false){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return;
			} else if(mobilePass == false){
				alert('휴대전화번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthdate').val() == ''){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return;
			} else if(emailPass == false){
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	function fn_cancel(){
		$('#btn_cancel').click(function(){
			location.href='/user/mypage';
		});			
	}
	
	function fn_retire(){
		$('#btn_retire').click(function(event){
			if(confirm('동일한 아이디로 재가입이 불가능합니다. 회원 탈퇴하시겠습니까?')) {
				location.href="/user/retire";
			} else{
				event.preventDefault();
				return;
			}
		});
	}

</script>

</head>
<body>
	<div>
		<h1>회원정보</h1>
		<hr>
		
		<div>
			<input type="button" value="비밀번호변경" id="btn_edit_pw">
		</div>
		<div id="modify_pw_area">
			<form id="frm_edit_pw" action="/user/modify/pw" method="post">
				<div>
					<label for="pw">비밀번호</label>
					<input type="password" name="pw" id="pw">
					<span id="msg_pw"></span>
				</div>
				<div>
					<label for="re_pw">비밀번호 확인</label>
					<input type="password" name="re_pw" id="re_pw">
					<span id="msg_re_pw"></span>
				</div>
				<div>
					<button>변경</button>
					<input type="button" value="취소" id="btn_edit_pw_cancel">
				</div>
			</form>
		</div>
		<hr>
		<div>
			<div>* 표시는 필수 입력사항</div>
			
			<hr>
			
			<form id="frm_edit" action="/user/modify/info" method="post">
			
				<input type="hidden" name="name" value="${loginUser.name}">
				<input type="hidden" name="joinDate" value="${loginUser.joinDate}">
				<input type="hidden" name="id" value="${loginUser.id}">
				<input type="hidden" name="nickname" value="${loginUser.nickname}">
				
				<div>
					이름 ${loginUser.name}
				</div>
				
				<div>
					가입일 <fmt:formatDate value="${loginUser.joinDate}" pattern="yyyy.M.d" />
				</div>
				
				<div>
					아이디 ${loginUser.id}
				</div>
				
				<div>
					닉네임 ${loginUser.nickname}
				</div>
				
				<div>
					<span>성별*</span>
					<input type="radio" name="gender" id="male" value="M">
					<label for="male">남자</label>&nbsp;&nbsp;&nbsp;
					<input type="radio" name="gender" id="female" value="F">
					<label for="female">여자</label>
					<script>
						$(':radio[name="gender"][value="${loginUser.gender}"]').prop('checked', true);
					</script>
				</div>
			
				<div>
					<label for="mobile">휴대전화*</label>
					<input type="text" name="mobile" id="mobile" size=10 maxlength=11 value="${loginUser.mobile}">
					<span id="msg_mobile"></span>
				</div>
			
				<div>
					<label for="birthyear">생년월일*</label>
					<select name="birthyear" id="birthyear"></select>
					<select name="birthmonth" id="birthmonth"></select>
					<select name="birthdate" id="birthdate"></select>				
				</div>
				
				<div>
					<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" size=4 placeholder="우편번호" readonly="readonly" value="${loginUser.postcode}">
					<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="roadAddress" id="roadAddress" size=27 placeholder="도로명주소"  readonly="readonly" value="${loginUser.roadAddress}">
					<input type="text" name="jibunAddress" id="jibunAddress" size=27 placeholder="지번주소"  readonly="readonly" value="${loginUser.jibunAddress}"><br>
					<span id="guide" style="colo*r:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${loginUser.detailAddress}">
					<input type="text" name="extraAddress" id="extraAddress" size=30 placeholder="참고항목" readonly="readonly" value="${loginUser.extraAddress}">
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
					    function fn_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var roadAddr = data.roadAddress; // 도로명 주소 변수
					                var extraRoadAddr = ''; // 참고 항목 변수
					
					                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                    extraRoadAddr += data.bname;
					                }
					                // 건물명이 있고, 공동주택일 경우 추가한다.
					                if(data.buildingName !== '' && data.apartment === 'Y'){
					                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                }
					                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                if(extraRoadAddr !== ''){
					                    extraRoadAddr = ' (' + extraRoadAddr + ')';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('postcode').value = data.zonecode;
					                document.getElementById("roadAddress").value = roadAddr;
					                document.getElementById("jibunAddress").value = data.jibunAddress;
					                
					                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
					                if(roadAddr !== ''){
					                    document.getElementById("extraAddress").value = extraRoadAddr;
					                } else {
					                    document.getElementById("extraAddress").value = '';
					                }
					
					                var guideTextBox = document.getElementById("guide");
					                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
					                if(data.autoRoadAddress) {
					                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					                    guideTextBox.style.display = 'block';
					
					                } else if(data.autoJibunAddress) {
					                    var expJibunAddr = data.autoJibunAddress;
					                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					                    guideTextBox.style.display = 'block';
					                } else {
					                    guideTextBox.innerHTML = '';
					                    guideTextBox.style.display = 'none';
					                }
					            }
					        }).open();
					    }
					</script>
				</div>
				
				<div>
					<label for="email">이메일*</label>
					<input type="text" name="email" id="email" value="${loginUser.email}">
					<span id="msg_email"></span>
				</div>
				
				<hr>
					<a id="btn_retire" href="/user/retire">탈퇴하기</a>		
				<hr>
				
				<div>
					<button>수정</button>
					<input type="button" value="취소" id="btn_cancel">
				</div>
			
			</form>
		</div>
	</div>
	
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="회원정보확인/수정" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/resources/css/userinfo.css">
<style>
	[type="radio"] {
	  vertical-align: middle;
	  appearance: none;
	  border: max(2px, 0.1em) solid gray;
	  border-radius: 50%;
	  width: 1.5em;
	  height: 1.5em;
	  transition: border 0.5s ease-in-out;
	  
	}
	
	[type="radio"]:checked {
	  border: 0.4em solid skyblue;
	}
	a {
		text-decoration-line: none;
		cursor: pointer;
		color: black;
	}
	
	#zone{
		border: 1px solid color:#666; 
	}
	
	 @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}
    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');} 
</style>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function() {
		// 비밀번호 수정
		fn_showHide();
		fn_init();
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_pwSubmit();
		// 일반정보 수정
		fn_nameCheck();
		fn_mobileCheck();
		fn_birthyear();
		fn_birthmonth();
		fn_birthdate();
		fn_emailCheck();
		fn_modify();
		fn_cancel();
		// 탈퇴
		fn_retire();
	});
	
	// 비밀번호 수정
	var pwPass = true;
	var rePwPass = true;
	
	function fn_showHide(){
		$('#modify_pw_area').hide();
		$('#btn_edit_pw').click(function(){
			fn_init();
			$('#modify_pw_area').show();
		});
		$('#btn_edit_pw_cancel').click(function(){
			fn_init();
			$('#modify_pw_area').hide();
		});
	}
	
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
	
	// 정보 수정
	var namePass = true;
	var mobilePass = true;
	var emailPass = true;
	
	function fn_nameCheck(){
		$('#name').keyup(function(){
			let nameValue = $(this).val();
			namePass = (nameValue != '');
		});
	}
	
	function fn_mobileCheck(){
		$('#mobile').keyup(function(){
			let mobileValue = $(this).val();
			let regMobile = /^010[0-9]{7,8}$/;
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대전화를 확인하세요.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				mobilePass = true;
			}
		});
	}
	
	function fn_birthyear(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#birthyear').append(strYear);
		$('#birthyear').val('${loginUser.birthyear}').prop('selected', true);
	}
	
	function fn_birthmonth(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#birthmonth').append(strMonth);
		$('#birthmonth').val('${loginUser.birthday.substring(0,2)}').prop('selected', true);
	}
	
	function fn_birthdate(){
		$('#birthdate').empty();
		$('#birthdate').append('<option value="">일</option>');
		let endDay = 0;
		let strDay = '';
		switch($('#birthmonth').val()){
		case '02':
			endDay = 29; break;
		case '04':
		case '06':
		case '09':
		case '11':
			endDay = 30; break;
		default:
			endDay = 31; break;
		}
		for(let d = 1; d <= endDay; d++){
			if(d < 10){
				strDay += '<option value="0' + d + '">' + d + '일</option>';
			} else {
				strDay += '<option value="' + d + '">' + d + '일</option>';
			}
		}
		$('#birthdate').append(strDay);
		$('#birthdate').val('${loginUser.birthday.substring(2)}').prop('selected', true);
	}
	
	function fn_emailCheck(){
		$('#email').keyup(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			let emailValue = $(this).val();
			if(regEmail.test(emailValue) == false){
				$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
				emailPass = false;
				return;
			}
			$.ajax({
				type: 'get',
				url: '/user/checkReduceEmail',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(resData){
					if(resData.isUser){
						$('#msg_email').text('이미 사용중인 이메일입니다.');
						emailPass = false;
					} else {
						$('#msg_email').text('');
						emailPass = true;
					}
				}
			});
		});
	}
	
	function fn_modify(){
		$('#frm_edit').submit(function(event){
			if(namePass == false){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return;
			} else if(mobilePass == false){
				alert('휴대전화번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthdate').val() == ''){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return;
			} else if(emailPass == false){
				alert('이메일을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
	}
	
	function fn_cancel(){
		$('#btn_cancel').click(function(){
			location.href='/user/mypage';
		});			
	}
	
	function fn_retire(){
		$('#btn_retire').click(function(event){
			if(confirm('동일한 아이디로 재가입이 불가능합니다. 회원 탈퇴하시겠습니까?')) {
				location.href="/user/retire";
			} else{
				event.preventDefault();
				return;
			}
		});
	}

</script>

</head>
<body>
	<div id="container">
		<h2 class="login" style="letter-spacing:-1px; text-align: center;">User Info</h2>
		<hr>
		<div>
	
			<form id="frm_edit" action="/user/modify/info" method="post">
			<div style="font-weight: bold;">* 표시는 필수 입력사항</div>
			<br><br>
				<input type="hidden" name="name" value="${loginUser.name}">
				<input type="hidden" name="joinDate" value="${loginUser.joinDate}">
				<input type="hidden" name="id" value="${loginUser.id}">
				<input type="hidden" name="nickname" value="${loginUser.nickname}">
				
				<div>
					<p style="text-align: left; font-size:15px; color:#666">이름 ${loginUser.name}</p>					
				</div>
				
				<div>
					<p style="text-align: left; font-size:15px; color:#666">가입일 <fmt:formatDate value="${loginUser.joinDate}" pattern="yyyy.M.d" /></p>
				</div>
				
				
				
<%-- 		        <!-- 아이디 -->         
		       <div>        
			       	<p style="text-align: left; font-size:15px; color:#666">이름</p>
			       	<input type="text" name="id" id="id" placeholder="아이디" value="${loginUser.name}" class="size" readonly="readonly"> 
			       	<span id="msg_id"></span>
			   </div> 
				
				
				<div>
					가입일 <fmt:formatDate value="${loginUser.joinDate}" pattern="yyyy.M.d" />
				</div> --%>				
				
				<div>
					<p style="text-align: left; font-size:15px; color:#666">아이디 ${loginUser.id}</p>	
				</div>
				
				<div>
					<p style="text-align: left; font-size:15px; color:#666">닉네임 ${loginUser.nickname}</p>				
				</div>
				
				<div>
					<span><p style="text-align: left; font-size:15px; color:#666">성별</p>	</span>
					<input type="radio" name="gender" id="male" value="M">
					<label for="male"><p style="text-align: left; font-size:15px; color:#666">남자</p></label>&nbsp;&nbsp;&nbsp;
					<input type="radio" name="gender" id="female" value="F">
					<label for="female"><p style="text-align: left; font-size:15px; color:#666">여자</p></label>
					<script>
						$(':radio[name="gender"][value="${loginUser.gender}"]').prop('checked', true);
					</script>
				</div>
			
<%-- 				<div>
					<label for="mobile">휴대전화*</label>
					<input type="text" name="mobile" id="mobile" size=10 maxlength=11 value="${loginUser.mobile}">
					<span id="msg_mobile"></span>
				</div> --%>
				
		        <div> 
			       <label>
			        <p style="text-align: left; font-size:15px; color:#666">휴대전화*</p>
			        <input type="text" name="mobile" id="mobile" size=10 maxlength=11 class="size" value="${loginUser.mobile}" style="width:250px">
			       </label>
			       <span id="msg_mobile"></span>
				</div>
				
				
				<div>
					<label for="birthyear"><p style="text-align: left; font-size:15px; color:#666">생년월일*</p></label>
					<select name="birthyear" id="birthyear" class="size num1" style="width:100px;"></select>
					<select name="birthmonth" id="birthmonth" class="size num1" style="width:100px;"></select>
					<select name="birthdate" id="birthdate" class="size num1" style="width:100px;"></select>				
				</div>
				
				<div>
					<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" size=4 placeholder="우편번호" readonly="readonly" value="${loginUser.postcode}" class="size">
					<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기" id="btn_post_code" class="btn btn-outline-secondary"><br>
					<br>
					<input type="text" name="roadAddress" id="roadAddress" size=27 placeholder="도로명주소"  readonly="readonly" value="${loginUser.roadAddress}" class="size">					
					<input type="text" name="jibunAddress" id="jibunAddress" size=27 placeholder="지번주소"  readonly="readonly" value="${loginUser.jibunAddress}" class="size"><br>
					 <br>
					<span id="guide" style="colo*r:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${loginUser.detailAddress}" class="size">
					<input type="text" name="extraAddress" id="extraAddress" size=30 placeholder="참고항목" readonly="readonly" value="${loginUser.extraAddress}" class="size">
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
					    function fn_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var roadAddr = data.roadAddress; // 도로명 주소 변수
					                var extraRoadAddr = ''; // 참고 항목 변수
					
					                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                    extraRoadAddr += data.bname;
					                }
					                // 건물명이 있고, 공동주택일 경우 추가한다.
					                if(data.buildingName !== '' && data.apartment === 'Y'){
					                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                }
					                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                if(extraRoadAddr !== ''){
					                    extraRoadAddr = ' (' + extraRoadAddr + ')';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('postcode').value = data.zonecode;
					                document.getElementById("roadAddress").value = roadAddr;
					                document.getElementById("jibunAddress").value = data.jibunAddress;
					                
					                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
					                if(roadAddr !== ''){
					                    document.getElementById("extraAddress").value = extraRoadAddr;
					                } else {
					                    document.getElementById("extraAddress").value = '';
					                }
					
					                var guideTextBox = document.getElementById("guide");
					                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
					                if(data.autoRoadAddress) {
					                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					                    guideTextBox.style.display = 'block';
					
					                } else if(data.autoJibunAddress) {
					                    var expJibunAddr = data.autoJibunAddress;
					                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					                    guideTextBox.style.display = 'block';
					                } else {
					                    guideTextBox.innerHTML = '';
					                    guideTextBox.style.display = 'none';
					                }
					            }
					        }).open();
					    }
					</script>
				</div>
				 <br>
				
		        <div> 
			       <label>
			        <p style="text-align: left; font-size:15px; color:#666">이메일*</p>
			        <input type="text" name="email" id="email"  class="size" value="${loginUser.email}" style="width:250px">
			       </label>
			       <span id="msg_email"></span>
				</div>
				<br>
				
				<div id="zone">
					<a id="btn_retire" href="/user/retire" class="btn btn-outline-secondary">탈퇴하기</a>		
					<a href="/user/modifyPw" class="btn btn-outline-secondary">비밀번호 변경</a>
				</div>
				<hr>
				
				<div>
					<button class="btn btn-outline-secondary">수정</button>
					<input type="button" value="취소" id="btn_cancel" class="btn btn-outline-secondary">
				</div>			
			</form>
		</div>
	</div>
		


</body>
</html>
