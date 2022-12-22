<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
#reason {
    padding-left: 0;
}
</style>
<script>

</script>
<body>
<div>
	<h1>신고하기</h1>
	<form id="frm_red" action="${contextPath}/study/sendred" method="post">
	<div>
		신고자 ▷ ${study.nickname}
	</div>
	<div>
		스터디번호 ▷ ${study.studNo}
	</div>
	<div>
		신고일자 ▷ ${study.stud_Date}
	</div>

	<div>
		<h2>신고사유</h2>
		<ul id="reason">
			<li id="A">
				<div class="RA">
					<input type="radio" name="Rred" id="R1">
					<label for="R1">예정일자 지연</label>
				</div>
			</li>
			<li id="B">
				<div class="RB">
					<input type="radio" name="Rred" id="R2">
					<label for="R2">부적절한 주제</label>
				</div>
			</li>			
			<li id="C">
				<div class="RC">
					<input type="radio" name="Rred" id="R3">
					<label for="R3">폭언, 욕설, 혐오 발언</label>
				</div>
			</li>			
			<li id="D">
				<div class="RD">
					<input type="radio" name="Rred" id="R4">
					<label for="R4">스팸</label>
				</div>
			</li>
		</ul>
	</div>	
	<div>
		<label for="content">내용</label>
		<textarea name="content" id="content"></textarea>				
	</div>
	
	<br>
	<br>
	
	<div>
		<button>작성완료</button>
	</div>
	
	</form>
</div>
</body>

</html>