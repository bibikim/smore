<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/resources/css/userinfo.css">

<style>
    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}
    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');} @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');} 
</style>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<title>Smore</title>
<script>
   
   $(function(){
      fn_idCheck();
      fn_pwCheck();
      fn_pwCheckAgain();
      fn_nameCheck();
      fn_mobileCheck();
      fn_birthyear();
      fn_birthmonth();
      fn_birthdate();
      fn_emailCheck();
      fn_join();
   });
   
   // 전역변수 (각종 검사를 통과하였는지 점검하는 플래그 변수)
   var idPass = false;
   var pwPass = false;
   var rePwPass = false;
   var namePass = false;
   var mobilePass = false;
   var authCodePass = false;
   
   // 1. 아이디 중복체크 & 정규식
   function fn_idCheck(){
      
      $('#id').keyup(function(){
         
         // 입력한 아이디
         let idValue = $(this).val();
         
         // 정규식(4~20자, 소문자+숫자+특수문자(-,_)조합, 첫 글자는 특수문자 제외(-,_))
         let regId = /^[0-9a-z][0-9a-z-_]{3,19}$/;
         
         // 정규식 검사
         if(regId.test(idValue) == false){
            $('#msg_id').text('4~20자의 소문자, 숫자, 특수문자(-,_)를 조합해야 합니다.');
            idPass = false;
            return;  // 코드 진행 방지(이후에 나오는 ajax 실행을 막음)
         }
         
         // 아이디 중복체크
         $.ajax({
            /* 요청 */
            type: 'get',
            url: '/user/checkReduceId',
            data: 'id=' + idValue,
            /* 응답 */
            dataType: 'json',
            success: function(resData){  // resData = {"isUser": true, "isRetireUser": false}
               if(resData.isUser || resData.isRetireUser || resData.isSleepUser){
                  $('#msg_id').text('이미 사용중이거나 탈퇴한 아이디입니다.');
                  idPass = false;
               
               } else {
                  $('#msg_id').text('사용 가능한 아이디입니다.');
                  idPass = true;
               }
            }
         });  // ajax
         
      });  // keyup
      
   }  // fn_idCheck
   
   // 2. 비밀번호
   function fn_pwCheck(){
      
      $('#pw').keyup(function(){
         
         // 입력한 비밀번호
         let pwValue = $(this).val();
         
         // 정규식(8~20자, 소문자+대문자+숫자+특수문자8종(!@#$%^&*) 3개 이상 조합)
         let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
         
         // 3개 이상 조합 확인
         let validatePw = /[0-9]/.test(pwValue)        // 숫자가 있으면 true, 없으면 false
                        + /[a-z]/.test(pwValue)        // 소문자가 있으면 true, 없으면 false
                        + /[A-Z]/.test(pwValue)        // 대문자가 있으면 true, 없으면 false
                        + /[!@#$%^&*]/.test(pwValue);  // 특수문자8종이 있으면 true, 없으면 false
         
         // 정규식 및 3개 이상 조합 검사
         if(regPw.test(pwValue) == false || validatePw < 3){
            $('#msg_pw').text('8~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
            pwPass = false;
         } else {
            $('#msg_pw').text('사용 가능한 비밀번호입니다.');
            pwPass = true;
         }
                        
      });  // keyup
      
   }  // fn_pwCheck
   
   // 3. 비밀번호 확인
   function fn_pwCheckAgain(){
      
      $('#re_pw').keyup(function(){
         
         // 입력한 비밀번호 확인
         let rePwValue = $(this).val();
         
         // 비밀번호와 비밀번호 재입력 검사
         if(rePwValue != '' && rePwValue != $('#pw').val()){
            $('#msg_re_pw').text('비밀번호를 확인하세요.');
            rePwPass = false;
         } else {
            $('#msg_re_pw').text('');
            rePwPass = true;
         }
         
      });  // keyup
      
   }  // fn_pwCheckAgain
   
   // 4. 이름
   function fn_nameCheck(){
      
      $('#name').keyup(function(){
         
         // 입력한 이름
         let nameValue = $(this).val();
         
         // 공백 검사
         namePass = (nameValue != '');
         
      });  // keyup
      
   }  // fn_nameCheck
   
   // 5. 휴대전화
   function fn_mobileCheck(){
      
      $('#mobile').keyup(function(){
         
         // 입력한 휴대전화
         let mobileValue = $(this).val();
         
         // 휴대전화 정규식(010으로 시작, 하이픈 없이 전체 10~11자)
         let regMobile = /^010[0-9]{7,8}$/;
         
         // 정규식 검사
         if(regMobile.test(mobileValue) == false){
            $('#msg_mobile').text('휴대전화를 확인하세요.');
            mobilePass = false;
         } else {
            $('#msg_mobile').text('');
            mobilePass = true;
         }
         
      });  // keyup
      
   }  // fn_mobileCheck
   
   // 6. 생년월일(년도)
   function fn_birthyear(){
      let year = new Date().getFullYear();
      let strYear = '<option value="">년도</option>';
      for(let y = year - 100; y <= year + 1; y++){
         strYear += '<option value="' + y + '">' + y + '</option>';
      }
      $('#birthyear').append(strYear);
   }  // fn_birthyear
   
   // 7. 생년월일(월)
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
   }  // fn_birthmonth
   
   // 8. 생년월일(일)
   function fn_birthdate(){
      
      $('#birthdate').append('<option value="">일</option>');
      
      $('#birthmonth').change(function(){
         
         $('#birthdate').empty();
         $('#birthdate').append('<option value="">일</option>');
         let endDay = 0;
         let strDay = '';
         switch($(this).val()){
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
         
      });  // change
      
   }  // fn_birthdate
   
   // 9. 이메일
   //    1) 입력된 이메일이 회원 정보에 있는지 체크하는 ajax
   //    2) 입력된 이메일로 인증번호를 보내는 ajax
   function fn_emailCheck(){
      
      $('#btn_getAuthCode').click(function(){
         
         // 인증코드를 입력할 수 있는 상태로 변경함
         $('#authCode').prop('readonly', false);
         
         // resolve : 성공하면 수행할 function
         // reject  : 실패하면 수행할 function
         new Promise(function(resolve, reject) {
      
            // 정규식 
            let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
            
            // 입력한 이메일
            let emailValue = $('#email').val();
            
            // 정규식 검사
            if(regEmail.test(emailValue) == false){
               reject(1);  // catch의 function으로 넘기는 인수 : 1(이메일 형식이 잘못된 경우)
               authCodePass = false;
               return;     // 아래 ajax 코드 진행을 막음
            }
            
            // 이메일 중복 체크
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
                     reject(2);   // catch의 function으로 넘기는 인수 : 2(다른 회원이 사용중인 이메일이라서 등록이 불가능한 경우)
                  } else {
                     resolve();   // Promise 객체의 then 메소드에 바인딩되는 함수
                  }
               }
            });  // ajax
            
         }).then(function(){
            
            // 인증번호 보내는 ajax
            $.ajax({
               /* 요청 */
               type: 'get',
               url: '/user/sendAuthCode',
               data: 'email=' + $('#email').val(),
               /* 응답 */
               dataType: 'json',
               success: function(resData){
                  alert('인증코드를 발송했습니다. 이메일을 확인하세요.');
                  // 발송한 인증코드와 사용자가 입력한 인증코드 비교
                  $('#btn_verifyAuthCode').click(function(){
                     if(resData.authCode == $('#authCode').val()){
                        alert('인증되었습니다.');
                        authCodePass = true;
                     } else {
                        alert('인증에 실패했습니다.');
                        authCodePass = false;
                     }
                  });
               },
               error: function(jqXHR){
                  alert('인증번호 발송이 실패했습니다.');
                  authCodePass = false;
               }
            });  // ajax
            
         }).catch(function(code){  // 인수 1 또는 2를 전달받기 위한 파라미터 code 선언

            switch(code){
            case 1:
               $('#msg_email').text('이메일 형식이 올바르지 않습니다.');
               break;
            case 2:
               $('#msg_email').text('이미 사용중인 이메일입니다.');
               break;
            }
         
            authCodePass = false;
         
            // 입력된 이메일에 문제가 있는 경우 인증코드 입력을 막음
            $('#authCode').prop('readonly', true);
            
         });  // new Promise
         
      });  // click
      
   }  // fn_emailCheck
   
   // 10. 서브밋 (회원가입)
   function fn_join(){
      
      $('#frm_join').submit(function(event){
         
         if(idPass == false){
            alert('아이디를 확인하세요.');
            event.preventDefault();
            return;
         } else if(pwPass == false || rePwPass == false){
            alert('비밀번호를 확인하세요.');
            event.preventDefault();
            return;
         } else if(namePass == false){
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
         } else if(authCodePass == false){
            alert('이메일 인증을 받으세요.');
            event.preventDefault();
            return;
         } else if ($(':radio[name="grade"]:checked').length < 1) {
        	   alert('회원 유형을 선택해주세요.');
               event.preventDefault();
               return;
         }
      });  // submit
   }  // fn_join
   
