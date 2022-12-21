<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/css/base.css">
<body>
<form name="dataForm" id="dataForm" method="post" class="form-horizontal">
		<input type="hidden" name="qaNo" id="qaNo" value="${question.qaNo}">
        <div class="container pw_container">
            <div class="pw_popup">
                <ul>
                    <li>등록시 입력한 비밀번호를 입력 하여 주세요.</li>
                    <li>
                        <label for="q_password">비밀번호</label>
                        <input type="password" id="password" name="password" class="pw_box" autocomplete="off">
                    </li>
                    <button type="button" id="pw_btn" class="pw_btn">확인</button>
                </ul>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">

	

	$("#pw_btn").on('click', function(){
		if($('#password').val() == '') {
			alert('비밀번호를 입력해주세요.')
			return;
		}
		var check = /^[0-9]+$/; 
		if (!check.test($('#password').val())) {
			alert("숫자만 입력 가능합니다.");
			return;
		}
		var form = $("#dataForm")[0];

		var data = new FormData(form);

		$.ajax({
		    url: "/qna/chkPw", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
		    data: data,  // HTTP 요청과 함께 서버로 보낼 데이터
		    type: "POST",   // HTTP 요청 메소드(GET, POST 등)
		    processData: false,
			contentType: false,
			cache: false,
			dataType: "json",
			timeout: 600000,
			beforeSend : function() {
				// 전송 전 실행 코드
			},
			success: function (data) {
				if(data.resCd == '0000'){
					var qaNo = $("#qaNo").val();
					opener.window.location = '/qna/detail?qaNo='+qaNo;
					close();
				}else{
					alert("비밀번호가 일치하지 않습니다.");
				}
			},
			error: function (e) {
				// 전송 후 에러 발생 시 실행 코드
				console.log("ERROR : ", e);
			}
		});
	});
</script>
</html>