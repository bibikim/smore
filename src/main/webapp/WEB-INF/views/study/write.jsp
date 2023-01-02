<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="../../../resources/css/study/write.css">

<script>

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

		$('#frm_write').submit(function(event){
			if($('#people').val() == 'none'){
				alert('인원을 정해주세요.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});			

		$('#frm_write').submit(function(event){
			if($('#region').val() == 'none'){
				alert('지역을 골라주세요.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});			
		
		$('#frm_write').submit(function(event){
			if($('#lang').val() == 'none'){
				alert('언어를 골라주세요.');
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
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#studDate').val() == ''){
				alert('예정날짜를 정해주세요.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});	

		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#content').val() == ''){
				alert('내용이 없습니다.');
				event.preventDefault();  // 서브밋 취소
				return;  // 더 이상 코드 실행할 필요 없음
			}
		});	
	
		
	});
	
	/*
	function checkOnlyOne(element) {
		  
		  const checkboxes 
		      = document.getElementsByName("lang");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}
	*/
	
</script>

<body>

<div class="scenter">
	<section>
	<div class="insertinfo">
		프로젝트 기본 정보를 입력해주세요!
	</div>
	
	<hr>
	</section>
	
	<form id="frm_write" action="/study/add" method="post">
	
		<div>
			<img src="../../resources/images/monster.png" > 『 ${loginUser.nickname} 』
			<input type="hidden" name="studyNo" value="${loginUser.userNo}">
		</div>
		
		<section>
		
		<div class = "firstflex">
			<label for="gender" id="seccolor">성별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			&nbsp;&nbsp;
			   <input type="radio" name="gender" id="male" value="M">
               <label for="male" id="seccolor">남자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="female" value="F">
               <label for="female" id="seccolor">여자만</label>
               &nbsp;&nbsp;
               <input type="radio" name="gender" id="both" value="B" checked>
               <label for="both" id="seccolor">상관없음</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		
		</section>
		
		

		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) 
		<div id="summernote_image_list"></div>
		-->
		
		
		<div class="noneflex">
			<!-- 
			<label for="lang">기술스택</label>

			<input type='checkbox'
			       name='lang'
			       id='lang1' 
			       value='Java'
			       onclick='checkOnlyOne(this)'>
			<label for="lang1">Java</label>

			<input type='checkbox' 
			       name='lang' 
			       id='lang2'
			       value='Python' 
			       onclick='checkOnlyOne(this)'>
			<label for="lang2">Python</label>

			<input type='checkbox' 
			       name='lang'
			       id='lang3'
			       value='Javascript'
			       onclick='checkOnlyOne(this)'>
			<label for="lang3">Javascript</label>       
			         
			<input type='checkbox' 
			       name='lang'
			       id='lang4'
			       value='HTML'
			       onclick='checkOnlyOne(this)'>
			<label for="lang4">HTML</label>        
			       
			<input type='checkbox' 
			       name='lang'
			       id='lang5'
			       value='CSS'
			       onclick='checkOnlyOne(this)'>
			<label for="lang5">CSS</label> 
						       
			<input type='checkbox' 
			       name='lang'
			       id='lang6'
			       value='React'
			       onclick='checkOnlyOne(this)'>
 			<label for="lang6">React</label>  
			       
			<input type='checkbox' 
			       name='lang'
			       value='Nodejs'
			       id='lang7'
			       onclick='checkOnlyOne(this)'>
			<label for="lang7">Nodejs</label> 
			
			<input type='checkbox' 
			       name='lang'
			       id='lang8'
			       value='Spring'
			       onclick='checkOnlyOne(this)'>  
			<label for="lang8">Spring</label>          
			 -->
			<label for="region" id="seccolor">지역&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			&nbsp;&nbsp;
			<select name="region" id="region" class="region">

				<option value = "none" selected>지역을 정해주세요</option>
				<option value = "Seoul" >Seoul</option>
				<option value = "Busan" >Busan</option>
				<option value = "Gangnam" >Gangnam</option>
				<option value = "Jam-sil" >Jam-sil</option>

			</select>	 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;

		 <label for="lang" id="seccolor">기술 스택</label>
		 	&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="lang" id="lang">			
				<option value = "none" selected>프로젝트 사용 스택</option>
				<option value = "JavaScript" >JavaScript</option>
				<option value = "TypeScript" >TypeScript</option>
				<option value = "React" >React</option>
				<option value = "Vue" >Vue</option>
				<option value = "Nodejs" >Nodejs</option>
				<option value = "Spring" >Spring</option>
				<option value = "Java" >Java</option>
				<option value = "Python" >Python</option>
				<option value = "C++" >C++</option>
			</select>
		</div>
		
	<section>
	
	
		 <div class="secondflex">
		 
		 	<label for="people" id="seccolor">정원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		 	&nbsp;&nbsp;
			<select name="people" id="people">
				<option value = "none" selected></option>
				<option value = "2" >2</option>
				<option value = "3" >3</option>
				<option value = "4" >4</option>
				<option value = "5" >5</option>
				<option value = "6" >6</option>
				<option value = "7" >7</option>
				<option value = "8" >8</option>
				<option value = "9" >9</option>
				<option value = "10" >10</option>
			</select>
		 	 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	<label for="studDate" id="seccolor">시작예정일&nbsp;&nbsp;</label>
			<input type="date" id="studDate" name="studDate" min="2022-01-01" max="2024-12-31">
		 </div>
				
		<div class="thirdflex">
			<label for="contact" id="seccolor">연락방법&nbsp;&nbsp;</label>
			<select>
				<option value = "1" selected>연락처</option>
				<option value = "2" >카카오톡</option>
				<option value = "3" >이메일</option>
			</select>
				<input type="text" id="contact" name="contact">
		</div>
	</section>
	
	<section>
		<div class="tnczone">
			<label for="title" id="seccolor">제목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;</label>
			<input type="text" name="title" id="title" placeholder="제목을 입력해 주세요!">
		</div>
		
		<div>
			<label for="content" id="seccolor">내용</label>
		</div>
	</section>		
		<div>	
			<textarea class="contentbox" name="content" id="content" placeholder="내용을 입력해 주세요!"></textarea>				
		</div>
	<section id="writebtn">
		<div>
			<button id="btn_add">작성완료</button>
			<input type="button" value="취소" id="btn_list" onclick="location.href='/';">
		</div>
		
		<div>
			<label for="wido" class="wido"></label>
			<input type="hidden" class = "wido" name="wido" id="wido" value="">	
			<label for="gdo" class="gdo"></label>
			<input type="hidden" class = "gdo" name="gdo" id="gdo" value="">		
		</div>
	</section>			
	</form>
	
	
</div>
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>
</body>
</html>