<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
	
	<form id="frm_edit" action="${contextPath}/study/modify" method="post">
	
		<input type="hidden" name="studNo" value="${study.studNo}">
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="${study.title}">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content">${study.content}</textarea>				
		</div>
		
		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) -->
		<div id="summernote_image_list"></div>
		
		<div>
			<button>수정완료</button>
			<input type="button" value="목록" onclick="location.href='/'">
		</div>
		
	</form>
	
</div> 

</body>
</html>