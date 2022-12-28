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

		// 목록
		$('#btn_list').click(function(){
			history.back();
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
	
	function getLocation() {
		if (navigator.geolocation) { // GPS를 지원하면
			navigator.geolocation.getCurrentPosition(function(position) {
		        var lat = position.coords.latitude;
				var lng = position.coords.longitude;
				alert('현재 위치는 ' + position.coords.latitude + ' , ' + position.coords.longitude + '입니다.');
				}, function(error) {
				  console.error(error);
				}, {
			      enableHighAccuracy: false,
			      maximumAge: 0,
			      timeout: Infinity
			    });
			} else {
				alert('GPS를 지원하지 않습니다');
			}
 		}
	// getLocation();
	
	$(document).ready(function() {
	  $('#region').change(function() {
	    var result = $('#region option:selected').val();
	    if (result == '부산') {
	      $('.부산').show();
	    } else {
	      $('.부산').hide();
	    }
	  }); 
	}); 	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_write" action="/study/add" method="post">
	
		<div>
			작성자 ▷ ${loginUser.nickname}
			<input type="hidden" name="studyNo" value="${loginUser.userNo}">
		</div>
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"></textarea>				
		</div>
		
		<div>
			<label for="gender">성별</label>
			   <input type="radio" name="gender" id="male" value="M">
               <label for="male">남자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="female" value="F">
               <label for="female">여자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="both" value="B">
               <label for="both">상관없음</label>
		</div>
		
		<div>
			<label for="region">지역</label>
			
			<select name="region" id="region">

				<option value = "서울" selected>서울</option>
				<option value = "부산" >부산</option>
				<option value = "대구" >대구</option>
				<option value = "광주" >광주</option>

			</select>


			<div class="서울" id="region">
				<label for="wido"></label>
				<input type="hidden" name="wido" id="wido" value="37.566535">	
				<label for="gdo"></label>
				<input type="hidden" name="gdo" id="gdo" value="126.9779692">		
			</div>
			<div class="부산" id="region">
				<label for="wido"></label>
				<input type="hidden" name="wido" id="wido" value="35.1795543">	
				<label for="gdo"></label>
				<input type="hidden" name="gdo" id="gdo" value="129.0756416">		
			</div>			
			<!-- 
			<c:if test="${study.region == '서울'}">
				<label for="wido"></label>
				<input type="hidden" name="wido" id="wido" value="37.566535">	
				<label for="gdo"></label>
				<input type="hidden" name="gdo" id="gdo" value="126.9779692">
			</c:if>
			 -->	
		</div>


		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) 
		<div id="summernote_image_list"></div>
		-->
		<div>
			<label for="lang">개발언어</label>
			<select name="lang" id="lang">
				<option value = "자바" selected>JAVA</option>
				<option value = "파이썬" >PYTHON</option>
				<option value = "C" >C</option>
			</select>
		</div>
		
		<div>
			<label for="people">정원</label>
			<select name="people" id="people">
				<option value = "2" selected>2</option>
				<option value = "3" >3</option>
				<option value = "4" >4</option>
			</select>
		</div>
		
		<div>
			<label for="contact">연락방법</label>
			<input type="text" name="contact" id="contact">
		</div>
		
		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list" onclick="location.href='/';">
		</div>
		<!-- 
		<div>
			<label for="wido"></label>
			<input type="hidden" name="wido" id="wido" value="wido">	
			<label for="gdo"></label>
			<input type="hidden" name="gdo" id="gdo" value="gdo">	
		</div>
		 -->
		
	</form>
	
</div>

</body>
</html>