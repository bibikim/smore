<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<script>
	
	// contextPath를 반환하는 자바스크립트 함수
	/*
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	*/
		
	$(document).ready(function(){

		// 서브밋
		$('#frm_edit').submit(function(event){
			if($('#title').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		});
		
		$('#frm_edit').change(function(event){
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
		
		$('#frm_edit').submit(function(event){
			if($('#content').val() == ''){
				alert('내용이 없습니다.');
				event.preventDefault();
				return;
			}
		});		
	});
	
</script>
<style>
	.scenter {
	  	max-width: 900px;
	    width: 100%;
	    display: flex;
	    flex-direction: column;
	    margin: 0 auto;
	    padding: 1.5rem 1.5rem 5rem;
  	}

  	.insertinfo {
		font-weight: 600;
	    font-size: 2rem;
	    line-height: 126.5%;
	    letter-spacing: -.005em;
	    color: #000;  	
  	}
  	
  	.firstflex {
		margin-top: 40px;
    	display: flex;  	
  	}
  	
	[type="radio"] {
	  vertical-align: middle;
	  appearance: none;
	  border: max(2px, 0.1em) solid gray;
	  border-radius: 50%;
	  width: 1.5em;
	  height: 1.5em;
	  transition: border 0.5s ease-in-out;
	  
	}
	
	[type="radio"]:checked {
	  border: 0.4em solid skyblue;
	}

  	.noneflex {
  		margin-top: 20px;
    	display: flex;
  	}
  	
  	.secondflex {
		margin-top: 20px;
    	display: flex;  	
  	}
  	
  	.thirdflex {
		margin-top: 20px;
    	display: flex;  	
  	}
  		
  	.tnczone {
  		margin-top: 20px;
  	}
	
  	.contentbox {
  		font-family: inherit;
	    padding: 1rem 1rem 1.5rem;
	    outline: none;
	    border: 2px solid #e1e1e1;
	    border-radius: 16px;
	   	min-height: 100px;
	    margin-bottom: 10px;
  		width: 1000px;
  		height: 500px;
  		resize: none;
  	}
  	
  	#btn_edit {
		background-color:#000000;
		border-radius:28px;
		border:1px solid #000000;
		display:inline-block;
		cursor:pointer;
		color:white;
		font-family:Arial;
		font-size:13px;
		padding:5px 24px;
		text-decoration:none;
		text-shadow:0px 1px 0px #2f6627;
	}
	
	#btn_list {
		background-color:#000000;
		border-radius:28px;
		border:1px solid #000000;
		display:inline-block;
		cursor:pointer;
		color:white;
		font-family:Arial;
		font-size:13px;
		padding:5px 24px;
		text-decoration:none;
		text-shadow:0px 1px 0px #2f6627;
	}
	
	#editbtn {
	  	display: flex;
	    justify-content: flex-end;
	    margin: 16px -150px 24px;		
	}
	
	#seccolor {
		color: #666;
	}		  	
</style>

<div class="scenter">

	<section>
	<div class="insertinfo">
		프로젝트 기본 정보를 입력해주세요!
	</div>
	
	<hr>
	</section>
	
	<form id="frm_edit" action="/study/modify" method="post">
	
		<input type="hidden" name="studNo" value="${study.studNo}">	
	
		<div>
			<img src="../../resources/images/monster.png" > 『 ${loginUser.nickname} 』
			<input type="hidden" name="studyNo" value="${loginUser.userNo}">
		</div>
		
		<section>
		
		<div class = "firstflex">
			<label for="gender" id="seccolor">성별</label>
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
			<label for="region" id="seccolor">지역</label>
			&nbsp;&nbsp;
			<input type="text" value="${study.region}" readonly>	 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;

		 <label for="lang" id="seccolor">기술 스택</label>
		 	&nbsp;&nbsp;
			<select name="lang" id="lang">			
				<option value = "${study.lang}" selected>${study.lang}</option>
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
		 
		 	<label for="people" id="seccolor">정원</label>
		 	&nbsp;&nbsp;
			<select name="people" id="people">
				<option value = "${study.people}" selected>${study.people}</option>
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
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	<label for="studDate" id="seccolor">시작예정일&nbsp;&nbsp;</label>
			<input type="date" id="studDate" name="studDate" min="2022-01-01" max="2024-12-31" value="${study.studDate}">
		 </div>
				
		<div class="thirdflex">
			<label for="contact" id="seccolor">연락방법&nbsp;&nbsp;</label>
			<select>
				<option value = "1" selected>연락처</option>
				<option value = "2" >카카오톡</option>
				<option value = "3" >이메일</option>
				<input type="text" id="contact" name="contact"  value="${study.contact}">
			</select>
		</div>
	</section>
	
	<section>
		<div class="tnczone">
			<label for="title" id="seccolor">제목</label>
			<input type="text" name="title" id="title" value="${study.title}">
		</div>
		
		<div>
			<label for="content" id="seccolor">내용</label>
		</div>
	</section>
		<div>	
			<textarea class="contentbox" name="content" id="content">${study.content}</textarea>				
		</div>
		
		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) 
		<div id="summernote_image_list"></div>
		-->
	<section id="editbtn">
		<div>
			<button id="btn_edit">수정완료</button>
			<input type="button" id="btn_list" value="취소" onclick="location.href='/'">
		</div>
	</section>		
		
	</form>
	
</div> 
<jsp:include page="../layout/footer.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>
</body>
</html>