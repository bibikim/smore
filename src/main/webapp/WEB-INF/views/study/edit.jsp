<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<div>
	
	<h1>목록(전체 ${totalRecord}개)</h1>
	
	<div>
		<c:if test="${loginUser != null}">
			<input type="button" value="글 작성하기" onclick="location.href='/study/write'">
		</c:if>
	</div>
	
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>순번</td>
					<td>모임장</td>
					<td>제목</td>
					<td>개발 언어</td>
					<td>시작예정일</td>
					<td>조회수</td>
					<td>작성일</td>
				</tr>
			</thead>
	 		<tbody>
	 			<c:if test="${empty studyList}">
	 				<tr>
	 					<td colspan="7">게시물이 없습니다.</td>
	 				</tr>
	 			</c:if>
	 			
	 			<c:if test="${studyList ne null}">
		 			<c:forEach items="${studyList}" var="study">
		 				<tr>
							<td>${study.SNo}</td>
		 					<td>${study.nickname}</td>	
		 					<td><a href="/study/detail?SNo=${study.SNo}">${study.STitle}</a></td>
		 					<td>${study.SLang}</td>
		 					<td>${study.SDate}</td>		 					
		 					<td>${study.SHit}</td>
		 					<td><fmt:formatDate value="${study.SCreateDate}" pattern="yyyy.M.d"/></td>		 					
		 				</tr>			
		 			</c:forEach>
	 			</c:if>
	 		</tbody>
			<tfoot>
				<tr >
					<td colspan="7">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</div>

<script>
	
	// contextPath를 반환하는 자바스크립트 함수
	function getContextPath() {
		var begin = location.href.indexOf(location.origin) + location.origin.length;
		var end = location.href.indexOf("/", begin + 1);
		return location.href.substring(begin, end);
	}
	
	/*
	$(document).ready(function(){
		
		// summernote
		$('#content').summernote({
			width: 800,
			height: 400,
			lang: 'ko-KR',
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['link', 'picture', 'video']]
			],
			callbacks: {
				onImageUpload: function(files){
					// 동시에 여러 이미지를 올릴 수 있음
					for(let i = 0; i < files.length; i++) {
						// 이미지를 ajax를 이용해서 서버로 보낼 때 가상 form 데이터 사용 
						var formData = new FormData();
						formData.append('file', files[i]);  // 파라미터 file, summernote 편집기에 추가된 이미지가 files[i]임						
						// 이미지를 HDD에 저장하고 경로를 받아오는 ajax
						$.ajax({
							type: 'post',
							url: getContextPath() + '/study/uploadImage',
							data: formData,
							contentType: false,  // ajax 이미지 첨부용
							processData: false,  // ajax 이미지 첨부용
							dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
							success: function(resData){
								
								
									resData의 src 속성값이 ${contextPath}/load/image/aaa.jpg인 경우
									<img src="${contextPath}/load/image/aaa.jpg"> 태그가 만들어진다.
									
									mapping=${contextPath}/load/image/aaa.jpg인 이미지의 실제 위치는
									location=C:\\upload\\aaa.jpg이므로 이 내용을
									servlet-context.xml에서 resource의 mapping값과 location값으로 등록해 준다.
									(스프링에서 정적 자원 표시하는 방법은 servlet-context.xml에 있다.)
								
								$('#content').summernote('insertImage', resData.src);
								
								
									어떤 파일이 HDD에 저장되어 있는지 목록을 저장해 둔다.
									블로그를 등록할 때 써머노트에서 사용한 파일명도 함께 등록한다.
								
								$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.filesystem + '">'))
								
							}
						});  // ajax
					}  // for
				}
			}
		});
		*/		
		
		// 서브밋
		$('#frm_edit').submit(function(event){
			if($('#STitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			}
		});
		
	});
	
</script>


<div>

	<h1>작성 화면</h1>
	
	<form id="frm_edit" action="/study/modify" method="post">
	
		<input type="hidden" name="SNo" value="${study.SNo}">
	
		<div>
			<label for="title">제목</label>
			<input type="text" name="title" id="title" value="${study.STitle}">
		</div>
		
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content">${study.SContent}</textarea>				
		</div>
		
		<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움)
		<div id="summernote_image_list"></div>
		-->
		
		<div>
			<button>수정완료</button>
			<input type="button" value="목록" id="btn_list" onclick="location.href='/study/list'">
		</div>
		
	</form>
	
</div> 

</body>
</html>