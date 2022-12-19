<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="자유게시판" name="title"/>
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>

<script>
	
	$(document).ready(function(){
		
		$('.btn_remove').click(function(){
			if(confirm('게시글을 삭제하시겠습니까?')) {
				$('#frm_btn').attr('action', '/free/remove');
				$('#frm_btn').submit();
			}
		})
		
		
		$('.btn_modify').click(function(){
			$('#frm_btn').attr('action', '/free/edit');
			$('#frm_btn').submit();
		})
		
		

		
	});

</script>
<style>
	* {
		box-sizing: border-box;
	}
</style>
</head>
<body>
	<div style="width: 800px; display: inline-block;" >
		<div style="width: 300px;">
			<input type="button" value="목록" onclick="location.href='/free/list'">
			<input type="button" value="이전글">
			<input type="button" value="다음글">
		</div>
		<div style="width: 200px; display: inline-block;">
			<form id="frm_btn" method="post">
				<input type="hidden" name="freeNo" value="${free.freeNo}">
				<input type="button" value="수정" class="btn_modify">
				<input type="button" value="삭제" class="btn_remove">
			</form>
		</div>
	</div>
	<div>
		<table>
			<tbody>
				<tr>
					<td>${free.title}</td>
				</tr>
				<tr>
					<td>${free.modifyDate}</td>
				</tr>
				<tr>
					<td>
						<p style="text-align: left;">${free.content}</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<div>
			<button id="btn_comment" class="" style="">
			댓글 
			<span class="">${comment}개</span>
			</button>
		</div>
	</div>
</body>
</html>