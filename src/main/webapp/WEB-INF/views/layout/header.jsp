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
<script src="/resources/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/b9a2709031.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style type="text/css">
	.bg-light {
		background-color: #ffffff;
	}	
	
	a {
		text-decoration-line: none ;
		cursor: pointer;
		color: black;
	}
	
	.nav-link {
		color: rgba(0,0,0,.9) !important;
	}
	
	.navbar {
		display: block !important;
	}
	.navbar-brand {
		float: left;
	}
	.nav {
		float: right !important;
		margin-right: 4px;
	}
	
	.dropdown-menu {
		text-align: center !important;
		min-width: 1px !important;
	}
	
	.dropdown-item {
		padding: 3px 10px !important;
	}
	
</style>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<script>


</script>

	<c:if test="${loginUser == null}">
		<nav class="navbar navbar-light bg-light" >
			<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png" width="150px"></a>
			<ul class="nav justify-content-end">
				<li class="nav-item">
					<a class="nav-link active" href="/free/list">자유게시판</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/code/list">코드게시판</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/job/list">Jobs</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/qna/list">QnA</a>
				</li>
				<li class="nav-item">
				    <a class="nav-link" href="/user/login/form" tabindex="-1" aria-disabled="true">login</a>
				</li>
			</ul>
			<div style="clear: both;"></div>
		</nav>
	</c:if>
	
	<c:if test="${loginUser ne null}">
	<div>
    	<div style="text-align: right"> 
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="/"><img alt="" src="/resources/images/logo3.png" width="150px"></a>
				<ul class="nav justify-content-end">
					<li class="nav-item">
						<a class="nav-link active" href="/free/list">자유게시판</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="/code/list">코드게시판</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link" href="/job/list">Jobs</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="/qna/list">QnA</a>
					</li>

					<li class="nav-item dropdown">
			      
				    	<c:if test="${loginUser.id == 'admin'}">
				      		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          		${loginUser.nickname}
				        	</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          		<a class="dropdown-item" href="/admin/page">관리자페이지</a>
				          		<a class="dropdown-item" href="/user/logout">로그아웃</a>
				        	</div>
						</c:if>
			      
				      	<c:if test="${loginUser.id != 'admin'}">
				        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          		${loginUser.nickname}
				        	</a>
				        	<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				          		<a class="dropdown-item" href="/user/checkpw">My회원정보</a>
				          		<a class="dropdown-item" href="/user/mypage">My스터디</a>
				          		<a class="dropdown-item" href="/user/logout">로그아웃</a>
				        	</div>
						</c:if>
						
					</li>
				</ul>
				<div style="clear: both;"></div>
			  	<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
			    	
				</ul>
				</div>
			</nav>
		</div>
	</div>
	</c:if>
	
		