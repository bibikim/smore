<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="약관 동의" name="title"/>
</jsp:include>

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

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
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

	<div>
	
		<h1>약관 동의하기</h1>
		
		<form id="frm_agree" action="${contextPath}/user/join/write">
		
			<div>
				<input type="checkbox" id="check_all" class="blind">
				<label for="check_all" class="lbl_all">
					이용약관, 개인정보수집, 위치정보수집(선택), 마케팅(선택)에 모두 동의합니다.
				</label>
			</div>
			
			<hr>
			
			<div>
				<input type="checkbox" id="service" class="check_one blind">
				<label for="service" class="lbl_one">이용약관 동의(필수)</label>
				<div>
					<textarea>본 약관은 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="privacy" class="check_one blind">
				<label for="privacy" class="lbl_one">개인정보수집 동의(필수)</label>
				<div>
					<textarea>개인정보보호법에 따라 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="location" name="location" class="check_one blind">
				<label for="location" class="lbl_one">위치정보수집 동의(선택)</label>
				<div>
					<textarea>위치정보 ...</textarea>
				</div>
			</div>
			<div>
				<input type="checkbox" id="promotion" name="promotion" class="check_one blind">
				<label for="promotion" class="lbl_one">마케팅 동의(선택)</label>
				<div>
					<textarea>마케팅 ...</textarea>
				</div>
			</div>
			
			<hr>
			
			<div>
				<input type="button" value="취소" onclick="fn_cancel()">
				<button>다음</button>
				<script>
					function fn_cancel(){
						location.href='/user/login/form';
					}
				</script>
			</div>
		
		</form>
		
	</div>

</body>
</html>