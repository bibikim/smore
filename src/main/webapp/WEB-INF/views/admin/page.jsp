<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<style>

.menu a{cursor:pointer;}
.menu .hide{display:none;}

input#btn_remove{
	display: none;
}
input#btn_trans{
	display: none;
}

.wrapper .sidebar{
    background: #8AE587;
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
<script>
	$(function(){
		fn_AlluserList();
	//	fn_remove(); 
		fn_searchList();
		fn_changePage();
	//	fn_trans();
		fn_CodeList();
		
	    // html dom 이 다 로딩된 후 실행된다.
	    $(document).ready(function(){
	        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
	        $(".menu>a").click(function(){
	            var submenu = $(this).next("ul");
	 
	            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
	            if( submenu.is(":visible") ){
	                submenu.slideUp();
	            }else{
	                submenu.slideDown();
	            }
	        });
	    });
		
		// 검색창 
		$('#area1, #area2').css('display', 'none');
		$('#column').change(function(){
			let combo = $(this);
			if(combo.val() == ''){
				$('#area1, #area2').css('display', 'none');
			} else if(combo.val() == 'JOIN_DATE'){
				$('#area1').css('display', 'none');
				$('#area2').css('display', 'inline');
			} else {
				$('#area1').css('display', 'inline');
				$('#area2').css('display', 'none');
			}
		});
				
		/* 체크박스 */
		$(document).on('click','#chk_all',function(){
		    if($('#chk_all').is(':checked')){
		       $('.del-chk').prop('checked',true);
		    }else{
		       $('.del-chk').prop('checked',false);
		    }
		});
		
		$(document).on('click','.del-chk',function(){
		    if($('input[class=del-chk]:checked').length==$('.del-chk').length){
		        $('#chk_all').prop('checked',true);
		    }else{
		       $('#chk_all').prop('checked',false);
		    }
		});
		/* 일반유저 */	
		$('.user_list').click(function(){
			$('#user_list').empty();
			fn_userList();
		});
		/* 신고된회원 */
		$('.report_list').click(function(){
			$('#user_list').empty();
			fn_reportList();
		});
		// 휴면 회원
		$('.sleepUser_list').click(function(){
			$('#user_list').empty();
			fn_sleepUserList();
		});
		
		// 자유게시판
		$('.freeBoard_list').click(function(){
			$('#user_list').empty();
			fn_FreeBoardList();
		});
		// 스터디 게시판
		$('.StudyBoard_list').click(function(){
			$('#user_list').empty();
			fn_StudyList();
		});
		// 코드 게시판
		$('.CodeBoard_list').click(function(){
			$('#user_list').empty();
			fn_CodeList();
		});
		// Qna 게시판
		$('.Qna_List').click(function(){
			$('#user_list').empty();
			fn_QnaList();
		});
		

		
	});
	
	var page = 1;
	
	function fn_AlluserList(){
		$.ajax({
			type : 'get',
			url : '/users/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				 var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + 'ID' + '</th>';
				tr += '<th scope="col">' + '이름' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '성별' + '</th>';
				tr += '<th scope="col">' + '가입일' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '정보변경일' + '</th>';
				tr += '<th scope="col">' + '회원상태' + '</th>';
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.allUserList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td>' + user.userDTO.id  + '</td>';
					tr += '<td>' + user.userDTO.name + '</td>';
					tr += '<td>' + user.userDTO.nickname + '</td>';
					tr += '<td>' + (user.userDTO.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.userDTO.joinDate + '</td>'; 
					tr += '<td>' + user.userDTO.accessLogDTO.lastLoginDate + '</td>'; 
					tr += '<td>' + user.userDTO.infoModifyDate + '</td>'; 
					/*  tr += '<td>' + (user.userDTO.userState == 1 ? '일반회원' : '휴면회원') + '</td>';  */
					tr += '<td>' + (user.userDTO.userState == 1 ? '일반회원' : (user.userDTO.userState == 0 ? '제재회원' : '휴면회원')) + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging += '<span class="lnk_enable" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="lnk_enable" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging += '<span class="lnk_enable" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging += '</div>';
				// 페이징 표시
				$('#paging').append(paging);								
			}
		});
		
	}
	
	function fn_changePage(){
		$(document).on('click', '.lnk_enable', function(){
			page = $(this).data('page');
			fn_AlluserList();
		});
	}
	
	
	function fn_userList(){
		$.ajax({
			type : 'get',
			url : '/users/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + 'ID' + '</th>';
				tr += '<th scope="col">' + '이름' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '성별' + '</th>';
				tr += '<th scope="col">' + '가입일' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '정보변경일' + '</th>';
				tr += '<th scope="col">' + '회원상태' + '</th>';
				/* tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>'; */				
				tr += '<th scope="col" class="btn_remove_label"><input type="button" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.userList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td>' + user.id  + '</td>';
					tr += '<td>' + user.name + '</td>';
					tr += '<td>' + user.nickname + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>'; 
					tr += '<td>' + user.lastLoginDate + '</td>'; 
					tr += '<td>' + user.infoModifyDate + '</td>'; 
					/* tr += '<td>' + (user.userState == 1 ? '일반회원' : '휴면회원') + '</td>'; */
					tr += '<td>' + (user.userState == 1 ? '일반회원' : (user.userState == 0 ? '제재회원' : '휴면회원')) + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
		});
		
	}
	
	
	function fn_sleepUserList(){
		$.ajax({
			type : 'get',
			url : '/sleepUsers/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				 var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + 'ID' + '</th>';
				tr += '<th scope="col">' + '이름' + '</th>';
				tr += '<th scope="col">' + '성별' + '</th>';
				tr += '<th scope="col">' + '가입일' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '휴면전환일' + '</th>';
				tr += '<th scope="col" class="btn_trans_label"><input type="button" id="btn_trans"><label for="btn_trans"><i class="fa-solid fa-user-group"></i></label></th>';
				tr += '</tr>';				
				$('#head_list').append(tr); 
				$.each(resData.sleepUserList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td>' + user.id  + '</td>';
					tr += '<td>' + user.name  + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>'; 
					tr += '<td>' + user.lastLoginDate + '</td>'; 
					tr += '<td>' + user.sleepDate + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="trans-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
		});
		
	}
	
	
  	function fn_reportList(){
		$.ajax({
			type : 'get',
			url : '${contextPath}/reportUsers/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + '신고번호' + '</th>';
				tr += '<th scope="col">' + '신고자ID' + '</th>';
				tr += '<th scope="col">' + '신고사유' + '</th>';
				tr += '<th scope="col">' + '신고일자' + '</th>';
				tr += '<th scope="col">' + '신고위치' + '</th>';
				tr += '<th scope="col">' + '번호' + '</th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				$('#user_list').empty();
				$.each(resData.reportUserList, function(i, user){			
					var tr = '<tr>';
					tr += '<td>' + user.rNo + '</td>';
					tr += '<td>' + user.id + '</td>';
					tr += '<td>' + user.rContent + '</td>';
					tr += '<td>' + user.rDate + '</td>';
					tr += '<td>' + (user.rGubun == 1 ? '스터디게시판' : '댓글') + '</td>';
 					tr += '<td>' + user.rTarget + '</td>'; 
 					tr += '</tr>';
 					$('#user_list').append(tr);
				});
			}
		});
		
	}  
	
//  	function fn_trans(){ // 다중 일반전환
	$(document).on('click','.btn_trans_label',function(){	
  		$('#btn_trans').click(function(){
  			if(confirm('선택한 회원을 일반회원으로 전환할까요?')){
				let userNoList = '';
				for(let i = 0; i < $('.trans-chk').length; i++){
					if( $($('.trans-chk')[i]).is(':checked')){
						userNoList += $($('.trans-chk')[i]).val() + ',';
					}
				} 				
  				userNoList = userNoList.substr(0, userNoList.length -1);
  				console.log(userNoList);
				$.ajax({
					type :'delete',
					url : '/common/' + userNoList,
					dataType : 'json',
					success : function(resData){
  						if(resData.deleteSleep > 0){
  							alert('선택한 유저가 일반회원으로 전환되었습니다.');
  							 fn_sleepUserList();
  						}  else{
							alert('선택된 회원이 전환되지 않았습니다.');
						}
					}
				});
  			}
  		});
	});	
//  	}
  		
  		// 일반회원 다중탈퇴
		$(document).on('click','.btn_remove_label',function(){			
			if(confirm('선택한 회원을 탈퇴시킬까요?')){						
				let userNoList = '';
				for(let i = 0; i < $('.del-chk').length; i++){				
					if( $($('.del-chk')[i]).is(':checked')){
						userNoList += $($('.del-chk')[i]).val() + ',';
						/* user의 id joindate가져와야함 */
					}
				}
				userNoList = userNoList.substr(0, userNoList.length -1);
				$.ajax({
					type :'delete',
					url : '/users/' + userNoList,
					dataType : 'json',
					success : function(resData){
						if(resData.deleteResult > 0){
							alert('선택된 유저가 탈퇴 되었습니다.');
							fn_userList();
						} else{
							alert('선택된 회원이 탈퇴되지 않았습니다.');
						}
					}
				});
			}
		});

	
	function fn_FreeBoardList(){
		$.ajax({
			type : 'get',
			url : '/freeBoardList/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				 var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '제목' + '</th>';
				tr += '<th scope="col">' + '작성일' + '</th>';
				tr += '<th scope="col">' + '수정일' + '</th>';
				tr += '<th scope="col">' + '조회수' + '</th>';
				tr += '<th scope="col">' + '작성자 IP' + '</th>';
				/* tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>'; */
				tr += '<th scope="col" class="btn_remove_label"><input type="button" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.freeBoardList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.rowNum + '</td>';
					tr += '<td>' +   board.nickname  + '</td>'; 
					tr += '<td><a href="free/detail?freeNo=' + board.freeNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.fNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
		});		
	}

	function fn_StudyList(){
		$.ajax({
			type : 'get',
			url : '/studyList/page' + page,
			dataType : 'json',
			success : function(resData){
				console.log('받음');
				$('#head_list').empty();
				$('#user_list').empty();
				 var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + '모임장' + '</th>';
				tr += '<th scope="col">' + '스터디이름' + '</th>';
				tr += '<th scope="col">' + '스터디생성일' + '</th>';
				tr += '<th scope="col">' + '공부언어' + '</th>';
				tr += '<th scope="col">' + '지역' + '</th>';
				tr += '<th scope="col">' + '작성자 IP' + '</th>';
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.studyList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.rowNum + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="free/detail?freeNo=' + board.freeNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.lang + '</td>'; 
					tr += '<td>' + board.region + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.fNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging += '<span class="lnk_enable" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="lnk_enable" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging += '<span class="lnk_enable" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging += '</div>';
				// 페이징 표시
				$('#paging').append(paging);	
			}
		});		
	}
	
	function fn_CodeList(){
		$.ajax({
			type : 'get',
			url : '/codeList/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '제목' + '</th>';
				tr += '<th scope="col">' + '작성일' + '</th>';
				tr += '<th scope="col">' + '수정일' + '</th>';
				tr += '<th scope="col">' + '조회수' + '</th>';
				tr += '<th scope="col">' + '작성자 IP' + '</th>';
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.codeList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.rowNum + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="free/detail?coNo=' + board.coNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.coNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
		});
	}
	
	function fn_QnaList(){
		$.ajax({
			type : 'get',
			url : '/qnaList/page' + page,
			dataType : 'json',
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '제목' + '</th>';
				tr += '<th scope="col">' + '작성일' + '</th>';
				tr += '<th scope="col">' + '수정일' + '</th>';
				tr += '<th scope="col">' + '조회수' + '</th>';
				tr += '<th scope="col">' + '작성자 IP' + '</th>';
				tr += '<th scope="col">' + '답변여부' + '</th>';
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.qnaList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.rowNum + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="free/detail?qaNo=' + board.qaNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>';
					tr += '<td>' + (board.answer == 1 ? '답변완료' : '답변대기중') + '</td>';
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.coNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
		});
	}
	
	
	function fn_searchList(){
		$('#btn_search').click(function(){
			console.log('요청');
			$.ajax({
				type : 'get',
				url : '/users/search',
				data : $('#frm_search').serialize(),
				dataType : 'json',
				success : function(resData){
					console.log('요청완');
					$('#user_list').empty();
					if(resData.status == 200){
						$.each(resData.users, function(i, user){
							$('<tr>')
							.append( $('<td>').text(user.rowNum))
							.append( $('<td>').text(user.userDTO.id))
							.append( $('<td>').text(user.userDTO.name))
							.append( $('<td>').text(user.userDTO.nickname))
							.append( $('<td>').text(user.userDTO.gender))
							.append( $('<td>').text(user.userDTO.joinDate))
							.append( $('<td>').text(user.userDTO.accessLogDTO.lastLoginDate))
							.append( $('<td>').text(user.userDTO.infoModifyDate))
							.append( $('<td>').text(user.userDTO.userState))
							.appendTo('#user_list');
						});
					} else if(resData.status == 500){
						alert('검색결과가 없습니다.');	
					}
				}
			});
		});		
	}	
	
</script>

<body>
 <!-- 	<ul>
	  <li><a class="home" href="#">홈</a></li>
	  <li><a class="user_list" href="#">일반유저</a></li>
	  <li><a class="sleepUser_list" href="#">휴면유저</a></li>
	  <li><a class="report_list" href="#">신고된 회원</a></li>
	  <li><a class="freeBoard_list" href="#">자유게시판</a></li>
	  <li><a class="StudyBoard_list" href="#">스터디게시판</a></li>
	  <li><a class="CodeBoard_list" href="#">코드게시판</a></li>
	  <li><a class="Qna_List" href="#">Qna</a></li>
	</ul> -->
	
	<div class="wrapper" >
        <div class="sidebar" >
           <ul>	    
		        <li class="menu">
		            <a>유저관리</a>
		            <ul class="hide">
		                <li><a class="user_list" href="#"> - 일반유저</a></li>
		                <li><a class="sleepUser_list" href="#"> - 휴면유저</a></li>
		                <li><a class="report_list" href="#"> - 신고된 회원</a></li>
		            </ul>
		        </li>
		 
		        <li class="menu">
		            <a>게시판관리</a>
		            <ul class="hide">
		                <li><a class="freeBoard_list" href="#"> - 자유게시판</a></li>
		                <li><a class="StudyBoard_list" href="#"> - 스터디게시판</a></li>
		                <li><a class="CodeBoard_list" href="#"> - 코드게시판</a></li>
		                <li><a class="Qna_List" href="#"> - Qna</a></li>
		            </ul>
		        </li>                   
            </ul>
        </div>
     </div>

	<form id="frm_search" action="/users/search" >
		<div style="float: right;">
			<select id="state" name="state" class="select">
				<option value="">전체</option>
				<option value="active">정상회원</option>
				<option value="sleep">휴면회원</option>
			</select>		
			<select id="column" name="column">
				<option value="">:::선택:::</option>
				<option value="ID">ID</option>
				<option value="JOIN_DATE">가입일</option>
			</select>
	
		<span id="area1">
			<input type="text" id="query" name="query">
		</span>
		<span id="area2">
			<input type="text" id="start" name="start">
			~
			<input type="text" id="stop" name="stop">
		</span>
		<span>
			<input type="button" id ="btn_search"  value="검색">
			<input type="button" value="전체유저조회" id="btn_all">			
			<script>
				$('#btn_all').click(function(){
					fn_AlluserList();
				});				
			</script>
		</span>
		</div>	
	</form>



	<div  style="margin-left:225px;">	
		<div>
			<!-- <input type="button" value="휴면전환" id="btn_trans"> -->
			<!-- <input type="button" value="선택삭제" id="btn_remove"> -->
		</div>
		<table class="table">
			<thead id="head_list"></thead>	
			<tbody id="user_list"></tbody>
			<tfoot>
				<tr>
					<td colspan="10">
						<div id="paging"></div>
						
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>