<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
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
			location.href = getContextPath() + '/code/list';
		});
		
		// 서브밋
		$('#frm_edit').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		});
		
	});
	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_edit" action="${contextPath}/code/modify" method="post">
	
		<input type="hidden" name="coNo" value="${code.coNo}">
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="${code.title}">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content">${code.content}</textarea>				
		</div>
		
		
		<div>
			<button>수정완료</button>
			<input type="button" value="목록" id="btn_list">
		</div>
		
	</form>
	
</div> 

</body>
</html>