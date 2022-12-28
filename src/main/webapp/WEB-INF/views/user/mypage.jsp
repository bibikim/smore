<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="../layout/header.jsp">
	<jsp:param value="${loginUser.nickname}님 마이페이지" name="title"/>
</jsp:include>

<style>

	/* 페이징 */
	#paging  {
		font-size: 12px;
		color: gray;
	}
	#paging span, #paging strong {
		margin: 0 3px;
	}
	.lnk_enable {
		cursor: pointer;
	}
	.lnk_enable:hover {
		color: limegreen;
	}

	.menu a{cursor:pointer;}
	.menu .hide{display:none;}
	
	input#btn_remove{
		display: none;
	}
	
	input#btn_trans{
		display: none;
	}
	
	.wrapper .sidebar{
	    background: #039BE5;
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 225px;
	    height: 100%;
	    padding: 20px 0;
	    transition: all 0.5s ease;
	}
	.wrapper .sidebar ul li a{
	    display: block;
	    padding: 13px 30px;
	    border-bottom: 1px solid #10558d;
	    color: rgb(241, 237, 237);
	    font-size: 16px;
	    position: relative;
	}
	
	.wrapper .sidebar ul li a .icon{
	    color: #dee4ec;
	    width: 30px;
	    display: inline-block;
	}
	.wrapper .sidebar ul li a:hover,
	.wrapper .sidebar ul li a.active{
	    color: #0c7db1;
		text-decoration: none;
	    background:white;
	    border-right: 2px solid rgb(5, 68, 104);
	}
	
	.wrapper .sidebar ul li a:hover .icon,
	.wrapper .sidebar ul li a.active .icon{
	    color: #0c7db1;
	}
	
	.wrapper .sidebar ul li a:hover:before,
	.wrapper .sidebar ul li a.active:before{
	    display: block;
	}
	
	.wrapper .sidebar ul li a{
		border:none !important;
	}
	.sidebar a{
		border:none;
	}
	.navbar{
		margin-left: 225px !important;
	}
	
</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script>

	$(function() {
		//fn_studylist();
		fn_zzimlist();
	

		// html dom 이 다 로딩된 후 실행된다.
	    $(document).ready(function(){
	        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
	        $(".menu>a").click(function(){
	            var submenu = $(this).next("ul");
	 
	            // submenu 가 화면상에 보일때는 위로 접고 아니면 아래로 펼치기
	            if( submenu.is(":visible") ){
	                submenu.slideUp();
	            } else{
	                submenu.slideDown();
	            }
	        });
	    });
        
        /* 스터디 목록 */
		$('#studylist').click(function(){
    		$('#body_list').empty();
    		fn_studylist();
    	});
		
		/* 찜 목록 */
		$('#zzimlist').click(function(){
    		$('#body_list').empty();
    		fn_zzimlist();
    	});
        
        /* 채팅 목록 */
    	$('#chatlist').click(function(){
    		$('#body_list').empty();
    		fn_chatlist();
    	});
        
    });
	
	
	var page = 1;

	function fn_studylist() {
		$.ajax({
			type: 'get',
			url: '/user/mypage/studylist/page' + page,
			dataType: 'json',
			success: function(resData) {
				$('#head_list').empty();
				$('#body_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + 'No' + '</th>';
				tr += '<th scope="col">' + '작성자' + '</th>';
				tr += '<th scope="col">' + '제목' + '</th>';
				tr += '<th scope="col">' + '개발언어' + '</th>';
				tr += '<th scope="col">' + '시작예정일' + '</th>';
				tr += '<th scope="col">' + '조회수' + '</th>';
				tr += '<th scope="col" class="btn_studyRemove"><input type="button" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				
				if(resData.studylist == '') {
					var tr = '<tr>';
					tr += '<td colspan="7" style="text-align: center;">게시물이 없습니다.</td>';
					$('#body_list').append(tr);
				}
				$.each(resData.studylist, function(i, study) {
						var tr = '<tr>';
						tr += '<td>' + study.rowNum + '</td>';
						tr += '<td>' + study.nickname  + '</td>';
						tr += '<td><a href="/study/detail?studNo=' + study.studNo + '">' + study.title  + '</a></td>';
						tr += '<td>' + study.lang + '</td>'; 
						tr += '<td>' + study.studDate + '</td>'; 
						tr += '<td>' + study.hit + '</td>'; 
						tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + study.studNo + '"</td>';
						tr += '</tr>';
						$('#body_list').append(tr);
				});
			}
		});
	}
	
	function fn_zzimlist() {
		$.ajax({
			type: 'get',
			url: '/user/mypage/zzimlist/page' + page,
			dataType: 'json',
			success: function(resData) {
				$('#head_list').empty();
				$('#body_list').empty();
				
				var tr = '<tr>';
				tr += '<th scope="col">' + 'No' + '</th>';
				tr += '<th scope="col">' + '작성자' + '</th>';
				tr += '<th scope="col">' + '제목' + '</th>';
				tr += '<th scope="col">' + '개발언어' + '</th>';
				tr += '<th scope="col">' + '시작예정일' + '</th>';
				tr += '<th scope="col">' + '조회수' + '</th>';
				tr += '<th scope="col" class="btn_zzimRemove"><input type="button" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				
				if(resData.zzimlist == '') {
					var tr = '<tr>';
					tr += '<td colspan="7" style="text-align: center;">게시물이 없다.</td>';
					$('#body_list').append(tr);
				}
				$.each(resData.zzimlist, function(i, zzim) {
					var tr = '<tr>';
					tr += '<td>' + zzim.rowNum + '</td>';
					tr += '<td>' + zzim.studyZzimDTO.nickname  + '</td>';
					tr += '<td><a href="/zzim/detail?studNo=' + zzim.StudyZzimDTO.studNo + '">' + zzim.title  + '</a></td>';
					tr += '<td>' + zzim.lang + '</td>';
					tr += '<td>' + zzim.studDate + '</td>'; 
					tr += '<td>' + zzim.hit + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + zzim.studNo + '"</td>';
					tr += '</tr>';
					$('#body_list').append(tr);
				});
			}
		});
	}
	
	function fn_chatlist(){
		$.ajax({
			type: 'get',
			url : '/chat/rooms',
			dataType: 'json',
			success: function(resData) {
				console.log(resData);
				$('#head_list').empty();
				$('#body_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + '순번' + '</th>';
				tr += '<th scope="col">' + '채팅방' + '</th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				if(resData == '') {
					var tr = '<tr>';
					tr += '<td colspan="7" style="text-align: center;">게시물이 없습니다.</td>';
					$('#body_list').append(tr);
				} else {
					$.each(resData, function(i, list) {
						var tr = '<tr>';
						tr += '<td>' + list.roomId + '</td>';
						tr += '<td>' + list.name  + '</td>';
						tr += '</tr>';
						$('#body_list').append(tr);
					});
				}
			}
		});
	}
	
</script>

</head>
<body>


	<div class="wrapper">
		<div class="sidebar">
			<ul>
				<li class="menu">
					<a>My 스터디</a>
					<ul class="hide">					
						<li><a id="studylist" href="#"> - My 스터디 목록</a></li>
						<li><a id="zzimlist" href="#">- 찜 스터디 목록</a></li>
						<li><a id="chatlist" href="javascript:void(0);">- 채팅 목록</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<div style="margin-left:225px;">	
		<div>
		</div>
		<table class="table">
			<thead id="head_list"></thead>	
			<tbody id="body_list"></tbody>
			<tfoot>
				<tr>
					<td colspan="7">
						<div id="paging"></div>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>