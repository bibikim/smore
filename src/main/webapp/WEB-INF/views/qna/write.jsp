<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="새 글 작성" name="title"/>
</jsp:include>

<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/js/moment-with-locales.js"></script>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.css">
<link rel="stylesheet" type="text/css" href="../../../resources/css/free/write.css">
<script>
	
	$(document).ready(function(){
		
		var task = '<c:out value="${chkBtn}"/>';
		
		if(task == 'mod'){
			$("#frm_write").attr("action", "/qna/modify");
		}else{
			$("#frm_write").attr("action", "/qna/save");
			
		}
		
		var _html = '<c:out value="${question.content}"/>';
		$('#content').summernote('code', _html);
		
		//$('#content').summernote('pasteHTML', _html);
		
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			focus: true,
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['link', 'picture', 'video']]
			]
		});
		
		$('#btn_list').click(function(){
			location.href='/qna/list';	
		});
		
		
		
		$('#frm_write').submit(function(ev){
			if($('#title').val() == '') {
				alert('제목을 입력해주세요.')
				ev.preventDefault();
				return;
			}else if($('#content').val() == '') {
				alert('본문을 입력해주세요.')
				ev.preventDefault();
				return;
			}
			
		});
		
		
	});

</script>
</head>
<body>
   <div class="wr-wrapper">
		<div class="div-write">

           <form id="frm_write" method="post"
               class="form-horizontal">
			<input type="hidden" name="nickname" value="${loginUser.nickname}">
			<input type="hidden" name="qaNo" id="qaNo" value="${question.qaNo}">
               <div class="section">
                   <div class="table detail-type no-scroll" data-top="sm">
                       <table>
                           <caption>
                           </caption>
                           <colgroup class="table-col">
                               <col style="width: 10%">
                               <col style="width: 35%">
                               <col style="width: 15%">
                               <col style="*">
                           </colgroup>
                           <tbody>
                               <tr>
                                   <th scope="row" class="text-left"><span class="point-color-red"></span></th>
                                   <td colspan="3">
                                    	<div class="wr-title">
                                           <input type="text" id="title" name="title" value="${question.title}" placeholder="제목을 입력하세요." required style="width: 500px;"/>
                                       </div>
                                   </td>
                               </tr>
                               <tr>
                               		<th scope="row" class="text-left">비밀번호</th>
                                   	<td colspan="3">
                                       <div class="input expanded">
                                       		<c:choose>
                                       			<c:when test="${chkBtn eq 'mod' && question.pw ne 0}">
                                       				<input type="password" id="password" name="password" value="${question.pw}" maxlength="20"
                                               autocomplete="off" style="width: 500px;">
                                       			</c:when>
                                       			<c:otherwise>
                                       				<input type="password" id="password" name="password" maxlength="20"
                                               autocomplete="off" style="width: 500px;">
                                       			</c:otherwise>
                                       		</c:choose>
                                       </div>
                                   </td>
                               </tr>
                               <tr>
                                   <th scope="row" class="text-left"><span class="point-color-red"></span></th>
                                   <td colspan="3">
                                       <div class="textarea">
                                           <textarea id="content" name="content" cols="30" rows="10"
                                               required></textarea>
                                       </div>
                                       <div id="sumnote_image_list"></div>
                                   </td>
                               </tr>
                           </tbody>
                       </table>
                   </div>
               </div>

                <!-- 버튼  -->
               <div class="aligner" data-top="sm">
                   <div class="right">
                   	 <c:if test="${chkBtn eq 'mod'}">
                   	 	<button type="submit" class="btn btn-success">수정</button>
                   	 </c:if>
                     <c:if test="${chkBtn eq 'reg'}">
                  	 	<button type="submit" class="btn btn-success">등록</button>
                  	 </c:if>                
                       <button type="button" id="btn_list" class="btn btn-info">목록</button>                     
                   </div>
               </div>
               <!-- 버튼  -->
           </form>
       </div>

       <div class="docs-case">
           <div class="docs-value">
               <div class="inquiry-area">
               </div>
           </div>
       </div>
    </div>	
</body>
</html>
