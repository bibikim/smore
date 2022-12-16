<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<style type="text/css">
	.bg-light {
		background-color: #ffffff;
	}	
	a {
		text-decoration-line: none;
		cursor: pointer;
		color: black;
	}
</style>

<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

      <c:if test="${loginUser == null}">
    	<nav class="navbar navbar-light bg-light" >
		  	<a class="navbar-brand" href="/"><img alt="" src="${contextPath}/resources/images/logo.PNG" width="150px"></a>
			<ul class="nav justify-content-end">
				  <li class="nav-item">
				    <a class="nav-link active" href="${contextPath}/free/list">자게</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="${contextPath}/code/list">코게</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="${contextPath}/qna/list">큐게</a>
				  </li>
				    <li class="nav-item">
				    <a class="nav-link" href="${contextPath}/user/login/form" tabindex="-1" aria-disabled="true">login</a>
				  </li>
			</ul>
		</nav>
      </c:if>
	
	<c:if test="${loginUser ne null}">
	<div>
		
     	<div style="text-align: right"> 
     		<c:if test="${loginUser.id == 'admin'}">
		     	<a href="${contextPath}/admin/page">${loginUser.nickname} &nbsp; | &nbsp;&nbsp;</a>
	     	</c:if>
	     	<c:if test="${loginUser.id != 'admin'}">
	     		<a href="${contextPath}/user/mypage">${loginUser.nickname} &nbsp; | &nbsp;&nbsp;</a>
	     	</c:if>	
	     	<a href="${contextPath}/user/logout">로그아웃</a>
     	</div>
        <nav class="navbar navbar-light bg-light">
		  	<a class="navbar-brand" href="/"><img alt="" src="${contextPath}/resources/images/logo.PNG" width="150px"></a>
			<ul class="nav justify-content-end">
				  <li class="nav-item">
				    <a class="nav-link active" href="${contextPath}/free/list">자게</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="${contextPath}/code/list">코게</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="${contextPath}/qna/list">큐게</a>
				  </li>
			</ul>
		</nav>
	  </div>
     </c:if>
		