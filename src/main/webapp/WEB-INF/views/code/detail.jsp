<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/css/base.css">

<jsp:include page="../layout/header.jsp">
   <jsp:param value="" name="title"/>
</jsp:include>

<body>
 <div class="cont-body">
         <!-- 페이지 내용 -->

        <form name="dataForm" id="dataForm" method="post" action="BD_selectBbsList.do">
            <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
            <input type="hidden" name="c_bbsCode" id="c_bbsCode" value="1039">
            <input type="hidden" name="c_pagePerPage" id="c_pagePerPage" value="10">
            <input type="hidden" name="c_pagingEndNum" id="c_pagingEndNum" value="10">
            <input type="hidden" name="c_bbscttSn" id="c_bbscttSn" value="20221215092703894">
            <input type="hidden" name="c_rowPerPage" id="c_rowPerPage" value="10">
            <input type="hidden" name="c_pagingStartNum" id="c_pagingStartNum" value="1">
            <input type="hidden" name="c_currPage" id="c_currPage" value="1">
            <input type="hidden" name="c_order" id="c_order" value="">
            <input type="hidden" name="password" id="password">
        </form>
        <div class="detail-area">
            <div class="title">
                ${question.cNo}
            </div>
            <div class="util">
                <span>${question}</span>
                <%-- <span class="date"><fmt:formatDate value="${question}" pattern="yyyy.M.d"/></span> --%>
                <span>내용 ${question}</span>
            </div>
            <div class="article">
                <div class="txt">
                    ${question}
                </div>
            </div>
        </div>

        <!-- 버튼 -->
        <div class="aligner" data-top="sm">
            <div class="left">
                <button type="button" class="btn" onclick="pwdPop('1039','20221215092703894','D');">삭제</button>
            </div>
            <div class="right">
                <button type="button" class="btn" onclick="pwdPop('1039','20221215092703894','U');">수정</button>
                <button type="button" class="btn" onclick="opList();">목록</button>
            </div>
        </div>
        <!— //버튼 —>

        <div class="docs-case">
            <div class="docs-value">
                <div class="inquiry-area">
                </div>
            </div>
        </div>
    </div>
</body>

</html>