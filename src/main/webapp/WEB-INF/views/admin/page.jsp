<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<style>
        .side-menu {
            top: 50px;
            width: 45px;
            z-index: 10;
            background: #ff5858;
            border-right: 1px solid rgba(0, 0, 0, 0.07);
            bottom: 50px;
            height: 100%;
            margin-bottom: -70px;
            margin-top: 0px;
            padding-bottom: 70px;
            position: fixed;
            box-shadow: 0 0px 24px 0 rgb(0 0 0 / 6%), 0 1px 0px 0 rgb(0 0 0 / 2%);
        }

        .sidebar-inner {
            height: 100%;
            padding-top: 30px;
        }

        #sidebar-menu,
        #sidebar-menu ul,
        #sidebar-menu li,
        #sidebar-menu a {
            border: 0;
            font-weight: normal;
            line-height: 1;
            list-style: none;
            margin: 0;
            padding: 0;
            position: relative;
            text-decoration: none;
        }

        #sidebar-menu>ul>li a {
            color: #fff;
            font-size: 20px;
            display: block;
            padding: 14px 0px;
            margin: 0px 0px 0px 8px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            width: 28px;
            cursor: pointer;
        }

        #sidebar-menu .fas {
            padding-left: 6px;
        }

        /* 사이드 메뉴 */
        input[type="search"] {
            width: 180px;
            margin: 0 auto;
            margin-left: 9px;
            border: 2px solid #797979;
            font-size: 14px;
            margin-top: 10px;
            padding: 4px 0 4px 14px;
            border-radius: 50px;
        }

        .left_sub_menu {
            position: fixed;
            top: 50px;
            width: 200px;
            z-index: 10;
            left: 45px;
            background: white;
            border-right: 1px solid rgba(0, 0, 0, 0.07);
            bottom: 50px;
            height: 100%;
            margin-bottom: -70px;
            margin-top: 0px;
            padding-bottom: 0px;
            box-shadow: 0 0px 24px 0 rgb(0 0 0 / 6%), 0 1px 0px 0 rgb(0 0 0 / 2%);
            color: black;
        }

        .sub_menu {
            margin-top: 50px;
        }

        .left_sub_menu>.sub_menu li:hover {
            color: ff5858;
            background-color: #e1e1e1;
        }

        .left_sub_menu>.sub_menu li {
            color: #333;
            font-size: 17px;
            font-weight: 600;
            padding: 20px 0px 8px 14px;
            border-bottom: 1px solid #e1e1e1;
        }

        .sub_menu>h2 {
            padding-bottom: 4px;
            border-bottom: 3px solid #797979;
            margin-top: 30px;
            font-size: 21px;
            font-weight: 600;
            color: #333;
            margin-left: 10px;
            margin-right: 10px;
            font-family: 'NotoKrB';
            line-height: 35px;
        }

        .sub_menu .fas {
            color: #ff5858;
            font-size: 20px;
            line-height: 20px;
            float: right;
            margin-right: 20px;
        }

        .sub_menu>.big_menu>.small_menu li {
            color: #333;
            font-size: 14px;
            font-weight: 600;
            border-bottom: 0px solid #e1e1e1;
            margin-left: 14px;
            padding-top: 8px;
        }

        .big_menu {
            cursor: pointer;
        }

        ul {
            padding-inline-start: 0px;
        }

        a {
            color: #797979;
            text-decoration: none;
            background-color: transparent;
        }

        ul {
            list-style: none;
        }

        ol,
        ul {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .has_sub {
            width: 100%;
        }

        .overlay {
            position: fixed;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
        }

        .hide_sidemenu {
            display: none;
        }


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
					tr += '<td>' + (user.userState == 1 ? '일반회원' : '제재회원') + '</td>';
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
			url : '${contextPath}/sleepUsers/page' + page,
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
	

	
</script>

<body>
	<h1>유저 리스트</h1>
<!-- 	<ul>
	  <li><a class="home" href="#">홈</a></li>
	  <li><a class="user_list" href="#">일반유저</a></li>
	  <li><a class="sleepUser_list" href="#">휴면유저</a></li>
	  <li><a class="report_list" href="#">신고된 회원</a></li>
	  <li><a href="#">게시판관리</a></li>
	</ul> -->
	
	  <div id="wrapper">
        <div class="topbar" style="position: absolute; top:0;">
            <!-- 왼쪽 메뉴 -->
            <div class="left side-menu">
                <div class="sidebar-inner">
                    <div id="sidebar-menu">
                        <ul>
                            <li class="has_sub"><a href="javascript:void(0);" class="waves-effect">
                                <i class="fas fa-bars"></i>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 왼쪽 서브 메뉴 -->
            <div class="left_sub_menu">
                <div class="sub_menu">
                    <input type="search" name="SEARCH" placeholder="SEARCH">
                    <h2>TITLE</h2>
                    <ul class="big_menu">
                        <li>MENU 1 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="#">소메뉴1-1</a></li>
                            <li><a href="#">소메뉴1-2</a></li>
                            <li><a href="">소메뉴1-3</a></li>
                            <li><a href="#">소메뉴1-4</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li>MENU 2 <i class="arrow fas fa-angle-right"></i></li>
                        <ul class="small_menu">
                            <li><a href="#">소메뉴2-1</a></li>
                            <li><a href="#"></a>소메뉴2-2</a></li>
                        </ul>
                    </ul>
                    <ul class="big_menu">
                        <li>MYPAGE</li>
                    </ul>
                </div>
            </div>
            <div class="overlay"></div>
        </div>

	

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
				<td colspan="10">
					<div id="paging"></div>
				</td>
			</tr>
		</tfoot>
	</table>
	

</body>

</html>