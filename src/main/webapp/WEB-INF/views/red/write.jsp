<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
#reason {
    padding-left: 0;
}


</style>
<script>

	/*
	// 신고
	function report(){
		
		// 유저가 동일한 게시글을 신고한 이력이 있는지 조회
		$.ajax({
			url: '${contextPath}/red/check.json',
			dataType:'json'
			data: {
				redNo: redNo,
				nickname: "${loginUser.nickname}"
			},
			success: function(rep){
				if(rep == null){ // 이력 없음
					
					// type이 1이면 게시글번호, type이 2면 댓글번호
		    		let type = $("#rpType").val();
    				let reportRefNo = "";
		    		
					if(type == 1){
						reportRefNo = ${b.boardNo};
					}else{
						reportRefNo = $("#refNo").val();
					}
					
		    		if($("#etcBtn").is(":checked")){
		    			$("#real").val($("#rpEtc").val());
		    		}
		    		
            		let value = $("#real").val();
            		
            		$.ajax({
            			url: "report.bo",
            			data: {
            				reportType: type,
            				reportRefNo: reportRefNo,
            				userNo: "${loginUser.userNo}",
            				reportContent: value
            			},
            			success: function(r){
            				if(r.result > 0){
            					
            					toast("신고가 접수되었습니다.");
            					
            					$(".btn-jycancle").click();
            					
            				}else{
            					console.log("신고 실패");
            				}
            			},error: function(){
            				console.log("신고 ajax 실패");
            			}
            		});
					
				}else{ // 이력 있음
					toast("이미 신고가 접수되었습니다.");
				
					$(".btn-jycancle").click();
					
				}
				
			},error: function(){
				console.log("신고 여부 ajax 실패");
			}
		});
		 
	}
	*/
    function closetab() {
        window.close();
    }
</script>
<body>
<div>

	<h1>신고하기</h1>
	<form id="frm_red" action="${contextPath}/study/sendred" method="post">
	<div>
		<span>신고자 ▷ 여기${study.nickname}</span>
	</div>
	<div>
		스터디번호 ▷ 여기${grpred.study.studNo}
	</div>
	<div>
		신고일자 ▷ 여기${study.stud_Date}
	</div>

	<div>
		<h2><label for="redContent">신고사유</label></h2>
		<ul id="reason">
			<li id="A">
				<div class="RA">
					<input type="radio" name="Rred" id="R1">
					<label for="R1">예정일자 지연</label>
				</div>
			</li>
			<li id="B">
				<div class="RB">
					<input type="radio" name="Rred" id="R2">
					<label for="R2">부적절한 주제</label>
				</div>
			</li>			
			<li id="C">
				<div class="RC">
					<input type="radio" name="Rred" id="R3">
					<label for="R3">폭언, 욕설, 혐오 발언</label>
				</div>
			</li>			
			<li id="D">
				<div class="RD">
					<input type="radio" name="Rred" id="R4">
					<label for="R4">스팸</label>
				</div>
			</li>
			
		</ul>
	</div>	
	
	<br>
	<br>
	
	<div>
		<button>작성완료</button>
		<input type="button" value="취소" id ="btn_back" onclick="closetab()">
	</div>
	
	</form>
	 			    	
</div>
</body>

</html>