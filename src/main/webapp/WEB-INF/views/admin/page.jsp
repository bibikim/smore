<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<style>
</style>
<script>
	$(function(){
		fn_AlluserList();
		fn_remove(); 
		fn_searchList();
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
					tr += '<td>' + (user.userState == 1 ? '일반회원' : '휴면회원') + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				$.each(resData.sleepList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td>' + user.id  + '</td>';
					tr += '<td>' + user.name + '</td>';
					tr += '<td>' + user.nickname + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>'; 
					tr += '<td>' + user.lastLoginDate + '</td>'; 
					tr += '<td>' + user.infoModifyDate + '</td>'; 
					tr += '<td>' + (user.userState == 1 ? '일반회원' : '휴면회원') + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
			}
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
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
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
					tr += '<td>' + (user.userState == 1 ? '일반회원' : '휴면회원') + '</td>';
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
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.sleepuserList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td>' + user.id  + '</td>';
					tr += '<td>' + user.name  + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>'; 
					tr += '<td>' + user.lastLoginDate + '</td>'; 
					tr += '<td>' + user.sleepDate + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
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
	
	function fn_remove(){
		$('#btn_remove').click(function(){
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
					url : '${contextPath}/users/' + userNoList,
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
	}
	
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
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
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
					/* tr += '<td>' + board.title  + '</td>'; */
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.lang + '</td>'; 
					tr += '<td>' + board.region + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.fNo + '"</td>';
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
 	<ul>
	  <li><a class="home" href="#">홈</a></li>
	  <li><a class="user_list" href="#">일반유저</a></li>
	  <li><a class="sleepUser_list" href="#">휴면유저</a></li>
	  <li><a class="report_list" href="#">신고된 회원</a></li>
	  <li><a class="freeBoard_list" href="#">자유게시판</a></li>
	  <li><a class="StudyBoard_list" href="#">스터디게시판</a></li>
	</ul>
	
	<form id="frm_search" action="/users/search" >
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
	</form>



	<div>
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
		<input type="button" value="선택삭제" id="btn_remove">	
	</div>
</body>
</html>