	$(function(){
 		fn_AlluserList();
		fn_changePage(); 
    	fn_changePage2();
    	fn_changePage3();
    	fn_changePage4();
    	fn_changePage5();
    	fn_changePage6();
    	fn_changePage7();
    	fn_changePage8();
		fn_searchUserList(); 
    	fn_searchBoardList();
    	fn_inputShow();	
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
		
	    
    	$('#form1').show();
    	$('#form2').hide();	
	    
	    $('.board, .freeBoard_list, .StudyBoard_list, .CodeBoard_list, .Qna_List').click(function(){	    	
	    	$('#form1').hide();
	    	$('#form2').show();	    	
	    });
	    	    
	    
	    $('.user, .user_list, .sleepUser_list, .report_list').click(function(){	    	
	    	$('#form2').hide();
	    	$('#form1').show();	    	
	    });
	    	    
		// 유저 검색창 
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
			$('#paging').empty();
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
				tr += '<th scope="col">' + '가입방법' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '정보변경일' + '</th>';
				tr += '<th scope="col">' + '회원상태' + '</th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.allUserList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.userDTO.userNo
					+ '</td>';
					if(user.userDTO.snsType !=null){
						tr += '<td>네이버회원</td>';
					} else{
						tr += '<td>' + user.userDTO.id  + '</td>';
					}					
					tr += '<td>' + user.userDTO.name + '</td>';
					tr += '<td>' + user.userDTO.nickname + '</td>';
					tr += '<td>' + (user.userDTO.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.userDTO.joinDate + '</td>';
					tr += '<td>' + (user.userDTO.snsType == 'naver' ? '네이버가입자' : 'Smore가입자') + '</td>';
					tr += '<td>' + (user.userDTO.accessLogDTO.lastLoginDate == null ? '' : user.userDTO.accessLogDTO.lastLoginDate) + '</td>'; 
					tr += '<td>' + (user.userDTO.infoModifyDate == null ? '' : user.userDTO.infoModifyDate) + '</td>'; 
					tr += '<td>' + (user.userDTO.userState == 1 ? '일반회원' : (user.userDTO.userState == 0 ? '제재회원' : '휴면회원')) + '</td>';
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
			url : '/commomUsers/page' + page,
			dataType : 'json',			
			success : function(resData){
				$('#head_list').empty();
				$('#user_list').empty();
				// 페이징
				var tr = '<tr>';
				tr += '<th scope="col">' + '#' + '</th>';
				tr += '<th scope="col">' + 'ID' + '</th>';
				tr += '<th scope="col">' + '이름' + '</th>';
				tr += '<th scope="col">' + '닉네임' + '</th>';
				tr += '<th scope="col">' + '성별' + '</th>';
				tr += '<th scope="col">' + '가입일' + '</th>';
				tr += '<th scope="col">' + '가입방법' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '정보변경일' + '</th>';
				tr += '<th scope="col">' + '회원상태' + '</th>';
				tr += '<th scope="col" class="btn_userRemove"><input type="hidden" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';				
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.userList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.userNo + '</td>';
					if(user.snsType !=null){
						tr += '<td>네이버회원</td>';
					} else{
						tr += '<td>' + user.id  + '</td>';
					}	
					tr += '<td>' + user.name + '</td>';
					tr += '<td>' + user.nickname + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>'; 
					tr += '<td>' + (user.snsType == 'naver' ? '네이버가입자' : 'Smore가입자') + '</td>';
					tr += '<td>' + (user.lastLoginDate == null ? '' : user.lastLoginDate) + '</td>'; 
					tr += '<td>' + (user.infoModifyDate == null ? '' : user.infoModifyDate) + '</td>'; 
					tr += '<td>' + (user.userState == 1 ? '일반회원' : (user.userState == 0 ? '제재회원' : '휴면회원')) + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
 				$('#paging').empty();
 				var naverPageUtil = resData.naverPageUtil;
				var paging2 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging2 += '<span class="lnk_enable2" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging2 += '<strong>' + p + '</strong>';
					} else {
						paging2 += '<span class="lnk_enable2" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging2 += '<span class="lnk_enable2" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging2 += '</div>';
				// 페이징 표시
				$('#paging').append(paging2);	  
			}
		});
		
	}
	
	function fn_changePage2(){
		$(document).on('click', '.lnk_enable2', function(){
			page = $(this).data('page');
			fn_userList();
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
				tr += '<th scope="col">' + '가입방법' + '</th>';
				tr += '<th scope="col">' + '마지막접속일' + '</th>';
				tr += '<th scope="col">' + '휴면전환일' + '</th>';
				tr += '<th scope="col" class="btn_trans"><input type="hidden" id="btn_trans"><label for="btn_trans"><i class="fa-solid fa-user-group"></i></label></th>';
				
				tr += '</tr>';				
				$('#head_list').append(tr); 
				$.each(resData.sleepUserList, function(i, user){
					var tr = '<tr>';
					tr += '<td>' + user.userNo + '</td>';
					if(user.snsType !=null){
						tr += '<td>네이버회원</td>';
					} else{
						tr += '<td>' + user.id  + '</td>';
					}
					tr += '<td>' + user.name  + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.joinDate + '</td>';
					tr += '<td>' + (user.snsType == 'naver' ? '네이버가입자' : 'smore가입자') + '</td>';
					tr += '<td>' + (user.lastLoginDate == null ? '' : user.lastLoginDate) + '</td>';  					
					tr += '<td>' + user.sleepDate + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="trans-chk" value="' + user.userNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging3 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging3 += '<span class="lnk_enable3" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging3 += '<strong>' + p + '</strong>';
					} else {
						paging3 += '<span class="lnk_enable3" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging3 += '<span class="lnk_enable3" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging3 += '</div>';
				// 페이징 표시
				$('#paging').append(paging3);	
			}
		});
		
	}
	
	function fn_changePage3(){
		$(document).on('click', '.lnk_enable3', function(){
			page = $(this).data('page');
			fn_sleepUserList();
		});
	}	
	
	
  	function fn_reportList(){
		$.ajax({
			type : 'get',
			url : '/reportUsers/page' + page,
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
	
  	// 일반회원 전환
	$(document).on('click','.btn_trans',function(){	
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
				tr += '<th scope="col" class="btn_freeRemove"><input type="hidden" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.freeBoardList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.freeNo + '</td>';
					tr += '<td>' + board.nickname  + '</td>'; 
					tr += '<td><a href="/free/detail?freeNo=' + board.freeNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.freeNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging4 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging4 += '<span class="lnk_enable4" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging4 += '<strong>' + p + '</strong>';
					} else {
						paging4 += '<span class="lnk_enable4" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging4 += '<span class="lnk_enable4" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging4 += '</div>';
				// 페이징 표시
				$('#paging').append(paging4);	
			}
		});		
	}

	function fn_changePage4(){
		$(document).on('click', '.lnk_enable4', function(){
			page = $(this).data('page');
			fn_FreeBoardList();
		});
	}
	
	function fn_StudyList(){
		$.ajax({
			type : 'get',
			url : '/studyList/page' + page,
			dataType : 'json',
			success : function(resData){
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
				tr += '<th scope="col" class="btn_studyRemove"><input type="hidden" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr); 
				$.each(resData.studyList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.studNo + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="/study/detail?studNo=' + board.studNo + '">' + board.title  + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.lang + '</td>'; 
					tr += '<td>' + board.region + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.studNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging5 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging5 += '<span class="lnk_enable5" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging5 += '<strong>' + p + '</strong>';
					} else {
						paging5 += '<span class="lnk_enable5" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging5 += '<span class="lnk_enable5" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging5 += '</div>';
				// 페이징 표시
				$('#paging').append(paging5);	
			}
		});		
	}
	
	function fn_changePage5(){
		$(document).on('click', '.lnk_enable5', function(){
			page = $(this).data('page');
			fn_StudyList();
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
				tr += '<th scope="col" class="btn_codeRemove"><input type="hidden" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.codeList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.coNo + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="/code/detail?coNo=' + board.coNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.coNo + '"</td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging6 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging6 += '<span class="lnk_enable6" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging6 += '<strong>' + p + '</strong>';
					} else {
						paging6 += '<span class="lnk_enable6" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging6 += '<span class="lnk_enable6" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging += '</div>';
				// 페이징 표시
				$('#paging').append(paging6);	
			}
		});
	}
	
	function fn_changePage6(){
		$(document).on('click', '.lnk_enable6', function(){
			page = $(this).data('page');
			fn_CodeList();
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
				tr += '<th scope="col" class="btn_qnaRemove"><input type="hidden" id="btn_remove"><label for="btn_remove"><i class="fa-solid fa-trash"></i></label></th>';
				tr += '</tr>';
				$('#head_list').append(tr);
				$.each(resData.qnaList, function(i, board){
					var tr = '<tr>';
					tr += '<td>' + board.qaNo + '</td>';
					tr += '<td>' + board.nickname  + '</td>';
					tr += '<td><a href="/qna/detail?qaNo=' + board.qaNo + '">' + board.title   + '</a></td>';
					tr += '<td>' + board.createDate + '</td>'; 
					tr += '<td>' + board.modifyDate + '</td>'; 
					tr += '<td>' + board.hit + '</td>'; 
					tr += '<td>' + board.ip + '</td>'; 
					tr += '<td>' + (board.answer == 1 ? '답변완료' : '답변대기중') + '</td>';
					tr += '<td><input type="checkbox" name="chk" class="del-chk" value="' + board.qaNo + '"></td>';
					tr += '</tr>';
					$('#user_list').append(tr);
				});
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging7 = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging7 += '<span class="lnk_enable7" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging7 += '<strong>' + p + '</strong>';
					} else {
						paging7 += '<span class="lnk_enable7" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging7 += '<span class="lnk_enable7" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging7 += '</div>';
				// 페이징 표시
				$('#paging').append(paging7);	
			}
		});
	}
			
	function fn_changePage7(){
		$(document).on('click', '.lnk_enable7', function(){
			page = $(this).data('page');
			fn_QnaList();
		});
	}
	
	
 	function fn_searchUserList(){
		$('#btn_userSearch').click(function(e){
			$.ajax({
				type : 'get',
				//url : '/users/search/page' + page,
				url : '/users/search',
				//data : $('#frm_searchUser').serialize(),	
				data: 'column=' + $('#column').val() + '&query=' + $('#query').val() + '&start=' + $('#start').val() + '&stop=' +  $('#stop').val(), 				
				dataType : 'json',
				success : function(resData){
					$('#head_list').empty();
					$('#user_list').empty();
					$('#paging').empty();
					var tr = '<tr>';
					tr += '<th scope="col">' + '#' + '</th>';
					tr += '<th scope="col">' + 'ID' + '</th>';
					tr += '<th scope="col">' + '이름' + '</th>';
					tr += '<th scope="col">' + '닉네임' + '</th>';
					tr += '<th scope="col">' + '성별' + '</th>';
					tr += '<th scope="col">' + '가입일' + '</th>';
					tr += '<th scope="col">' + '마지막접속일' + '</th>';
					tr += '<th scope="col">' + '가입방법' + '</th>';
					tr += '<th scope="col">' + '회원상태' + '</th>';
					tr += '</tr>';
					$('#head_list').append(tr); 
					if(resData.status == 200){
						$.each(resData.users, function(i, user){
 							var tr = '<tr>';
							tr += '<td>' + user.userDTO.userNo + '</td>';
							if(user.userDTO.snsType !=null){
								tr += '<td>네이버회원</td>';
							} else{
								tr += '<td>' + user.userDTO.id  + '</td>';
							}					
							tr += '<td>' + user.userDTO.name + '</td>';
							tr += '<td>' + user.userDTO.nickname + '</td>';
							tr += '<td>' + (user.userDTO.gender == 'M' ? '남자' : '여자') + '</td>';
							tr += '<td>' + user.userDTO.joinDate + '</td>';
							tr += '<td>' + (user.userDTO.snsType == 'naver' ? '네이버가입자' : 'Smore가입자') + '</td>';
							tr += '<td>' + (user.userDTO.accessLogDTO.lastLoginDate == null ? '' : user.userDTO.accessLogDTO.lastLoginDate) + '</td>'; 
							tr += '<td>' + (user.userDTO.userState == 1 ? '일반회원' : (user.userDTO.userState == 0 ? '제재회원' : '휴면회원')) + '</td>';
							tr += '</tr>';
							$('#user_list').append(tr); 
						});   
					} else if(resData.status == 500){
						alert(resData.message);
					}		
 					// 페이징
					$('#paging').empty();
					var naverPageUtil = resData.naverPageUtil;
					var paging8 = '<div>';
					// 이전 페이지
					if(page != 1) {
						paging8 += '<span class="lnk_enable8" data-page="' + (page - 1) + '">&lt;이전</span>';
					}
					// 페이지번호
					for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
						if(p == page){
							paging8 += '<strong>' + p + '</strong>';
						} else {
							paging8 += '<span class="lnk_enable8" data-page="'+ p +'">' + p + '</span>';
						}
					}
					// 다음 페이지
					if(page != naverPageUtil.totalPage){
						paging8 += '<span class="lnk_enable8" data-page="'+ (page + 1) +'">다음&gt;</span>';
					}
					paging8 += '</div>';
					// 페이징 표시
					$('#paging').append(paging8);	 
				}
			});
		});		
	}	 
		
	function fn_changePage8(){
		$(document).on('click', '.lnk_enable8', function(){
			page = $(this).data('page');
			fn_searchUserList();
		});
	}
 	
 	
	
 	function fn_searchBoardList(){
		$('#btn_searchBoard').click(function(e){
		$.ajax({
			type : 'get',
			url : '/boards/search/page' + page,
			data : $('#frm_searchboard').serialize(),
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
				tr += '</tr>';
				$('#head_list').append(tr); 
				if(resData.status == 200){
					$.each(resData.boards, function(i, board){
						if(board.freeNo != 0){
							$('<tr>')
							.append( $('<td>').text(board.freeNo))
							.append( $('<td>').text(board.nickname))
							.append( $('<td>').html('<a href="/free/detail?freeNo=' + board.freeNo + '">' + board.title   + '</a>'))
							.append( $('<td>').text(board.createDate))
							.append( $('<td>').text(board.modifyDate))
							.append( $('<td>').text(board.hit))
							.append( $('<td>').text(board.ip))
							.appendTo('#user_list');
						}
						if(board.coNo != 0){
							$('<tr>')
							.append( $('<td>').text(board.coNo))
							.append( $('<td>').text(board.nickname))
							.append( $('<td>').html('<a href="/code/detail?coNo=' + board.coNo + '">' + board.title   + '</a>'))
							.append( $('<td>').text(board.createDate))
							.append( $('<td>').text(board.modifyDate))
							.append( $('<td>').text(board.hit))
							.append( $('<td>').text(board.ip))
							.appendTo('#user_list');
						}
						if(board.qaNo != 0){
							$('<tr>')
							.append( $('<td>').text(board.qaNo))
							.append( $('<td>').text(board.nickname))
							.append( $('<td>').html('<a href="/qna/detail?qaNo=' + board.qaNo + '">' + board.title   + '</a>'))
							.append( $('<td>').text(board.createDate))
							.append( $('<td>').text(board.modifyDate))
							.append( $('<td>').text(board.hit))
							.append( $('<td>').text(board.ip))
							.append( $('<td>').text(board.answer == 1 ? '답변완료' : '답변대기중'))
							.appendTo('#user_list');
						}
						if(board.studNo != 0){
							$('<tr>')
							.append( $('<td>').text(board.studNo))
							.append( $('<td>').text(board.nickname))
							.append( $('<td>').html('<a href="/study/detail?studNo=' + board.studNo + '">' + board.title   + '</a>'))
							.append( $('<td>').text(board.createDate))
							.append( $('<td>').text(board.modifyDate))
							.append( $('<td>').text(board.hit))
							.append( $('<td>').text(board.ip))
							.appendTo('#user_list');
						} 
					});				
				} else if(resData.status == 500){
					alert(resData.message);
				}
				// 페이징
				$('#paging').empty();
				var naverPageUtil = resData.naverPageUtil;
				var paging = '<div>';
				// 이전 페이지
				if(page != 1) {
					paging += '<span class="lnk_enable2" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				// 페이지번호
				for(let p = naverPageUtil.beginPage; p <= naverPageUtil.endPage; p++) {
					if(p == page){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="lnk_enable2" data-page="'+ p +'">' + p + '</span>';
					}
				}
				// 다음 페이지
				if(page != naverPageUtil.totalPage){
					paging += '<span class="lnk_enable2" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging += '</div>';
				// 페이징 표시
				$('#paging').append(paging);
			}
		});
		});		
	}
  	
  	// 일반회원 다중탈퇴
	$(document).on('click','.btn_userRemove',function(){			
		if(confirm('선택한 회원을 탈퇴시킬까요?')){						
			let userNoList = '';
			for(let i = 0; i < $('.del-chk').length; i++){				
				if( $($('.del-chk')[i]).is(':checked')){
					userNoList += $($('.del-chk')[i]).val() + ',';
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
  	
  	// 스터디게시판 삭제
	$(document).on('click','.btn_studyRemove',function(){			
		if(confirm('선택한 게시판을 삭제할까요?')){						
			let studNoList = '';
			for(let i = 0; i < $('.del-chk').length; i++){				
				if( $($('.del-chk')[i]).is(':checked')){
					studNoList += $($('.del-chk')[i]).val() + ',';
				}
			}
			studNoList = studNoList.substr(0, studNoList.length -1);
			$.ajax({
				type :'delete',
				url : '/stud/' + studNoList,
				dataType : 'json',
				success : function(resData){
					if(resData.deleteResult > 0){
						alert('선택된 게시판이 삭제되었습니다.');
						fn_FreeBoardList();
					} else{
						alert('선택된 게시판이 삭제되지않았습니다.');
					}
				}
			});
		}
	});
  	
  	// 자유게시판 삭제
	$(document).on('click','.btn_freeRemove',function(){			
		if(confirm('선택한 게시판을 삭제할까요?')){						
			let boardNoList = '';
			for(let i = 0; i < $('.del-chk').length; i++){				
				if( $($('.del-chk')[i]).is(':checked')){
					boardNoList += $($('.del-chk')[i]).val() + ',';
				}
			}
			boardNoList = boardNoList.substr(0, boardNoList.length -1);
			console.log(boardNoList);
			$.ajax({
				type :'delete',
				url : '/frees/' + boardNoList,
				dataType : 'json',
				success : function(resData){
					if(resData.deleteResult > 0){
						alert('선택된 게시판이 삭제되었습니다.');
						fn_FreeBoardList();
					} else{
						alert('선택된 게시판이 삭제되지않았습니다.');
					}
				}
			});
		}
	});
  	// 코드게시판 삭제
	$(document).on('click','.btn_codeRemove',function(){			
		if(confirm('선택한 게시판을 삭제할까요?')){						
			let codeNoList = '';
			for(let i = 0; i < $('.del-chk').length; i++){				
				if( $($('.del-chk')[i]).is(':checked')){
					codeNoList += $($('.del-chk')[i]).val() + ',';
				}
			}
			codeNoList = codeNoList.substr(0, codeNoList.length -1);
			$.ajax({
				type :'delete',
				url : '/codes/' + codeNoList,
				dataType : 'json',
				success : function(resData){
					if(resData.deleteResult > 0){
						alert('선택된 게시판이 삭제되었습니다.');
						fn_FreeBoardList();
					} else{
						alert('선택된 게시판이 삭제되지않았습니다.');
					}
				}
			});
		}
	});
  	
  	// Qna게시판 삭제
	$(document).on('click','.btn_qnaRemove',function(){			
		if(confirm('선택한 게시판을 삭제할까요?')){						
			let qnaNoList = '';
			for(let i = 0; i < $('.del-chk').length; i++){				
				if( $($('.del-chk')[i]).is(':checked')){
					qnaNoList += $($('.del-chk')[i]).val() + ',';
				}
			}
			qnaNoList = qnaNoList.substr(0, qnaNoList.length -1);
			$.ajax({
				type :'delete',
				url : '/qna/' + qnaNoList,
				dataType : 'json',
				success : function(resData){
					if(resData.deleteResult > 0){
						alert('선택된 게시판이 삭제되었습니다.');
						fn_FreeBoardList();
					} else{
						alert('선택된 게시판이 삭제되지않았습니다.');
					}
				}
			});
		}
	});
	
	
	
