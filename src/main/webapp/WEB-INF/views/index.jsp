<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<style>
	* {
		box-sizing: border-box;
	}
	a {
		text-decoration: none;
		color: black;
	}
	.study_list_container {
		margin: 0 auto;
		width: 1260px;
		display: flex;
		flex-wrap: wrap;
	}
	.study {
		width: 400px;
		height: 400px;
		margin: 10px;
		padding-top: 150px;
		border: 1px solid gray;
		border-radius: 5px;
		text-align: center;
		
	}
	.study:hover {
		background-color: skyblue;
	}
	.wrapper {
		display: flex;
		justify-content: center;  /* wrapper의 자식을 가로 가운데 정렬 */
		align-items: center;      /* wrapper의 자식을 세로 가운데 정렬 */
		min-height: 100vh;
	}
	/*
	.loading_bar {
		width: 200px;
		height: 200px;
		background-image: url('../../../resources/images/loading.gif');
		background-size: 200px 200px;
	}
	*/
	.blind {
		display: none;
	}	
	
	/* footer */
	.py-5 {
		padding: 40px 0 !important;
	}
	
	/* slide */
	#img_area1, #img_area2, #img_area3 {
		width: 1200px !important;
		height: 400px !important;
		margin: auto !important;
		display: block !important;
	}
	
</style>
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
					studyList += '<div>번호 : ' + study.studNo + '</div>';
					studyList += '<div>닉네임 : ' + study.nickname + '</div>';
					studyList += '<div>개발언어 : ' + study.lang + '</div>';
					studyList += '<div>지역 : ' + study.region + '</div>';
                    // studyList += '<a href="/study/detail?studNo=' + study.studNo + '">' + study.title + '</a>';
                    // studyList += '<div><a href="/study/increse/hit?studNo=' + study.studNo + '">' + study.title + '</a></div>';
					// onclick="location.href='/study/increse/hit?studNo=${study.studNo}'"
					// location="/study/increse/hit?studNo=${study.studNo}"
                    // studyList += '</a>' + '</div>';
                    studyList += '</div>';
					$('.study_list_container').append(studyList);
				});
				$('.study_list').removeClass('blind'); // 목록 보여주기
				$('.wrapper').addClass('blind');          // 로딩바 숨기기
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
	/*
	$(document).ready(function(){
	    $(".study").on("click", function(){  
	        alert("테스트입니다요.");
	    });    
	});
	*/
</script>
<body>

    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="../../resources/images/study01.png" id="img_area2" class="d-block w-100" alt="이미지2">
	    </div>
	    <div class="carousel-item">
	      <img src="../../resources/images/study02.jpg" id="img_area1" class="d-block w-100" alt="이미지1">
	    </div>
	    <div class="carousel-item">
	      <img src="../../resources/images/study03.jpg" id="img_area3" class="d-block w-100" alt="이미지3">
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

	<div>
		<h1>스터디 목록</h1>
	</div>
	
	<hr>
	
	<div>
		<c:if test="${loginUser != null}">
			<input type="button" value="글 작성하기" onclick="location.href='/study/write'">
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
	
	<!-- Footer-->
    <footer class="py-5 bg-dark">
        <div class="container">
        	<p class="m-0 text-center text-white">&nbsp; ⓒ 2022 &nbsp; s'more copyright</p>
        </div>
    </footer>
	
</body>

</html>