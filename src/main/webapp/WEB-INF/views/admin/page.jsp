<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<link rel="stylesheet" href="/resources/css/admin/admin.css">

<script src="/resources/js/admin/admin.js"></script>
<title>Smore</title>


<body>	
	<div class="wrapper" >
        <div class="sidebar" >
           <ul>
	           <div style="text-align: center;">	    
		           <a href="/admin/page" style="text-decoration-line: none ;"><img alt="" src="/resources/images/admin2.png" width="70px" style="text-align: center;"> <li style="font-style: oblique; font-size: 20px; color: #dee4ec;">Admin</li></a>
		          
	           </div>
       		<hr>
		        <li class="menu">
		            <a class="user"><i class="fa-regular fa-user" style="margin-bottom: 12px;"></i>&nbsp; 유저관리</a>
		            <ul class="hide">
		                <li><a class="user_list" href="#" style="font-size: 14px;"> - 일반유저</a></li>
		                <li><a class="sleepUser_list" href="#" style="font-size: 14px;"> - 휴면유저</a></li>
<!-- 		                <li><a class="report_list" href="#"> - 신고된 회원</a></li>
		                <li><a class="" href="#"> - 제재된 회원</a></li> -->
		            </ul>
		        </li>
		 
		        <li class="menu">
		            <a class="board"><i class="fa-solid fa-bars" style="margin-bottom: 12px;"></i>&nbsp;게시판관리</a>
		            <ul class="hide">
		                <li><a class="freeBoard_list" href="#" style="font-size: 14px;"> - 자유게시판</a></li>
		                <li><a class="StudyBoard_list" href="#" style="font-size: 14px;"> - 스터디게시판</a></li>
		                <li><a class="CodeBoard_list" href="#" style="font-size: 14px;"> - 코드게시판</a></li>
		                <li><a class="Qna_List" href="#" style="font-size: 14px;"> - Qna</a></li>
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
			<tbody id="user_list"></tbody>
			<tfoot>
				<tr>
					<td colspan="10">
						<div id="paging"></div>					
						<div style="text-align: center;">    
						<div id="form1">
							<form id="frm_searchUser">
								<div>
									<select id="column" name="column">
										<option value="">:::선택:::</option>
										<option value="ID">ID</option>
										<option value="NICKNAME">닉네임</option>
										<option value="JOIN_DATE">가입일</option>
									</select>
									<span id="area1">
										<input type="text" id="query" name="query" placeholder="아이디/닉네임 입력">
									</span>
									<span id="area2">
										<input type="text" name="start" id="start" placeholder="시작일자">
										~
										<input type="text" name="stop" id="stop" placeholder="마지막일자">
									</span>
									
									<span>
										<input type="button" id ="btn_userSearch"  value="검색" class="btn_search">
									</span>
								</div>	
							</form>
						</div>
						
						<div id="form2">
							<form id="frm_searchboard">
								<select id="board" name="board">
									<option value="">전체</option>
									<option value="FREE">자유게시판</option>
									<option value="STUDY">스터디게시판</option>
									<option value="CODE">코드게시판</option>
									<option value="QNA">QNA</option>
								</select>
								<select id="column2" name="column2">
									<option value="">:::선택:::</option>
									<option value="NICKNAME">작성자</option>
									<option value="TITLE">제목</option>
									<option value="CREATE_DATE">작성일자</option>
								</select>
								<span id="area4">
									<input type="text" id="query2" name="query2" placeholder="작성자/제목 입력">
								</span>
								<span id="area5">
									<input type="text" id="start2" name="start2" >
									~
									<input type="text" id="stop2" name="stop2" >
								</span>
								<span>
									<input type="button" value="검색" id="btn_searchBoard" class="btn_search">
								</span>
							</form>
						</div>	
					   </div>
					   
					   	<script>
							function fn_inputShow(){
								$('#area5').hide();
								
								$('#area4').css('display', 'none');
								$('#column2').change(function(){
									$('.input').val('');
									let combo = $(this);
									if(combo.val() == 'CREATE_DATE'){
										$('#area4').hide();
										$('#area5').show();
									} else {
										$('#area4').show();
										$('#area5').hide();
									}
								});
							};
						</script>
					   						
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</body>
</html>