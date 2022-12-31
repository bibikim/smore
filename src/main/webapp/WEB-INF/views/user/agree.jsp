<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<style>

	#submits{
		text-align: center;
		margin-top: 30px;
		margin-left: 50px;
	}

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
<title>Smore</title>
<script>

	$(function(){
		fn_checkAll();
		fn_checkOne();
		fn_toggleCheck();
		fn_submit();
	});
	
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

	<div class="wrap RegisterWrap palm-leaf">
		<div class="main_register_wrap__2Rm-j">
			<div class="right_right_area_register__1xzTV" style="width: 600px; padding-bottom: 5%; padding-top: 5%;">
				<div class="right_join_wrap__2w-MC" style="margin-right: 80px;">
					<form id="frm_agree" action="/user/join/write">
						<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png"  style=" text-align: center; width: 210px;"></a>
				 		<h3 class="login" style=" text-align: center; padding : 10px 0 30px 80px;  letter-spacing:-1px;  font-size: 23px; font-size:25px; font-weight: 900; color:#333;">약관 동의</h3>	
	 					<div>
							<input type="checkbox" id="check_all" class="blind">
							<label for="check_all" class="lbl_all">
								이용약관, 개인정보수집, 위치정보수집(선택), 마케팅(선택)에 모두 동의합니다.
							</label>
						</div>
				 		
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
							<input type="checkbox" id="promotion" name="promotion" class="check_one blind" >
							<label for="promotion" class="lbl_one">마케팅 동의(선택)</label>
							<div>
								<textarea style="width: 500px; height: 100px;" class="form-control">S'more 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화, 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 S'more 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.</textarea>
							</div>
						</div>
		 		
		 				<div id="submits">
							<button class="btn btn-outline-primary" style="width: 150px; height: 50px; display :inline-block;">다음</button>
							<input type="button" value="취소" onclick="fn_cancel()" class="btn btn-outline-secondary" style="width: 150px; height: 50px; display :inline-block;">
							<script>
								function fn_cancel(){
									location.href='/user/login/form';
								}
							</script>
						</div>	
					</form>				
			    </div> 
		    </div>
	    </div>
	</div>

</body>
</html>