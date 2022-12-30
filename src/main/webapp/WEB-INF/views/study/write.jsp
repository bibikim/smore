<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<script>
/*
	$(function() {	
		fn_year();
		fn_month();
		fn_date();
	});
*/
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
		
		$('#frm_write').change(function(event){
			if($('#region').val() == 'Seoul'){
				$('.wido').val('37.566535') && $('.gdo').val('126.9779692');
			} else if ($('#region').val() == 'Busan'){
				$('.wido').val('35.1795543') && $('.gdo').val('129.0756416');
			} else if ($('#region').val() == 'Gangnam'){
				$('.wido').val('37.498095') && $('.gdo').val('127.027610');
			} else if ($('#region').val() == 'Jam-sil'){
				$('.wido').val('37.513272317072') && $('.gdo').val('127.09431687965');
			}
		});
		
		
		$(document).on('click', function(){
			var list = '';
			$('.lang:checked').each(function(){
				list += $(this).val()+'/';
			})
			console.log(list);
			
			$.ajax({
				type : 'get',
				url : '/study/add',
				dataType : 'json',
				success : function(resData){
					console.log(result);
				},
				error : function(xhr){
					console.log(xhr.responseText);
				}
			});
		});	
		
	});
	


	/*
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
	*/
	// getLocation();
	
	/*
	$(document).ready(function() {
	  $('#region').change(function() {
	    var result = $('#region option:selected').val();
	    if (result == '서울') {
	      $('.서울').val() == ;
	    } else {
	      $('.부산').hide();
	    }
	  }); 
	}); 
	*/
	/*
	function fn_year(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#year').append(strYear);
		$('#year').val('${loginUser.birthyear}').prop('selected', true);
	}
	
	function fn_month(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#month').append(strMonth);
		$('#month').val('${loginUser.birthday.substring(0,2)}').prop('selected', true);
	}
	
	function fn_date(){
		$('#date').empty();
		$('#date').append('<option value="">일</option>');
		let endDay = 0;
		let strDay = '';
		switch($('#birthmonth').val()){
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
		$('#date').append(strDay);
		$('#date').val('${loginUser.birthday.substring(2)}').prop('selected', true);
	}
	*/
	

</script>
<body>

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
			
			<select name="region" id="region" class="region">

				<option value = "Seoul" selected>Seoul</option>
				<option value = "Busan" >Busan</option>
				<option value = "Gangnam" >Gangnam</option>
				<option value = "Jam-sil" >Jam-sil</option>

			</select>

			<div>
				<label for="wido" class="wido"></label>
				<input type="hidden" class = "wido" name="wido" id="wido" value="">	
				<label for="gdo" class="gdo"></label>
				<input type="hidden" class = "gdo" name="gdo" id="gdo" value="">		
			</div>

		</div>
		
		
		
		

		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) 
		<div id="summernote_image_list"></div>
		-->
		<div onchange="checklang">
			<label for="lang" class="btn_lang">기술스택</label>
			<!-- 
			<select name="lang" id="lang">
				<option value = "Java" selected>Java</option>
				<option value = "Python" >Python</option>
				<option value = "JavaScript" >JavaScript</option>
				<option value = "HTML" >HTML</option>
				<option value = "CSS" >CSS</option>
				<option value = "Nodejs" >Nodejs</option>
				<option value = "SpringBoot" >SpringBoot</option>
			</select>
			 -->
			 <!-- 
			<input type='checkbox'
			       name='lang' 
			       id = "lang"
			       value='selectall'
			       onclick='selectAll(this)'/> 모두선택
			  -->

			<input type='checkbox'
			       name='lang' 
			       class='lang'
			       value='Java'> Java

			<input type='checkbox' 
			       name='lang' 
				   class='lang'
			       value='Python' > Python

			<input type='checkbox' 
			       name='lang'
			       class='lang'			        
			       value='Javascript'> Javascript
			       
		</div>
		
		<div>
			<label for="people">정원</label>
			<select name="people" id="people">
				<option value = "2" selected>2</option>
				<option value = "3" >3</option>
				<option value = "4" >4</option>
				<option value = "5" >5</option>
				<option value = "6" >6</option>
				<option value = "7" >7</option>
				<option value = "8" >8</option>
				<option value = "9" >9</option>
				<option value = "10" >10</option>
			</select>
		</div>

		<div>
			<label for="studDate">시작예정일자</label>
			<select id="year" name= "studDate" class="form-control">
			  <option value="year">년</option>
			  <c:forEach var="i" begin="2020" end="2030">
			    <option value="${i}">${i}</option>
			  </c:forEach>
			</select>
			  
			<select id="month" class="form-control">
			  <option value="month">월</option>
			  <c:forEach var="i" begin="1" end="12">
			  <c:choose>
			      <c:when test="${i lt 10 }">
			          <option value="0${i}">0${i}</option>
			      </c:when>
			      <c:otherwise>
			          <option value="${i}">${i}</option>
			      </c:otherwise>
			  </c:choose>
			  </c:forEach>
			</select>
			  
			<select id="day" class="form-control">
			  <option value="day">일</option>
			  <c:forEach var="i" begin="1" end="31">
			  <c:choose>
			      <c:when test="${i lt 10 }">
			          <option value="0${i}">0${i}</option>
			      </c:when>
			      <c:otherwise>
			          <option value="${i}">${i}</option>
			      </c:otherwise>
			  </c:choose>
			  </c:forEach>
			</select>
			
		</div>

				
		<div>
			<label for="contact">연락방법</label>
			<select>
				<option value = "1" selected>연락처</option>
				<option value = "2" >카카오톡</option>
				<option value = "3" >이메일</option>
				<input type="text" id="contact" name="contact">
			</select>
		</div>
		
		<div>
			<button>작성완료</button>
			<input type="reset" value="입력초기화">
			<input type="button" value="목록" id="btn_list" onclick="location.href='/';">
		</div>
		
	</form>
	

</div>
</body>
</html>