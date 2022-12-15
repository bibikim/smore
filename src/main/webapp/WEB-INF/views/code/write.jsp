<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="코드게시판작성" name="title"/>
</jsp:include>

<script>
	
	// contextPath를 반환하는 자바스크립트 함수
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	
	$(document).ready(function(){
		// 목록
		$('#btn_list').click(function(){
			location.href = getContextPath() + '/list';
		});
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});
		
	});
	
</script>

<div>

	<h1>작성 화면</h1>
	
	<form id="frm_write" action="${contextPath}/code/add" method="post">
	
		<div>
			작성자 ▷ ${loginUser.nickname}
			<input type="hidden" name="nickname" value="${loginUser.nickname}">
		</div>
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="c_title" id="title">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="c_content" id="c_content"></textarea>				
		</div>

		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list">
		</div>
		
	</form>
	
</div>

</body>
</html>