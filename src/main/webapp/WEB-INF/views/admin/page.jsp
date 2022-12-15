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
		fn_userList();
		fn_remove(); 
		
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
		
		$('.report_list').click(function(){
			$('#user_list').empty();
			fn_reportList();
		});
		
	});
	
	var page = 1;
	
	function fn_userList(){
		$.ajax({
			type : 'get',
			url : '${contextPath}/users/page' + page,
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
				tr += '<th scope="col">' + '회원상태' + '</th>';
				tr += '<th scope="col"><input type="checkbox" id="chk_all"></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.userList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.rowNum + '</td>';
					tr += '<td class="user_id"><a href="${contextPath}/userInfo/detail?userNo=' + user.userNo + '">' + user.id + '</a></td>';
					tr += '<td>' + user.name + '</td>';
					tr += '<td>' + user.nickname + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td class="join_date">' + user.joinDate + '</td>'; 
					tr += '<td>' + (user.userState == 1 ? '일반회원' : '제재회원') + '</td>';
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
	

	
</script>

<body>
	<h1>유저 리스트</h1>
	<ul>
	  <li><a class="home" href="#">홈</a></li>
	  <li><a class="user_list" href="#">일반유저</a></li>
	  <li><a class="report_list" href="#">신고된 회원</a></li>
	  <li><a href="#">게시판관리</a></li>
	</ul>


	
	<input type="button" value="선택삭제" id="btn_remove">
	<table class="table">
		<thead id="head_list">
<!-- 				<tr>
					<th scope="col">#</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">닉네임</th>
					<th scope="col">성별</th>
					<th scope="col">가입일</th>
					<th scope="col">유저상태</th>
					<th scope="col"><input type="checkbox" id="chk_all"></th>		
				</tr> -->		
		</thead>
		<tbody id="user_list"></tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					<div id="paging"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	

</body>

</html>