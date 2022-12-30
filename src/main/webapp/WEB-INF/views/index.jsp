<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="../../resources/css/index.css">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>

<script>

	// 전역변수
	var page = 1;
	var totalPage = 0;
	var timer;
	
	// 목록 가져오기
	function fn_getS_group() {
		$('.study_list').addClass('blind');    // 목록 숨기기
		$('.wrapper').removeClass('blind');       // 로딩바 보여주기
		$.ajax({
			type: 'get',
			url: '/study/list_scroll',
			data: 'page=' + page,  // page=1, page=2, page=3, ...으로 동작함
			dataType: 'json',
			success: function(resData){
				totalPage = resData.totalPage;  // 목록을 가져올 때 전체 페이지 수를 저장해 둠
				page = page + 1;                // 스크롤을 통해서 한 페이지를 가져올때마다 다음 스크롤에서는 다음 페이지를 가져올 수 있도록 page를 증가시킴
				$.each(resData.S_group, function(i, study){
					// var studyList = '<div class="study" style="cursor:pointer;">' + '<a href="/study/increse/hit?studNo=' + study.studNo + '">';
					var studyList = '<div class="study" onclick=location.href="/study/increse/hit?studNo=' + study.studNo + '">';
					studyList += '<div style="color: gray;">시작 예정일  ' + study.studDate + '</div>&nbsp;';
					studyList += '<div class="stud_title">' + study.title + '</div>&nbsp;';
					studyList += '<div class="stud_content">' + study.content + '</div>&nbsp;';
					
					studyList += '<div class="tag"><p class="tag_span">#' + study.lang + '</p></div>';
					studyList += '<div class="tag"><p class="tag_span">#' + study.region + '</p></div>';
					studyList += '<div class="tag"><p class="tag_span">#max&nbsp;' + study.people + '</p></div>';

					studyList += '<div id="gubun"></div>';
					studyList += '<div><div class="nick"><div class="stud_nick"><div><img src="../../resources/images/monster.png" ></div><div style="margin: 5px;">' + study.nickname + '</div></div><div class="stud_hit"><div><img src="../../resources/images/eye.png" ></div>&nbsp;<div>' + study.hit + '</div></div></div></div>';
					
                    studyList += '</div>';
					$('.study_list_container').append(studyList);
				});
				$('.study_list').removeClass('blind'); // 목록 보여주기
				$('.wrapper').addClass('blind'); // 로딩바 숨기기
			}
		});
	}
	$(document).ready(function(){
		
		/*
			스크롤 이벤트는 1px마다 동작하므로 매우 자주 동작하는 이벤트임
			스크롤을 빠르게 움직이면 문서의 마지막에 도착했을때 동일한 ajax 요청이 2번 이상 호출될 수 있음(동일한 페이지를 2개 이상 가져옴)
			이 문제를 해결하기 위해서 디바운스를 이용함
			
			디바운스(Debounce)
			지정된 시간 후에 동작하는 setTimeout 타이머 함수를 이용해서 일정 시간 이전의 연속적인 스크롤 요청은 동작하지 않도록 처리
		*/
		
		// 스크롤을 움직이기 전 첫 목록을 가져옴
		fn_getS_group();
		
		// 스크롤 이벤트
		$(window).scroll(function(){
			// 동일한 setTimeout이 다시 요청되었다면 setTimeout 동작 취소
			if(timer) {
				clearTimeout(timer);
			}
			// 마지막 스크롤 후 0.2초 후에 동작하는 setTimeout
			timer = setTimeout(function(){
				var scrollTop = $(this).scrollTop();        // 스크롤 된 길이
				var windowHeight = $(this).height();        // 웹 브라우저(화면) 높이
				var documentHeight = $(document).height();  // 문서 전체 높이
				if((scrollTop + windowHeight) >= documentHeight){  // 스크롤이 화면 끝까지 내려갔음
					if(page > totalPage){  // 마지막 페이지를 넘어가면 동작 안함
						return;
					}
					fn_getS_group();
				}
			}, 200);  // 200밀리초 = 0.2초(시간은 알아서 조절할 것)
		});
		
	});

	
</script>
<body>

	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="../../resources/images/color1.png" class="img" alt="이미지1">
			</div>
			<div class="carousel-item">
				<img src="../../resources/images/color2.png" class="img" alt="이미지2">
			</div>
			<div class="carousel-item">
				<img src="../../resources/images/color3.png" class="img" alt=".이미지3">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		</a>
		<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		</a>
	</div>

	<br>

	<div id="btn_write">
		<c:if test="${loginUser != null}">
			<a class="btn_write_a" href="/study/write">&nbsp;등록하기&nbsp;</a>
		</c:if>
	</div>
	
	<!-- 스터디 목록 -->
	<div id="study_list" class="study_list">
		<div class="study_list_container"></div>
	</div>
	
	<!-- 로딩바 -->
	<div class="wrapper">	
		<div class="loading_bar"></div>
	</div>
	
<jsp:include page="layout/footer.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>
	
</body>

</html>