</script>
</head>
<body>
   
   <div id="container">
   
      <h2 class="login" style="letter-spacing:-1px; text-align: center;">Sign up to Web</h2>
      <div style="text-align: center">* 표시는 필수 입력사항입니다.</div>
      
      <hr>
      
      <div id="all">
      <form id="frm_join" action="/user/join" method="post">
      
         <!-- 약관 동의 여부 -->
         <input type="hidden" name="location" value="${location}">
         <input type="hidden" name="promotion" value="${promotion}">
      
        <!-- 아이디 -->         
        <div>        
        <label for="id">        
        	<p style="text-align: left; font-size:15px; color:#666">아이디*</p>
        	<input type="text"  name="id" id="id"placeholder="아이디" class="size">
        	<span id="msg_id"></span>
        </label>
		</div> 
         
        <br>
         
        <!-- 비밀번호 --> 
        <div> 
        <label>
	        <p style="text-align: left; font-size:15px; color:#666">비밀번호*</p>
	        <input type="password" name="pw" id="pw" placeholder="비밀번호" class="size">
	        <span id="msg_pw"></span>
        </label>
		</div>
         
         <br>
         
         <!-- 비밀번호 재확인 -->
        <div> 
        <label>
	        <p style="text-align: left; font-size:15px; color:#666">비밀번호 확인*</p>
	        <input type="password" id="re_pw" placeholder="비밀번호 확인" class="size">
	        <span id="msg_re_pw"></span>
        </label>
		</div>
         
         <br>
         
         <!-- 이름 -->        
        <div> 
        <label>
	        <p style="text-align: left; font-size:15px; color:#666">이름*</p>
	        <input type="text" name="name" id="name" placeholder="이름" class="size">
        </label>
		</div>
         
         <br>
         
        <!-- 별명 -->
        <div> 
        <label>
	        <p style="text-align: left; font-size:15px; color:#666">별명*</p>
	        <input type="text" name="nickname" id="nickname" placeholder="별명" class="size">
        </label>
		</div>
         
         <br>
         
         <!-- 성별 -->
         <div>
            <label for="gender" style="text-align: left; font-size:15px; color:#666">성별</label><br>
            &nbsp;
			<input type="radio" name="gender" id="male" value="M">
	        <label for="male" style="text-align: left; font-size:15px;">남자</label>
	        &nbsp;&nbsp;&nbsp;
	        <input type="radio" name="gender" id="female" value="F">
	        <label for="female" style="text-align: left; font-size:15px;">여자</label>
         </div>
         
         <br>
      
         <!-- 휴대전화 -->
        <div> 
        <label>
	        <p style="text-align: left; font-size:15px; color:#666">휴대전화*</p>
	        <input type="text" name="mobile" id="mobile" placeholder="휴대전화" class="size">
        </label>
		</div>
         
         <br>
      
      	<div>
         <div>
            <label for="grade" style="text-align: left; font-size:15px; color:#666">회원 유형</label><br>
            &nbsp;
			<input type="radio" name="grade" id="common" value="2">
	        <label for="common">일반회원</label>
	        &nbsp;&nbsp;&nbsp;
	        <input type="radio" name="grade" id="company" value="3">
	        <label for="company">기업회원</label>
         </div>
      	</div>
      
         <!-- 생년월일 -->
         <div>
            <label for="birthyear" style="text-align: left; font-size:15px; color:#666">생년월일*</label><br>
            <select name="birthyear" id="birthyear" class="size num1" style="width:100px;"></select>
            <select name="birthmonth" id="birthmonth" class="size num1" style="width:100px;"></select>
            <select name="birthdate" id="birthdate" class="size num1" style="width:100px;"></select>            
         </div>
         
         <br>
         
         <!-- 주소 -->
         <div>
         	<div></div>
            <input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" size=4 placeholder="우편번호" readonly="readonly" class="size">
            <input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기" id="btn_post_code" class="btn btn-outline-secondary" style="margin-bottom: 4px;"><br>
            <br>
            <input type="text" name="roadAddress" id="roadAddress" size=27 placeholder="도로명주소"  readonly="readonly" class="size">
            <input type="text" name="jibunAddress" id="jibunAddress" size=27 placeholder="지번주소"  readonly="readonly" class="size"><br>
            <br>
            <span id="guide" style="color:#999;display:none"></span>
            <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" class="size">
            <input type="text" name="extraAddress" id="extraAddress" size=30 placeholder="참고항목" readonly="readonly" class="size">
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
         
         <!-- 이메일 -->     
         <div>         
	        <div> 
		        <label>
		        	<p style="text-align: left; font-size:15px; color:#666">이메일*</p>
			        <input type="text" name="email" id="email" placeholder="이메일" class="size" style="width:250px">	        
			        <input type="button" value="인증번호받기" id="btn_getAuthCode" class="btn btn-outline-secondary" style="margin-bottom: 4px;">
				</label>
			</div>
            <span id="msg_email"></span><br>
            <input type="text" id="authCode" size=9 placeholder="인증코드 입력" class="size" style="width:150px">
            <input type="button" value="인증하기" id="btn_verifyAuthCode" class="btn btn-outline-secondary" style="margin-bottom: 4px;">
         </div>       
   
         <!-- 버튼 -->
         <div>       	
            <button id="btn_join" class="button" style="background-color:#217Af0; width: 100x; margin-top: 30px;">가입하기</button>
            <input type="button" value="취소" id="btn_cancel" onclick="history.go(-2)" class="btn btn-outline-secondary" style="margin-bottom: 4px;">
         </div>    
      </form>
   	</div> 
   </div>

</body>
</html>